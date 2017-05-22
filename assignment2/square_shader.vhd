library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity square_shader is
    generic (WIDTH, HEIGHT : natural);
    port (
          retracing : in std_logic; -- can we get rid of this one or at least rename it to en?
          x : in std_logic_vector (9 downto 0); -- 640 = 10_1000_0000b
          y : in std_logic_vector (8 downto 0); -- 480 = 1_1110_0000b

          origin_x : natural range 0 to 639;
          origin_y : natural range 0 to 479;

          r, g, b : out std_logic_vector (3 downto 0)
    );
end entity square_shader;


architecture behavioral of square_shader is
    constant h_display  : integer := 640;
    constant v_display  : integer := 480;

begin
    process(retracing, x, y)
        variable x_int, y_int : natural;
    begin
        x_int := to_integer(unsigned(x));
        y_int := to_integer(unsigned(y));

        if retracing = '0' then -- i shouldnt need this, right?
            r <= x(9 downto 6);
            g <= y(8 downto 5);
            b <= "0000";
            if x = "0000000000" or y = "000000000" or x = "1001111111" or y = "111011111" then
                r <= "1111";
                g <= "1111";
                b <= "1111";
            end if;

            if  x_int >= origin_x and x_int < origin_x + WIDTH
            and y_int >= origin_y and y_int < origin_y + HEIGHT then
                r <= "1111";
                g <= "1111";
                b <= "1111";
            end if;
        end if;
    end process;
    --b <= "0101";
end architecture;


