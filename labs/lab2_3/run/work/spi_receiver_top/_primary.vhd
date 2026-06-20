library verilog;
use verilog.vl_types.all;
entity spi_receiver_top is
    generic(
        INPUT_W         : integer := 8;
        OUTPUT_W        : integer := 48
    );
    port(
        i_clk           : in     vl_logic;
        i_rstn          : in     vl_logic;
        i_sck           : in     vl_logic;
        i_ssn           : in     vl_logic;
        i_mosi          : in     vl_logic_vector(7 downto 0);
        o_data          : out    vl_logic_vector(47 downto 0);
        o_valid         : out    vl_logic
    );
end spi_receiver_top;
