module spi_receiver_top #(
    parameter INPUT_W  = 8,
    parameter OUTPUT_W = 48
)(
    input  logic        i_clk,
    input  logic        i_rstn,
    input  logic        i_sck,
    input  logic        i_ssn,
    input  logic [7:0]  i_mosi, 
    output logic [47:0] o_data, 
    output logic        o_valid
);

    // ВАЖНО: Объявляем внутренний сигнал для связи модулей
    logic shift_en; 

    // Исправлено: имена портов теперь в точности соответствуют edge_detector.sv
    edge_detector edge_inst (
        .clk(i_clk),
        .rstn(i_rstn),
        .sck(i_sck),
        .falling_edge(shift_en)
    );

    spi_counter #(
        .COUNT_MAX(OUTPUT_W / INPUT_W)
    ) count_inst (
        .i_clk(i_clk),
        .i_rstn(i_rstn),
        .i_ssn(i_ssn),
        .i_en(shift_en),
        .o_valid(o_valid)
    );

    shift_register #(
        .WIDTH(OUTPUT_W)
    ) shift_inst (
        .i_clk(i_clk),
        .i_rstn(i_rstn),
        .i_ssn(i_ssn),
        .i_en(shift_en),
        .i_data(i_mosi),
        .o_data(o_data)
    );

endmodule