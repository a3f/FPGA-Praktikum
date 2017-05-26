library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.color_util.all;

entity square_shader is
    generic (WIDTH, HEIGHT : natural);
    port (
          x : in std_logic_vector (9 downto 0); -- 640 = 10_1000_0000b
          y : in std_logic_vector (8 downto 0); -- 480 = 1_1110_0000b
			 retracing : in std_logic;
          origin_x : natural range 0 to 639;
          origin_y : natural range 0 to 479;

          r, g, b : out std_logic_vector (3 downto 0)
    );
end entity square_shader;


architecture behavioral of square_shader is
    constant h_display  : integer := 640;
    constant v_display  : integer := 480;

begin
    process(x, y)
        variable x_int, y_int : natural;
        variable color_tmp : rgb_t;

    begin
		if retracing = '1' then
			color_tmp := BLACK;
		else
        x_int := to_integer(unsigned(x));
        y_int := to_integer(unsigned(y));
		
        color_tmp.r := x(9 downto 6);
        color_tmp.g := y(8 downto 5);
        color_tmp.b := "0000";

        if x = "0000000000" or y = "000000000" or x = "1001111111" or y = "111011111" then
            color_tmp := WHITE;
        end if;

        if  x_int >= origin_x and x_int < origin_x + WIDTH
        and y_int >= origin_y and y_int < origin_y + HEIGHT then
           -- color_tmp := rgb_negate(color_tmp);
           -- Should be single color according to Aufgabenstellung
           color_tmp := BLUE;
        end if;
	 end if;
	         (r, g, b) <= color_tmp;
    end process;
end architecture;


