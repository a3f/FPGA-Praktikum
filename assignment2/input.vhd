library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity input is
    generic (X_MAX, Y_MAX : natural);
    port (
          clk : in std_logic;
          up, down, left, right : in std_logic;

          x : out natural range 0 to X_MAX;
          y : out natural range 0 to Y_MAX
    );
end entity input;


architecture behavioral of input is

    function clamp(i, min, max : integer) return natural is
    begin
        if i < min then
            return min;
        elsif i > max then
            return max;
        else
            return i;
        end if;
    end function;
	constant DELAY : natural := 100000;
	signal counter : natural := 0;
begin
    process(clk)
		variable curr_x : integer := 100;
		variable curr_y : integer := 200;
    begin
        if rising_edge(clk) then
				if counter < DELAY then
					counter <= counter + 1;
				else
					counter <= 0;
					
					if up    = '1' then curr_y := curr_y - 1; end if;
					if down  = '1' then curr_y := curr_y + 1; end if;
					if left  = '1' then curr_x := curr_x - 1; end if;
					if right = '1' then curr_x := curr_x + 1; end if;

					curr_x := clamp(curr_x, 0, X_MAX);
					curr_y := clamp(curr_y, 0, Y_MAX);

			  end if;
        end if;
		  	 x <= curr_x;
			 y <= curr_y;
    end process;
end architecture;



