// top_level_func.v
module top_level_func (
    input  [15:0] in,
    input  [2:0]  addr,
    output [5:0]  out
);

    reg [3:0] code;
    always @(*) begin
        code = 4'b0;
        if (in[0])      code = 4'd0;
        else if (in[1]) code = 4'd1;
        else if (in[2]) code = 4'd2;
        else if (in[3]) code = 4'd3;
        else if (in[4]) code = 4'd4;
        else if (in[5]) code = 4'd5;
        else if (in[6]) code = 4'd6;
        else if (in[7]) code = 4'd7;
        else if (in[8]) code = 4'd8;
        else if (in[9]) code = 4'd9;
        else if (in[10]) code = 4'd10;
        else if (in[11]) code = 4'd11;
        else if (in[12]) code = 4'd12;
        else if (in[13]) code = 4'd13;
        else if (in[14]) code = 4'd14;
        else if (in[15]) code = 4'd15;
    end

    wire x1 = code[0];
    wire x2 = code[1];
    wire x3 = code[2];
    wire x4 = code[3];

    wire func_y;
    logic_func lf (
        .x1(x1),
        .x2(x2),
        .x3(x3),
        .x4(x4),
        .y (func_y)
    );

    reg [5:0] out_reg;
    assign out = out_reg;
    always @(*) begin
        out_reg = 6'b0;
        if (addr < 6)
            out_reg[addr] = func_y;
    end

endmodule