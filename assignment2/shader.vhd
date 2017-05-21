library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shader is
    port (
          retracing : in std_logic; -- can we get rid of this one or at least rename it to en?
          x : in std_logic_vector (9 downto 0); -- 640 = 10_1000_0000b
          y : in std_logic_vector (8 downto 0); -- 480 = 1_1110_0000b

          r, g, b : out std_logic_vector (3 downto 0)
    );
end entity shader;


architecture behavioral of shader is
    constant h_display  : integer := 640;
    constant v_display  : integer := 480;

begin
    process(retracing, x, y)
    begin
        if retracing = '0' then -- i shouldnt need this, right?
            r <= "0000";
            g <= "0000";
            b <= "0000";
            if x = "0000000000" or y = "000000000" or x = "1001111111" or y = "111011111" then
                r <= "1111";
                g <= "1111";
                b <= "1111";
            end if;
        end if;
    end process;
    --b <= "0101";
end architecture;

