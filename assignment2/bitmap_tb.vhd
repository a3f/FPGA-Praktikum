library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use work.txt_util.all;

--  A testbench has no ports.
entity bitmap_tb is
    end bitmap_tb;

architecture behav of bitmap_tb is
   --  Declaration of the component that will be instantiated.
    component sync
    port (
         clk : in std_logic;
         hsync, vsync : out std_logic;
         retracing : buffer std_logic := '1'; -- maybe we don't need this?
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
    constant clk_rate   : natural := 25175000;
    constant clk_period : time := 1 sec / clk_rate;

    signal retracing : std_logic := '1';
    signal row : std_logic_vector (8 downto 0);
    signal col : std_logic_vector (9 downto 0);

    signal drawing : std_logic := '0';

    signal r, g, b : std_logic_vector (3 downto 0);
    begin
   --  Component instantiation.
        inst_sync:     sync     port map (clk, open, drawing, retracing, col, row);
        inst_gradient: gradient port map (retracing, col, row, r, g, b);


        clock: process
        begin
            clk <= '0'; wait for clk_period;
            clk <= '1'; wait for clk_period;
        end process;

        printer: process (clk, retracing, drawing)
        file fp: text open write_mode is "vga.pbm";

        function vtou16 ( a: std_logic_vector) return string is
            variable b : string (1 to a'length) := (others => NUL);
            variable stri : integer := 1; 
        begin
            for i in a'range loop
                b(stri) := std_logic'image(a((i)))(2);
                stri := stri+1;
            end loop;
            return b;
        end vtou16;
        variable wrote_header : boolean := false;
        begin
            if rising_edge(clk) then
                if retracing = '0' then
                    if drawing = '1' and not wrote_header then
                        write(fp, "P3 641 481 15 ");

                        wrote_header := true;
                    end if;


                write(fp,
                    --Character'Val(to_integer(unsigned(r & "0000"))) &
                    --Character'Val(to_integer(unsigned(g & "0000"))) &
                    --Character'Val(to_integer(unsigned(b & "0000")))
                    dstr(r) & " " & dstr(g) & " " & dstr(b) & " "
                );
                --assert false report "Reached " & str(i)  severity note;
                end if;

                if wrote_header and drawing = '0' then
                    assert false report "Frame Simulation Finished" severity failure;
                end if;
        end if;
    end process;
end behav;


