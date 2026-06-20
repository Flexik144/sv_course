`timescale 1ns/1ps

module tb_top_level_func;

    reg  [15:0] in;
    reg  [2:0]  addr;
    wire [5:0]  out;

    top_level_func dut (
        .in  (in),
        .addr(addr),
        .out (out)
    );

    // функция ожидаемого значения y
    function expected_y;
        input [3:0] code;
        reg x1, x2, x3, x4;
        begin
            x1 = code[0];
            x2 = code[1];
            x3 = code[2];
            x4 = code[3];
            expected_y = (x2 & x4) | (~x1 & x3 & ~x4) | (x2 & x3) | (~x3 & x4);
        end
    endfunction

    // функция ожидаемого выхода демультиплексора
    function [5:0] expected_out;
        input y;
        input [2:0] addr;
        begin
            expected_out = 6'b0;
            if (addr < 6)
                expected_out[addr] = y;
        end
    endfunction

    integer i, a;
    reg [3:0] exp_code;
    reg       exp_fy;
    reg [5:0] exp_vec;

    initial begin
        $display("==================================================");
        $display("    Testing top_level_func (encoder + logic_func + demux)");
        $display("==================================================");
        $display(" active_bit | addr | code | func_y | out_expected | out_actual | Status");
        $display("--------------------------------------------------");

        for (i = 0; i < 16; i = i + 1) begin
            in = 16'b0;
            in[i] = 1'b1;
            for (a = 0; a < 8; a = a + 1) begin
                addr = a;
                exp_code = i;
                exp_fy = expected_y(exp_code);
                exp_vec = expected_out(exp_fy, addr);
                #10;
                if (out === exp_vec) begin
                    $display("    in[%2d]=1    |  %2d  |  %2d  |   %b   |     %b       |     %b     |  OK", 
                             i, a, exp_code, exp_fy, exp_vec, out);
                end else begin
                    $display("    in[%2d]=1    |  %2d  |  %2d  |   %b   |     %b       |     %b     |  ERROR", 
                             i, a, exp_code, exp_fy, exp_vec, out);
                end
            end
        end

        // тест все нули
        in = 16'b0;
        for (a = 0; a < 8; a = a + 1) begin
            addr = a;
            #10;
            exp_fy = expected_y(4'b0);
            exp_vec = expected_out(exp_fy, addr);
            if (out === exp_vec)
                $display("    all zero    |  %2d  |  0  |   %b   |     %b       |     %b     |  OK", 
                         a, exp_fy, exp_vec, out);
            else
                $display("    all zero    |  %2d  |  0  |   %b   |     %b       |     %b     |  ERROR", 
                         a, exp_fy, exp_vec, out);
        end

        $display("==================================================");
        $display("Simulation finished.");
        $stop;
    end
endmodule