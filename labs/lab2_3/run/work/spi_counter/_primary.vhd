library verilog;
use verilog.vl_types.all;
entity spi_counter is
    generic(
        COUNT_MAX       : integer := 6
    );
    port(
        i_clk           : in     vl_logic;
        i_rstn          : in     vl_logic;
        i_ssn           : in     vl_logic;
        i_en            : in     vl_logic;
        o_valid         : out    vl_logic
    );
end spi_counter;
