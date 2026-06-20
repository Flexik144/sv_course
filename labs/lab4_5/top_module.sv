`timescale 1ns/1ps

module top_module (
    input  logic        CLOCK_50, // Входной кварцевый генератор 50 МГц (PIN_R8)
    input  logic [1:0]  KEY,      // KEY[0] - Сброс (rst_n), KEY[1] - Выбор режима
    output logic [7:0]  LED       // 8 бортовых светодиодов платы DE0-Nano
);

    // Внутренние сигналы соединения
    logic clk_140mhz;     // Быстрый тактовый сигнал от PLL
    logic rst_n;          // Сигнал сброса
    logic tick;           // Импульс длительностью в 1 такт clk каждые 0.45 сек
    
    logic [7:0] led_fixed; // Выход первого автомата
    logic       led_morse; // Выход автомата Морзе

    assign rst_n = KEY[0];

    // 1. Инициализация фазовращателя ALTPLL
    my_pll pll_inst (
        .inclk0 ( CLOCK_50 ),
        .c0     ( clk_140mhz )
    );

    localparam TICK_MAX = 63000000 - 1; 
    logic [25:0] tick_counter;

    always_ff @(posedge clk_140mhz or negedge rst_n) begin
        if (!rst_n) begin
            tick_counter <= 26'd0;
            tick         <= 1'b0;
        end else if (tick_counter == TICK_MAX) begin
            tick_counter <= 26'd0;
            tick         <= 1'b1; // Импульс-разрешение на 1 такт частоты 140 МГц
        end else begin
            tick_counter <= tick_counter + 26'd1;
            tick         <= 1'b0;
        end
    end

    // 3. Подключение Автомата №1 (Фиксированное перемигивание линеек)
    led_fixed_fsm fixed_fsm_inst (
        .clk       ( clk_140mhz ),
        .rst_n     ( rst_n ),
        .tick      ( tick ),
        .led_fixed ( led_fixed )
    );

    // 4. Подключение Автомата №2 (Код Морзе "XUN")
    morse_fsm morse_fsm_inst (
        .clk       ( clk_140mhz ),
        .rst_n     ( rst_n ),
        .tick      ( tick ),
        .led_morse ( led_morse )
    );

    // 5. Мультиплексор выбора режима
    always_comb begin
        if (!KEY[1]) begin
            // Если кнопка KEY[1] НАЖАТА: выводим код Морзе на LED[0], остальные тушим
            LED = {7'b0000000, led_morse};
        end else begin
            // Если кнопка KEY[1] ОТЖАТА: работает стандартная анимация перемигивания
            LED = led_fixed;
        end
    end

endmodule