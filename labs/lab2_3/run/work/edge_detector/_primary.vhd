library verilog;
use verilog.vl_types.all;
entity edge_detector is
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        sck             : in     vl_logic;
        falling_edge    : out    vl_logic
    );
end edge_detector;
