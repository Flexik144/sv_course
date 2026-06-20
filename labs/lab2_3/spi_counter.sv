module spi_counter #(
    parameter COUNT_MAX = 6 // Количество байт (48 бит / 8 бит = 6)
)(
    input  logic i_clk,
    input  logic i_rstn,
    input  logic i_ssn,
    input  logic i_en,    // Фронт SCK
    output logic o_valid
);
    logic [$clog2(COUNT_MAX):0] count;

    always_ff @(posedge i_clk) begin
        if (!i_rstn || i_ssn) begin
            count   <= '0;
            o_valid <= 1'b0;
        end else if (i_en) begin
            if (count == COUNT_MAX - 1) begin
                count   <= '0;
                o_valid <= 1'b1; // Финальный импульс готовности
            end else begin
                count   <= count + 1'b1;
                o_valid <= 1'b0;
            end
        end else begin
            o_valid <= 1'b0; // Удерживаем valid только 1 такт
        end
    end
endmodule