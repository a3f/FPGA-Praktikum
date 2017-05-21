-- for use with http://ericeastwood.com/lab/vga-simulator/
-- Back Porch X = 44
-- Back Porch Y = 30
-- @ 50 MHz
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use work.txt_util.all;

--  A testbench has no ports.
entity text_tb is
    end text_tb;

architecture behav of text_tb is
   --  Declaration of the component that will be instantiated.
    component sync
    port (
         clk : in std_logic;
         hsync, vsync : out std_logic;
         retracing : out std_logic := '0'; -- maybe we don't need this?
         col : out std_logic_vector (9 downto 0); -- 640 = 10_1000_0000b
         row : out std_logic_vector (8 downto 0) -- 480 = 1_1110_0000b
    );
    end component;

    component gradient
    port (
          retracing : in std_logic; -- can we get rid of this one?
          x : in std_logic_vector (9 downto 0); -- 640 = 10_1000_0000b
          y : in std_logic_vector (8 downto 0); -- 480 = 1_1110_0000b

          r, g, b : out std_logic_vector (3 downto 0)
    );
    end component;

   --  Specifies which entity is bound with the component.
    for inst_sync:     sync     use entity work.sync;
    for inst_gradient: gradient use entity work.gradient;

    signal clk : std_logic := '0';
    constant clk_rate   : natural := 100000000;
    constant clk_period : time := 1 sec / clk_rate;

    signal hsync, vsync, retracing : std_logic;
    signal row : std_logic_vector (8 downto 0);
    signal col : std_logic_vector (9 downto 0);

    signal r, g, b : std_logic_vector (3 downto 0);
    begin
   --  Component instantiation.
        inst_sync:     sync     port map (clk, hsync, vsync, retracing, col, row);
        inst_gradient: gradient port map (retracing, col, row, r, g, b);

        process
        begin
            clk <= '0'; wait for clk_period;
            clk <= '1'; wait for clk_period;
        end process;

        process (clk, retracing)
        file fp: text open write_mode is "vga.txt";

        function vtoa ( a: std_logic_vector) return string is
            variable b : string (1 to a'length) := (others => NUL);
            variable stri : integer := 1; 
        begin
            for i in a'range loop
                b(stri) := std_logic'image(a((i)))(2);
                stri := stri+1;
            end loop;
            return b;
        end vtoa;
        begin

            if rising_edge(clk) then

                write(fp, time'image(now));
                write(fp, ":");

                write(fp, " ");
                write(fp, str(hsync));

                write(fp, " ");
                write(fp, str(vsync));

                write(fp, " ");
                write(fp, str(r));

                write(fp, " ");
                write(fp, str(g));

                write(fp, " ");
                write(fp, str(b));

                write(fp, "" & Character'Val (10));

        end if;
    end process;
end behav;


