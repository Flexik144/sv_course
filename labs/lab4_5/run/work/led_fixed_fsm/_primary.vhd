library verilog;
use verilog.vl_types.all;
entity led_fixed_fsm is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        tick            : in     vl_logic;
        led_fixed       : out    vl_logic_vector(7 downto 0)
    );
end led_fixed_fsm;
