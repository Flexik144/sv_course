module shift_register #(
    parameter WIDTH = 48
)(
    input  logic             i_clk,
    input  logic             i_rstn,
    input  logic             i_ssn,    // Активный низкий
    input  logic             i_en,     // Сигнал на сдвиг (от детектора фронтов)
    input  logic [7:0]       i_data,
    output logic [WIDTH-1:0] o_data
);
    // Сброс при i_ssn == 1 гарантирует очистку данных между тестами
    always_ff @(posedge i_clk) begin
        if (!i_rstn || i_ssn) begin
            o_data <= '0;
        end else if (i_en) begin
            o_data <= {o_data[WIDTH-9:0], i_data};
        end
    end
endmodule