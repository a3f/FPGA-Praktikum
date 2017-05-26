library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--  A testbench has no ports.
entity vga_controller is
port(
                clkin, rst : in std_logic;
				 r, g, b : out std_logic_vector (3 downto 0);

				hsync, vsync : out std_logic
					 );
    end vga_controller;
architecture behav of vga_controller is
   --  Declaration of the component that will be instantiated.
    component sync
    port (
         clk : in std_logic;
         hsync, vsync : out std_logic;
         retracing : out std_logic;
         col : out std_logic_vector (9 downto 0); -- 640 = 10_1000_0000b
         row : out std_logic_vector (8 downto 0) -- 480 = 1_1110_0000b
    );
    end component;

    component square_shader
    generic (WIDTH, HEIGHT : natural);
    port (
          x : in std_logic_vector (9 downto 0); -- 640 = 10_1000_0000b
          y : in std_logic_vector (8 downto 0); -- 480 = 1_1110_0000b
         retracing : in std_logic;

          origin_x : natural range 0 to 639;
          origin_y : natural range 0 to 479;

          r, g, b : out std_logic_vector (3 downto 0)
    );
    end component;	



   --  Specifies which entity is bound with the component.
    for inst_sync:     sync     use entity work.sync;
    for inst_square_shader: square_shader use entity work.square_shader;

    signal retracing : std_logic;
    signal row : std_logic_vector (8 downto 0);
    signal col : std_logic_vector (9 downto 0);

    signal drawing : std_logic := '0';


    begin
   --  Component instantiation.
		  inst_sync:     sync     port map (clkin, hsync, vsync, retracing, col, row);
        inst_square_shader: square_shader
		  generic map (WIDTH => 64, HEIGHT => 48)
		  port map (col, row, retracing, 300, 300, r, g, b);
end behav;


