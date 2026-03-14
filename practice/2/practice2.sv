module practice2(
    input logic i_clk,
    input logic i_arst,
    input logic i_a, i_b, i_c,

    output logic o_y
);

logic a_ff, b_ff, c_ff, y_ff;

always_ff @(posedge i_clk) begin
    a_ff <= i_a;
    b_ff <= i_b;
    c_ff <= i_c;

    y_ff <= ~a_ff & ~b_ff & ~c_ff | a_ff & ~b_ff & ~c_ff | a_ff & ~b_ff & c_ff;
end

assign o_y = y_ff;

endmodule