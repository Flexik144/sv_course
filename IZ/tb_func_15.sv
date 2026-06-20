module tb_func_15;
    reg a, b, c, d, y; // logic -> reg
    reg clk = 0;
    
    always #5 clk = ~clk; // always_ff -> always

    func_15_reg u_func (
        .i_clk(clk),
        .a(a), .b(b), .c(c), .d(d),
        .y(y)
    );

    initial begin
        $display("Time | a b c d | y");
        for (int i = 0; i < 18; i++) begin
            {a, b, c, d} = i;
            @(posedge clk);
            #1;
            $display("%4t | %1b%1b%1b%1b | %1b", $time, a, b, c, d, y);
        end
        $stop;
    end
endmodule