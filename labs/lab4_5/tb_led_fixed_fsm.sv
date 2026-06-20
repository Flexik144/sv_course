`timescale 1ns/1ps

module tb_led_fixed_fsm;

    // Сигналы для подключения к тестируемому модулю
    logic       clk;
    logic       rst_n;
    logic       tick;
    logic [7:0] led_fixed;

    // Инициализация тестируемого автомата (DUT)
    led_fixed_fsm dut (
        .clk       (clk),
        .rst_n     (rst_n),
        .tick      (tick),
        .led_fixed (led_fixed)
    );

    // Генерация тактового сигнала (период 7.14 нс соответствует частоте 140 МГц)
    always begin
        clk = 0; #3.57;
        clk = 1; #3.57;
    end

    // Генератор редких тиков (имитируем tick раз в 4 такта clk для ускорения симуляции)
    logic [1:0] tick_cnt;
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            tick_cnt <= 0;
            tick <= 0;
        end else begin
            if (tick_cnt == 2'd3) begin
                tick_cnt <= 0;
                tick <= 1;
            end else begin
                tick_cnt <= tick_cnt + 1;
                tick <= 0;
            end
        end
    end

    // Сценарий симуляции
    initial begin
        rst_n = 0; // Активируем сброс
        #20;
        rst_n = 1; // Снимаем сброс

        // Даем автомату поработать несколько циклов переключения
        #200;

        $display("Симуляция завершена успешно.");
        $stop; // Остановка симуляции
    end

endmodule