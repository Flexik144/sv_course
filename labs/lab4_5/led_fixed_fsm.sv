`timescale 1ns/1ps

module led_fixed_fsm (
    input  logic       clk,       // Тактовая частота 140 МГц
    input  logic       rst_n,     // Асинхронный сброс (активный 0)
    input  logic       tick,      // Разрешение счета (импульс раз в 0.45 сек)
    output logic [7:0] led_fixed  // Выход на 8 светодиодов
);

    // Определение состояний: 1 стартовое/сбросовое и 9 шагов анимации
    typedef enum logic [3:0] {
        S_RST = 4'd0,
        S0    = 4'd1,
        S1    = 4'd2,
        S2    = 4'd3,
        S3    = 4'd4,
        S4    = 4'd5,
        S5    = 4'd6,
        S6    = 4'd7,
        S7    = 4'd8,
        S8    = 4'd9
    } state_t;

    state_t current_state, next_state;

    // 1. Блок памяти автомата
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            current_state <= S_RST;
        else if (tick)
            current_state <= next_state;
    end

    // 2. Логика переходов в следующее состояние
    always_comb begin
        case (current_state)
            S_RST:   next_state = S0;    // После выхода из сброса начинаем с шага 0
            S0:      next_state = S1;
            S1:      next_state = S2;
            S2:      next_state = S3;
            S3:      next_state = S4;
            S4:      next_state = S5;
            S5:      next_state = S6;
            S6:      next_state = S7;
            S7:      next_state = S8;
            S8:      next_state = S0;    // Зацикливаем анимацию обратно на шаг 0
            default: next_state = S_RST;
        endcase
    end

    always_comb begin
        case (current_state)
            S_RST:   led_fixed = 8'b01111111; // Комбинация при сбросе (rst)
            S0:      led_fixed = 8'b11000000; // Шаг 0
            S1:      led_fixed = 8'b10100000; // Шаг 1
            S2:      led_fixed = 8'b10010000; // Шаг 2
            S3:      led_fixed = 8'b10001000; // Шаг 3
            S4:      led_fixed = 8'b10000100; // Шаг 4
            S5:      led_fixed = 8'b10000010; // Шаг 5
            S6:      led_fixed = 8'b10000001; // Шаг 6
            S7:      led_fixed = 8'b10101010; // Шаг 7
            S8:      led_fixed = 8'b10000000; // Шаг 8
            default: led_fixed = 8'b01111111;
        endcase
    end

endmodule