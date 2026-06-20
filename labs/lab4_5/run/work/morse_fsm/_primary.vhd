library verilog;
use verilog.vl_types.all;
entity morse_fsm is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        tick            : in     vl_logic;
        led_morse       : out    vl_logic
    );
end morse_fsm;
