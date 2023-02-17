library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc is
    port ( 
        clk: in std_logic;
        rst_n: in std_logic;
        mem_rdy: in std_logic;
        pc_enable: in std_logic;
        pc_in: in std_logic_vector(10 downto 0);
        pc_out: out std_logic_vector(10 downto 0)
        );
end pc;

architecture beh of pc is
begin

    process(clk, rst_n)
    begin
        if rst_n = '0' then
            pc_out <= (others => '0');
        elsif clk'event and clk = '1' and mem_rdy = '1' then 
            if pc_enable = '1' then
                pc_out <= pc_in;
            end if;
        end if;
    end process;

end beh;