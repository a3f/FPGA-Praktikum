-- A 4 bit LFSR
-- https://en.wikipedia.org/wiki/Linear-feedback_shift_register

library ieee;
use ieee.std_logic_1164.all;

entity lfsr is
    port (
          clk: in std_logic;
          en, rst : in std_logic;
          number : out std_logic_vector (3 downto 0)
    );
end entity;

architecture rtl of lfsr is
    signal linear_feedback : std_logic;
    constant seed : std_logic_vector(3 downto 0) := "0001"; -- abuse me ;)
    signal number_tmp : std_logic_vector (3 downto 0) := seed;

begin
    process (clk, rst)
        variable tmp : std_logic := '0';
        impure function lfsr_cycle(number_tmp : std_logic_vector) return std_logic_vector is
        begin
            tmp := number_tmp(2) xor number_tmp(0);
            return tmp & number_tmp(3 downto 1);
        end function;
    begin
        if rising_edge(clk) then
            if rst = '1' then
                number_tmp <= seed;
            elsif en = '1' then
                number_tmp <= lfsr_cycle(number_tmp);
            end if;
        end if;
    end process;
        number <= number_tmp;
end architecture;
