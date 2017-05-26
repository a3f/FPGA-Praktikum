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

    component shader
    port (
          x : in std_logic_vector (9 downto 0); -- 640 = 10_1000_0000b
          y : in std_logic_vector (8 downto 0); -- 480 = 1_1110_0000b
         retracing : in std_logic;

          r, g, b : out std_logic_vector (3 downto 0)
    );
    end component;  



   --  Specifies which entity is bound with the component.
    for inst_sync:     sync     use entity work.sync;
    for inst_shader: shader use entity work.shader;

    signal retracing : std_logic;
    signal row : std_logic_vector (8 downto 0);
    signal col : std_logic_vector (9 downto 0);

    signal drawing : std_logic := '0';


    begin
   --  Component instantiation.
          inst_sync:     sync     port map (clkin, hsync, vsync, retracing, col, row);
        inst_shader: shader
        port map (col, row, retracing, r, g, b);
end behav;

