module func_15_reg (
    input  logic i_clk,
    input  logic a, b, c, d,
    output logic y
);
    logic a_r, b_r, c_r, d_r;
    logic y_next;

    assign y_next = (b_r | d_r) & (c_r | d_r) | (c_r | a_r) & (d_r | b_r);

    always_ff @(posedge i_clk) begin
        a_r <= a;
        b_r <= b;
        c_r <= c;
        d_r <= d;
        y   <= y_next;
    end
endmodule