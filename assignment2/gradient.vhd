library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gradient is
    port (
          retracing : in std_logic; -- can we get rid of this one or at least rename it to en?
          x : in std_logic_vector (9 downto 0); -- 640 = 10_1000_0000b
          y : in std_logic_vector (8 downto 0); -- 480 = 1_1110_0000b

          r, g, b : out std_logic_vector (3 downto 0)
    );
end entity gradient;


architecture behavioral of gradient is
    constant h_display  : integer := 640;
    constant v_display  : integer := 480;

begin
    process(retracing, x, y)
    begin
        if retracing = '0' then -- i shouldnt need this, right?
            --x_vec := std_logic_vector(to_unsigned(x, x_vec'length));
            --y_vec := std_logic_vector(to_unsigned(x, y_vec'length));

            --r <= x_vec(x_vec'left downto x_vec'left - r'length);
            --g <= x_vec(y_vec'left downto y_vec'left - g'length);
            r <= x(9 downto 6);
            g <= y(8 downto 5);
            --if y(5) = '1' then
                --b <= "1111";
                --r <= "0000";
                --g <= "0000";
            --else
                --r <= "1111";
                --g <= "1111";
                --b <= "1111";
            --end if;
            --if x = "0000000000" then
                --r <= "1111";
                --g <= "0000";
                --b <= "0000";
            --end if;
        end if;
    end process;
    b <= "0101";
end architecture;

