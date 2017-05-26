library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--  A testbench has no ports.
entity vga_controller is
port(
            clkin, rst : in std_logic;
				r, g, b : out std_logic_vector (3 downto 0);

				hsync, vsync : out std_logic;
				
				up_button, down_button, left_button, right_button : in std_logic
		);
    end vga_controller;
architecture struct of vga_controller is
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


    component input
    generic (X_MAX, Y_MAX : natural);
    port (
          clk : in std_logic;
          up, down, left, right : in std_logic;

          x : out integer range 1 to X_MAX - 1;
          y : out natural range 1 to Y_MAX - 1
	 );
    end component;	

   --  Specifies which entity is bound with the component.
    for inst_sync:     sync     use entity work.sync;
    for inst_square_shader: square_shader use entity work.square_shader;
    for inst_input: input use entity work.input;
    
	 signal retracing : std_logic;
    signal row : std_logic_vector (8 downto 0);
    signal col : std_logic_vector (9 downto 0);

   
	signal square_x, square_y : natural;
	constant X_MAX : natural := 640;
	constant Y_MAX : natural := 480;
	constant SQUARE_WIDTH  : natural := 64;
	constant SQUARE_HEIGHT : natural := 48;
    begin
   --  Component instantiation.
		  inst_sync:     sync     port map (clkin, hsync, vsync, retracing, col, row);
        inst_input: input
        generic map (X_MAX - SQUARE_WIDTH, Y_MAX - SQUARE_HEIGHT)
		  port map (clkin, up_button, down_button, left_button, right_button, square_x, square_y);
		  inst_square_shader: square_shader
		  generic map (SQUARE_WIDTH, SQUARE_HEIGHT)
		  port map (col, row, retracing, square_x, square_y, r, g, b);
	
end struct;


