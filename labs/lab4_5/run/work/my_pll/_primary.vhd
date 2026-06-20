library verilog;
use verilog.vl_types.all;
entity my_pll is
    port(
        inclk0          : in     vl_logic;
        c0              : out    vl_logic
    );
end my_pll;
