library ieee;
use ieee.std_logic_1164.all;
use work.txt_util.all;

entity lfsr_tb is
    end lfsr_tb;

architecture bench of lfsr_tb is

    component lfsr
        port (
              clk: in std_logic;
              en, rst : in std_logic;
              number : out std_logic_vector (3 downto 0)
        );
    end component;

    signal clk: std_logic;
    signal en, rst: std_logic;
    signal number: std_logic_vector(3 downto 0);

    for mapping: lfsr use entity work.lfsr;
begin

    mapping: lfsr port map(clk, en, rst, number);

    clock: process
    begin
        clk <= '0'; wait for 50 ns;
        clk <= '1'; wait for 50 ns;
    end process;

    reset: process(clk)
        variable cycles : natural := 1000;
    begin
        rst <= '0';
        en <= '1';
        if rising_edge(clk) then
            cycles := cycles - 1;
            if cycles = 0 then
                assert false report "Finished Simulation" severity failure;
            end if;
        end if;
    end process;

end bench;
