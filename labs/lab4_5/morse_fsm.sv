`timescale 1ns/1ps

module morse_fsm (
    input  logic clk,        // Тактовый сигнал 140 МГц
    input  logic rst_n,      // Асинхронный сброс (активный уровень - низкий)
    input  logic tick,       // Внешний сигнал разрешения шага (раз в 0.45 сек)
    output logic led_morse   // Выход на светодиод
);

    localparam logic [35:0] MORSE_SEQ = 36'b0000000_10111_000_1110101_000_11101010111;
    
    // Счетчик состояний (индекс массива)
    logic [5:0] state_idx;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state_idx <= 0;
        end else if (tick) begin
            if (state_idx == 35)
                state_idx <= 0; // Зацикливаем передачу слова
            else
                state_idx <= state_idx + 1;
        end
    end

    // Непосредственный вывод текущего бита на светодиод
    assign led_morse = MORSE_SEQ[state_idx];

endmodule