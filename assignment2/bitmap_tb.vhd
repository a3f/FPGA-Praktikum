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
         retracing : out std_logic := '1'; -- maybe we don't need this?
         col : out std_logic_vector (9 downto 0); -- 640 = 10_1000_0000b
         row : out std_logic_vector (8 downto 0) -- 480 = 1_1110_0000b
    );
    end component;

    component square_shader
    generic (WIDTH, HEIGHT : natural);
    port (
          retracing : in std_logic; -- can we get rid of this one?
          x : in std_logic_vector (9 downto 0); -- 640 = 10_1000_0000b
          y : in std_logic_vector (8 downto 0); -- 480 = 1_1110_0000b

          origin_x : natural range 0 to 639;
          origin_y : natural range 0 to 479;

          r, g, b : out std_logic_vector (3 downto 0)
    );
    end component;

   --  Specifies which entity is bound with the component.
    for inst_sync:     sync     use entity work.sync;
    for inst_square_shader: square_shader use entity work.square_shader;

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
        inst_square_shader: square_shader
        generic map (WIDTH => 64, HEIGHT => 48)
        port map (retracing, col, row, 100, 100, r, g, b);


        clock: process
        begin
            clk <= '0'; wait for clk_period;
            clk <= '1'; wait for clk_period;
        end process;

        printer: process (clk, retracing, drawing)
        file fp: text open write_mode is "vga.ppm";

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
        function octet ( v: std_logic_vector) return string is
        begin
            if v = "UUUU" then
                return "" & Character'Val(0);
            end if;
            return "" & Character'Val(to_integer(unsigned(v & "0000")));
        end octet;
        variable wrote_header : boolean := false;
        begin
            if rising_edge(clk) then
                if retracing = '0' then
                    if drawing = '1' and not wrote_header then
                        -- or P3 for the legacy format 
                        write(fp, "P6 640 480 255 ");

                        wrote_header := true;
                    end if;


                write(fp,
                    octet(r) & octet(g) & octet(b)
                    -- Legacy format is in ASCII:
                    -- dstr(r) & " " & dstr(g) & " " & dstr(b) & " "
                );
                --assert false report "Reached " & str(i)  severity note;
                end if;

                if wrote_header and drawing = '0' then
                    assert false report "Frame Simulation Finished" severity failure;
                end if;
        end if;
    end process;
end behav;


