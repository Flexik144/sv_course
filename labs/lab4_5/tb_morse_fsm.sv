`timescale 1ns/1ps

module tb_morse_fsm;

    // Сигналы для подключения к автомату
    logic clk;
    logic rst_n;
    logic tick;
    logic led_morse;

    // Инициализация тестируемого автомата Морзе (DUT)
    morse_fsm dut (
        .clk       (clk),
        .rst_n     (rst_n),
        .tick      (tick),
        .led_morse (led_morse)
    );

    // Генерация тактовой частоты 140 МГц (период ~7.14 нс)
    always begin
        clk = 0; #3.57;
        clk = 1; #3.57;
    end

    // Имитация тиков (каждые 2 такта clk для быстрой симуляции в ModelSim)
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            tick <= 0;
        else
            tick <= ~tick;
    end

    // Сценарий работы симулятора
    initial begin
        rst_n = 0; // Сброс системы
        #15;
        rst_n = 1; // Запуск работы

        // Симулируем 600 нс, чтобы автомат успел пройти все 36 состояний
        #600;

        $display("Симуляция автомата Морзе завершена успешно.");
        $stop;
    end

endmodule