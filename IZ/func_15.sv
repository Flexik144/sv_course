module func_15 (
    input  logic a, b, c, d,
    output logic y
);
    assign y = (b | d) & (c | d) | (c | a) & (d | b);
endmodule