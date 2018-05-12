----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:15:28 11/24/2014 
-- Design Name: 
-- Module Name:    top_level - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_level is
port ( Clk  : in std_logic;
       player_input : in std_logic_vector (4 downto 0);
		 paused 		  : in std_logic;
		 rgb  : out std_logic_vector (7 downto 0);
		 HS   : out std_logic;
		 VS   : out std_logic;
		 LD7,
		 LD6,
		 LD5  : out std_logic;
		 Segs : out  std_logic_vector (7 downto 0);
	    AN   : out  std_logic_vector (3 downto 0));
end top_level;

architecture Behavioral of top_level is

component game_logic is
   port ( Clk          : in std_logic;
	       player_input : in std_logic_vector (4 downto 0);
			 paused 		  : in std_logic;
			 --External signal for current_player_location, goes to another module that "draws" the player on screen.
			 player_loc   : out std_logic_vector (3 downto 0);
			 --External signal for current_h_player_location, goes to another module that "draws" the player on screen.
			 h_player_loc : out STD_LOGIC_VECTOR (1 downto 0);	
			 --External signals for locations of obstacles that will be drawn by another module.
			 obst_locs_1  : out std_logic_vector (31 downto 0);
			 obst_locs_2  : out std_logic_vector (31 downto 0);
			 obst_locs_3  : out std_logic_vector (31 downto 0);
			 obst_locs_4  : out std_logic_vector (31 downto 0);
			   level      : out std_logic_vector (2 downto 0);
			   score      : out std_logic_vector (7 downto 0);
		  top_lives_left : out std_logic_vector (1 downto 0);
		  top_level_dead : out std_logic);
	       
end component;

component vga_controller_640_60 is
   port ( rst         : in std_logic;
          pixel_clk   : in std_logic;
          HS          : out std_logic;
          VS          : out std_logic;
          hcount      : out std_logic_vector(10 downto 0);
          vcount      : out std_logic_vector(10 downto 0);
          blank       : out std_logic);
end component;

component clk_wiz_v3_6 is
   port (CLK_IN1           : in     std_logic;
         CLK_OUT1          : out    std_logic);
end component;

component graphics is
   port (pixel_clk    	: in std_logic;
	      player_loc   	: in STD_LOGIC_VECTOR (3 downto 0);
			h_player_loc 	: in STD_LOGIC_VECTOR (1 downto 0);
         obst_locs_1,
         obst_locs_2,
         obst_locs_3,
         obst_locs_4  	: in STD_LOGIC_VECTOR (31 downto 0);
			top_lives_left : in std_logic_vector (1 downto 0);
			level 		 	: in std_logic_vector (2 downto 0);
			score 		 	: in std_logic_vector (7 downto 0);
			dead         	: in std_logic;
	      hcount    	 	: in std_logic_vector (10 downto 0);
			vcount    	 	: in std_logic_vector (10 downto 0);
         rgb    		 	: out std_logic_vector (7 downto 0));
end component;

--This component is used to display the player's score on the seven-segment displays on the Nexys 3 board.
component sseg_dec is
   port (   ALU_VAL : in std_logic_vector(7 downto 0); 
					SIGN : in std_logic;
				  VALID : in std_logic;
                CLK : in std_logic;
            DISP_EN : out std_logic_vector(3 downto 0);
           SEGMENTS : out std_logic_vector(7 downto 0));
end component;

signal pixel_clk : std_logic;

--The "global reset" signal for the game. When it's high,
--all game components should be reset to their initial state.
signal reset : std_logic := '0';

signal level : std_logic_vector (2 downto 0);
signal score : std_logic_vector (7 downto 0);
signal top_lives_left : std_logic_vector (1 downto 0);
signal top_level_dead : std_logic := '0';

--These internal signals come out of the game_logic module and go into the graphics module, which then
--decides which pixels will be which colors every time the screen refreshes (60 times per second).
signal player_loc : std_logic_vector (3 downto 0) := "0100";
signal h_player_loc : std_logic_vector (1 downto 0) := "00";

signal obstacles_to_draw_1,
       obstacles_to_draw_2,
		 obstacles_to_draw_3,
		 obstacles_to_draw_4 : std_logic_vector (31 downto 0);
		 
signal HORIZCOUNT, VERTICOUNT : std_logic_vector (10 downto 0);

--This signal is will always be zero, because we're not using it in our game design; it's part of the standard Digilent VGA controller.
signal blank : std_logic := '0';

--The following signals are for the sseg_dec module. They are only initialized here to satisfy the port requirements for the pre-built sseg_dec VHDL.
signal sign : std_logic := '0';
signal valid : std_logic := '1';

begin

 
 pixel_clock : clk_wiz_v3_6
 port map ( CLK_IN1  => Clk,
            CLK_OUT1 => pixel_clk);
 

 game_mechanics : game_logic
 port map ( Clk => pixel_clk,
            player_input => player_input,
				h_player_loc => h_player_loc,
				paused => paused,
            player_loc   => player_loc,
				obst_locs_1  => obstacles_to_draw_1,
				obst_locs_2  => obstacles_to_draw_2,
				obst_locs_3  => obstacles_to_draw_3,
				obst_locs_4  => obstacles_to_draw_4,
				     level   => level,
				     score   => score,
			top_lives_left  => top_lives_left,
			top_level_dead  => top_level_dead);
				
 sync_module : vga_controller_640_60
 port map ( rst => reset,
            pixel_clk => pixel_clk,
				HS  => HS,
				VS  => VS,
				hcount => HORIZCOUNT,
				vcount => VERTICOUNT,
				blank => blank); --tie blank to zero, because we're not using that signal in our game
	
 draw_the_boxes : graphics
 port map ( pixel_clk => pixel_clk,
            player_loc  => player_loc,
				h_player_loc => h_player_loc,
            obst_locs_1 => obstacles_to_draw_1,
				obst_locs_2 => obstacles_to_draw_2,
				obst_locs_3 => obstacles_to_draw_3,
				obst_locs_4 => obstacles_to_draw_4,
				level => level,				
				score => score,				
				top_lives_left => top_lives_left ,
				dead        => top_level_dead,
				hcount      => HORIZCOUNT,
				vcount      => VERTICOUNT,
				rgb         => rgb);				
 
score_disp : sseg_dec
 port map (     ALU_VAL => score,
					    SIGN => sign,
						VALID => valid,
                    CLK => pixel_clk,
                DISP_EN => AN,
               SEGMENTS => Segs);

--The number of LEDs lit indicates the number of lives the player has left (starts with 3).
lives_on_LEDs : process (top_lives_left)
begin
   if (top_lives_left = "11") then
      LD7 <= '1';
      LD6 <= '1';
      LD5 <= '1';
	elsif (top_lives_left = "10") then
	   LD7 <= '1';
      LD6 <= '1';
      LD5 <= '0';
	elsif (top_lives_left = "01") then
	   LD7 <= '1';
      LD6 <= '0';
      LD5 <= '0';
	else
	   LD7 <= '0';
      LD6 <= '0';
      LD5 <= '0';
	end if;
end process lives_on_LEDs;


end Behavioral;