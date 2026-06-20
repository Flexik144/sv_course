module tb_logic_func();
    logic x1,x2,x3,x4, y;
    logic [3:0] vec;
    logic expected; // ожидаемое значение из таблицы истинности
    logic error;
    
    logic_func dut (.*);
    
    initial begin
        $dumpfile("wave.vcd"); $dumpvars;
        for (int i=0; i<16; i++) begin
            {x1,x2,x3,x4} = i;
            #10;
            // здесь нужно сравнить y с expected (заранее вычисленным)
            // либо вычислить expected внутри тестбенча по формуле
        end
        $finish;
    end
endmodule