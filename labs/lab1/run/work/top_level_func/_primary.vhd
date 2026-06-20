library verilog;
use verilog.vl_types.all;
entity top_level_func is
    port(
        \in\            : in     vl_logic_vector(15 downto 0);
        addr            : in     vl_logic_vector(2 downto 0);
        \out\           : out    vl_logic_vector(5 downto 0)
    );
end top_level_func;
