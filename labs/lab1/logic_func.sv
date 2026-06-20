module logic_func (
    input  logic x1, x2, x3, x4,
    output logic y
);
    assign y = (x2 & x4) | (~x1 & x3 & ~x4) | (x2 & x3) | (~x3 & x4);
endmodule