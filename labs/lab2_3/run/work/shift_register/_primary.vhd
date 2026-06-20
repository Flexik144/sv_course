library verilog;
use verilog.vl_types.all;
entity shift_register is
    generic(
        WIDTH           : integer := 48
    );
    port(
        i_clk           : in     vl_logic;
        i_rstn          : in     vl_logic;
        i_ssn           : in     vl_logic;
        i_en            : in     vl_logic;
        i_data          : in     vl_logic_vector(7 downto 0);
        o_data          : out    vl_logic_vector
    );
end shift_register;
