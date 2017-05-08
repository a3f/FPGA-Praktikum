library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--  A testbench has no ports.
entity counter_tb is
end;

architecture tb of counter_tb is
   --  Declaration of the component that will be instantiated.
    component counter is
        port (clk : in std_logic; pulse : out std_logic);
    end component;

   --  Specifies which entity is bound with the component.
    for instance: counter use entity work.counter_e;
    signal clk, pulse : std_logic;
begin
        instance: counter port map (clk => clk, pulse => pulse);
        clk_proc: process
        begin

            clk <= '0'; wait for 3 ns; clk <= '1'; wait for 1 ns;
            assert pulse = '0' report "Expected no pulse" severity error;

            clk <= '0'; wait for 1 ns; clk <= '0'; wait for 1 ns;
            clk <= '1'; wait for 1 ns; clk <= '1'; wait for 1 ns;
            assert pulse = '0' report "Expected no pulse" severity error;

            clk <= '0'; wait for 1 ns; clk <= '1'; wait for 1 ns;
            assert pulse = '0' report "Expected no pulse" severity error;

            clk <= '0'; wait for 1 ns; clk <= '1'; wait for 1 ns;
            assert pulse = '0' report "Expected no pulse" severity error;

            clk <= '0'; wait for 2 ns; clk <= '1'; wait for 5 ns;
            assert pulse = '0' report "Expected a pulse" severity error;

            clk <= '0'; wait for 1 ns; clk <= '1'; wait for 2 ns;
            assert pulse = '1' report "Expected a pulse" severity error;

            clk <= '0'; wait for 1 ns; clk <= '1'; wait for 9 ns;
            assert pulse = '0' report "Expected no pulse" severity error;

            clk <= '0'; wait for 2 ns; clk <= '1'; wait for 1 ns;
            assert pulse = '1' report "Expected a pulse" severity error;

            clk <= '0'; wait for 2 ns; clk <= '1'; wait for 1 ns;
            assert pulse = '0' report "Expected no pulse" severity error;

            clk <= '0'; wait for 2 ns; clk <= '1'; wait for 1 ns;
            assert pulse = '1' report "Expected a pulse" severity error;

            wait;

        end process;
end tb;

