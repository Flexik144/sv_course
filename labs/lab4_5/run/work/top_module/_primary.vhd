library verilog;
use verilog.vl_types.all;
entity top_module is
    port(
        CLOCK_50        : in     vl_logic;
        KEY             : in     vl_logic_vector(1 downto 0);
        LED             : out    vl_logic_vector(7 downto 0)
    );
end top_module;
