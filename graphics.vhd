----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:33:48 11/24/2014 
-- Design Name: 
-- Module Name:    graphics - Behavioral 
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
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity graphics is
    Port ( pixel_clk   : in STD_LOGIC;
	        player_loc  : in STD_LOGIC_VECTOR (3 downto 0);
           obst_locs_1,
           obst_locs_2,
           obst_locs_3,
           obst_locs_4 : in STD_LOGIC_VECTOR (31 downto 0);
			  dead        : in STD_LOGIC;
			  hcount      : in STD_LOGIC_VECTOR (10 downto 0);
			  vcount      : in STD_LOGIC_VECTOR (10 downto 0);
			  score       : in std_logic_vector (7 downto 0);
			  --the rgb signal is 8 bits: 3 for red, 3 for green, and 2 for blue (See Nexys 3 Reference Manual for more information about VGA Port.)
			  rgb         : out  STD_LOGIC_VECTOR (7 downto 0));
end graphics;

architecture Behavioral of graphics is
constant lane1_t : integer := 100; --distance between the top lane and top of the screen
signal x,y : integer range 0 to 650;

--These signals will...
signal draw_obst,
       draw_line,
       draw_bg,
       draw_plyr : std_logic;
		 
signal color_selector : std_logic_vector (4 downto 0);

signal bg_color : STD_LOGIC_VECTOR (7 downto 0) := "01110111";
signal score_integer : integer range 0 to 255;

begin


	--Convert our 11-bit inputs, hcount and vcount, into integers,
	--which will be easier to use to designate locations on the screen.
	x <= conv_integer(hcount);
	y <= conv_integer(vcount);

	draw_obst <= '1' when

	--These 32 are for lane 1.
	  (((x > 500) and (x < 520) and (y > 100) and (y < 120) and (obst_locs_1(31) = '1')) or
		((x > 490) and (x < 510) and (y > 100) and (y < 120) and (obst_locs_1(30) = '1')) or
		((x > 480) and (x < 500) and (y > 100) and (y < 120) and (obst_locs_1(29) = '1')) or
		((x > 470) and (x < 490) and (y > 100) and (y < 120) and (obst_locs_1(28) = '1')) or
		((x > 460) and (x < 480) and (y > 100) and (y < 120) and (obst_locs_1(27) = '1')) or
		((x > 450) and (x < 470) and (y > 100) and (y < 120) and (obst_locs_1(26) = '1')) or
		((x > 440) and (x < 460) and (y > 100) and (y < 120) and (obst_locs_1(25) = '1')) or
		((x > 430) and (x < 450) and (y > 100) and (y < 120) and (obst_locs_1(24) = '1')) or
		((x > 420) and (x < 440) and (y > 100) and (y < 120) and (obst_locs_1(23) = '1')) or
		((x > 410) and (x < 430) and (y > 100) and (y < 120) and (obst_locs_1(22) = '1')) or
		((x > 400) and (x < 420) and (y > 100) and (y < 120) and (obst_locs_1(21) = '1')) or
		((x > 390) and (x < 410) and (y > 100) and (y < 120) and (obst_locs_1(20) = '1')) or
		((x > 380) and (x < 400) and (y > 100) and (y < 120) and (obst_locs_1(19) = '1')) or
		((x > 370) and (x < 390) and (y > 100) and (y < 120) and (obst_locs_1(18) = '1')) or
		((x > 360) and (x < 380) and (y > 100) and (y < 120) and (obst_locs_1(17) = '1')) or
		((x > 350) and (x < 370) and (y > 100) and (y < 120) and (obst_locs_1(16) = '1')) or
		((x > 340) and (x < 360) and (y > 100) and (y < 120) and (obst_locs_1(15) = '1')) or
		((x > 330) and (x < 350) and (y > 100) and (y < 120) and (obst_locs_1(14) = '1')) or
		((x > 320) and (x < 340) and (y > 100) and (y < 120) and (obst_locs_1(13) = '1')) or
		((x > 310) and (x < 330) and (y > 100) and (y < 120) and (obst_locs_1(12) = '1')) or
		((x > 300) and (x < 320) and (y > 100) and (y < 120) and (obst_locs_1(11) = '1')) or
		((x > 290) and (x < 310) and (y > 100) and (y < 120) and (obst_locs_1(10) = '1')) or
		((x > 280) and (x < 300) and (y > 100) and (y < 120) and (obst_locs_1(9) = '1')) or
		((x > 270) and (x < 290) and (y > 100) and (y < 120) and (obst_locs_1(8) = '1')) or
		((x > 260) and (x < 280) and (y > 100) and (y < 120) and (obst_locs_1(7) = '1')) or
		((x > 250) and (x < 270) and (y > 100) and (y < 120) and (obst_locs_1(6) = '1')) or
		((x > 240) and (x < 260) and (y > 100) and (y < 120) and (obst_locs_1(5) = '1')) or
		((x > 230) and (x < 250) and (y > 100) and (y < 120) and (obst_locs_1(4) = '1')) or
		((x > 220) and (x < 240) and (y > 100) and (y < 120) and (obst_locs_1(3) = '1')) or
		((x > 210) and (x < 230) and (y > 100) and (y < 120) and (obst_locs_1(2) = '1')) or
		((x > 200) and (x < 220) and (y > 100) and (y < 120) and (obst_locs_1(1) = '1')) or
		((x > 190) and (x < 210) and (y > 100) and (y < 120) and (obst_locs_1(0) = '1')) or

	--These 32 are for lane 2.
		((x > 500) and (x < 520) and (y > 200) and (y < 220) and (obst_locs_2(31) = '1')) or
		((x > 490) and (x < 510) and (y > 200) and (y < 220) and (obst_locs_2(30) = '1')) or
		((x > 480) and (x < 500) and (y > 200) and (y < 220) and (obst_locs_2(29) = '1')) or
		((x > 470) and (x < 490) and (y > 200) and (y < 220) and (obst_locs_2(28) = '1')) or
		((x > 460) and (x < 480) and (y > 200) and (y < 220) and (obst_locs_2(27) = '1')) or
		((x > 450) and (x < 470) and (y > 200) and (y < 220) and (obst_locs_2(26) = '1')) or
		((x > 440) and (x < 460) and (y > 200) and (y < 220) and (obst_locs_2(25) = '1')) or
		((x > 430) and (x < 450) and (y > 200) and (y < 220) and (obst_locs_2(24) = '1')) or
		((x > 420) and (x < 440) and (y > 200) and (y < 220) and (obst_locs_2(23) = '1')) or
		((x > 410) and (x < 430) and (y > 200) and (y < 220) and (obst_locs_2(22) = '1')) or
		((x > 400) and (x < 420) and (y > 200) and (y < 220) and (obst_locs_2(21) = '1')) or
		((x > 390) and (x < 410) and (y > 200) and (y < 220) and (obst_locs_2(20) = '1')) or
		((x > 380) and (x < 400) and (y > 200) and (y < 220) and (obst_locs_2(19) = '1')) or
		((x > 370) and (x < 390) and (y > 200) and (y < 220) and (obst_locs_2(18) = '1')) or
		((x > 360) and (x < 380) and (y > 200) and (y < 220) and (obst_locs_2(17) = '1')) or
		((x > 350) and (x < 370) and (y > 200) and (y < 220) and (obst_locs_2(16) = '1')) or
		((x > 340) and (x < 360) and (y > 200) and (y < 220) and (obst_locs_2(15) = '1')) or
		((x > 330) and (x < 350) and (y > 200) and (y < 220) and (obst_locs_2(14) = '1')) or
		((x > 320) and (x < 340) and (y > 200) and (y < 220) and (obst_locs_2(13) = '1')) or
		((x > 310) and (x < 330) and (y > 200) and (y < 220) and (obst_locs_2(12) = '1')) or
		((x > 300) and (x < 320) and (y > 200) and (y < 220) and (obst_locs_2(11) = '1')) or
		((x > 290) and (x < 310) and (y > 200) and (y < 220) and (obst_locs_2(10) = '1')) or
		((x > 280) and (x < 300) and (y > 200) and (y < 220) and (obst_locs_2(9) = '1')) or
		((x > 270) and (x < 290) and (y > 200) and (y < 220) and (obst_locs_2(8) = '1')) or
		((x > 260) and (x < 280) and (y > 200) and (y < 220) and (obst_locs_2(7) = '1')) or
		((x > 250) and (x < 270) and (y > 200) and (y < 220) and (obst_locs_2(6) = '1')) or
		((x > 240) and (x < 260) and (y > 200) and (y < 220) and (obst_locs_2(5) = '1')) or
		((x > 230) and (x < 250) and (y > 200) and (y < 220) and (obst_locs_2(4) = '1')) or
		((x > 220) and (x < 240) and (y > 200) and (y < 220) and (obst_locs_2(3) = '1')) or
		((x > 210) and (x < 230) and (y > 200) and (y < 220) and (obst_locs_2(2) = '1')) or
		((x > 200) and (x < 220) and (y > 200) and (y < 220) and (obst_locs_2(1) = '1')) or
		((x > 190) and (x < 210) and (y > 200) and (y < 220) and (obst_locs_2(0) = '1')) or
		
	--These 32 are for lane 3.
		((x > 500) and (x < 520) and (y > 300) and (y < 320) and (obst_locs_3(31) = '1')) or
		((x > 490) and (x < 510) and (y > 300) and (y < 320) and (obst_locs_3(30) = '1')) or
		((x > 480) and (x < 500) and (y > 300) and (y < 320) and (obst_locs_3(29) = '1')) or
		((x > 470) and (x < 490) and (y > 300) and (y < 320) and (obst_locs_3(28) = '1')) or
		((x > 460) and (x < 480) and (y > 300) and (y < 320) and (obst_locs_3(27) = '1')) or
		((x > 450) and (x < 470) and (y > 300) and (y < 320) and (obst_locs_3(26) = '1')) or
		((x > 440) and (x < 460) and (y > 300) and (y < 320) and (obst_locs_3(25) = '1')) or
		((x > 430) and (x < 450) and (y > 300) and (y < 320) and (obst_locs_3(24) = '1')) or
		((x > 420) and (x < 440) and (y > 300) and (y < 320) and (obst_locs_3(23) = '1')) or
		((x > 410) and (x < 430) and (y > 300) and (y < 320) and (obst_locs_3(22) = '1')) or
		((x > 400) and (x < 420) and (y > 300) and (y < 320) and (obst_locs_3(21) = '1')) or
		((x > 390) and (x < 410) and (y > 300) and (y < 320) and (obst_locs_3(20) = '1')) or
		((x > 380) and (x < 400) and (y > 300) and (y < 320) and (obst_locs_3(19) = '1')) or
		((x > 370) and (x < 390) and (y > 300) and (y < 320) and (obst_locs_3(18) = '1')) or
		((x > 360) and (x < 380) and (y > 300) and (y < 320) and (obst_locs_3(17) = '1')) or
		((x > 350) and (x < 370) and (y > 300) and (y < 320) and (obst_locs_3(16) = '1')) or
		((x > 340) and (x < 360) and (y > 300) and (y < 320) and (obst_locs_3(15) = '1')) or
		((x > 330) and (x < 350) and (y > 300) and (y < 320) and (obst_locs_3(14) = '1')) or
		((x > 320) and (x < 340) and (y > 300) and (y < 320) and (obst_locs_3(13) = '1')) or
		((x > 310) and (x < 330) and (y > 300) and (y < 320) and (obst_locs_3(12) = '1')) or
		((x > 300) and (x < 320) and (y > 300) and (y < 320) and (obst_locs_3(11) = '1')) or
		((x > 290) and (x < 310) and (y > 300) and (y < 320) and (obst_locs_3(10) = '1')) or
		((x > 280) and (x < 300) and (y > 300) and (y < 320) and (obst_locs_3(9) = '1')) or
		((x > 270) and (x < 290) and (y > 300) and (y < 320) and (obst_locs_3(8) = '1')) or
		((x > 260) and (x < 280) and (y > 300) and (y < 320) and (obst_locs_3(7) = '1')) or
		((x > 250) and (x < 270) and (y > 300) and (y < 320) and (obst_locs_3(6) = '1')) or
		((x > 240) and (x < 260) and (y > 300) and (y < 320) and (obst_locs_3(5) = '1')) or
		((x > 230) and (x < 250) and (y > 300) and (y < 320) and (obst_locs_3(4) = '1')) or
		((x > 220) and (x < 240) and (y > 300) and (y < 320) and (obst_locs_3(3) = '1')) or
		((x > 210) and (x < 230) and (y > 300) and (y < 320) and (obst_locs_3(2) = '1')) or
		((x > 200) and (x < 220) and (y > 300) and (y < 320) and (obst_locs_3(1) = '1')) or
		((x > 190) and (x < 210) and (y > 300) and (y < 320) and (obst_locs_3(0) = '1')) or

	--These 32 are for lane 4.
		((x > 500) and (x < 520) and (y > 400) and (y < 420) and (obst_locs_4(31) = '1')) or
		((x > 490) and (x < 510) and (y > 400) and (y < 420) and (obst_locs_4(30) = '1')) or
		((x > 480) and (x < 500) and (y > 400) and (y < 420) and (obst_locs_4(29) = '1')) or
		((x > 470) and (x < 490) and (y > 400) and (y < 420) and (obst_locs_4(28) = '1')) or
		((x > 460) and (x < 480) and (y > 400) and (y < 420) and (obst_locs_4(27) = '1')) or
		((x > 450) and (x < 470) and (y > 400) and (y < 420) and (obst_locs_4(26) = '1')) or
		((x > 440) and (x < 460) and (y > 400) and (y < 420) and (obst_locs_4(25) = '1')) or
		((x > 430) and (x < 450) and (y > 400) and (y < 420) and (obst_locs_4(24) = '1')) or
		((x > 420) and (x < 440) and (y > 400) and (y < 420) and (obst_locs_4(23) = '1')) or
		((x > 410) and (x < 430) and (y > 400) and (y < 420) and (obst_locs_4(22) = '1')) or
		((x > 400) and (x < 420) and (y > 400) and (y < 420) and (obst_locs_4(21) = '1')) or
		((x > 390) and (x < 410) and (y > 400) and (y < 420) and (obst_locs_4(20) = '1')) or
		((x > 380) and (x < 400) and (y > 400) and (y < 420) and (obst_locs_4(19) = '1')) or
		((x > 370) and (x < 390) and (y > 400) and (y < 420) and (obst_locs_4(18) = '1')) or
		((x > 360) and (x < 380) and (y > 400) and (y < 420) and (obst_locs_4(17) = '1')) or
		((x > 350) and (x < 370) and (y > 400) and (y < 420) and (obst_locs_4(16) = '1')) or
		((x > 340) and (x < 360) and (y > 400) and (y < 420) and (obst_locs_4(15) = '1')) or
		((x > 330) and (x < 350) and (y > 400) and (y < 420) and (obst_locs_4(14) = '1')) or
		((x > 320) and (x < 340) and (y > 400) and (y < 420) and (obst_locs_4(13) = '1')) or
		((x > 310) and (x < 330) and (y > 400) and (y < 420) and (obst_locs_4(12) = '1')) or
		((x > 300) and (x < 320) and (y > 400) and (y < 420) and (obst_locs_4(11) = '1')) or
		((x > 290) and (x < 310) and (y > 400) and (y < 420) and (obst_locs_4(10) = '1')) or
		((x > 280) and (x < 300) and (y > 400) and (y < 420) and (obst_locs_4(9) = '1')) or
		((x > 270) and (x < 290) and (y > 400) and (y < 420) and (obst_locs_4(8) = '1')) or
		((x > 260) and (x < 280) and (y > 400) and (y < 420) and (obst_locs_4(7) = '1')) or
		((x > 250) and (x < 270) and (y > 400) and (y < 420) and (obst_locs_4(6) = '1')) or
		((x > 240) and (x < 260) and (y > 400) and (y < 420) and (obst_locs_4(5) = '1')) or
		((x > 230) and (x < 250) and (y > 400) and (y < 420) and (obst_locs_4(4) = '1')) or
		((x > 220) and (x < 240) and (y > 400) and (y < 420) and (obst_locs_4(3) = '1')) or
		((x > 210) and (x < 230) and (y > 400) and (y < 420) and (obst_locs_4(2) = '1')) or
		((x > 200) and (x < 220) and (y > 400) and (y < 420) and (obst_locs_4(1) = '1')) or
		((x > 190) and (x < 210) and (y > 400) and (y < 420) and (obst_locs_4(0) = '1'))) else '0';

		
	draw_plyr <= '1' when

	  (((x > 190) and (x < 210) and (y > 100) and (y < 120) and (player_loc = "1000")) or
		((x > 190) and (x < 210) and (y > 200) and (y < 220) and (player_loc = "0100")) or
		((x > 190) and (x < 210) and (y > 300) and (y < 320) and (player_loc = "0010")) or
		((x > 190) and (x < 210) and (y > 400) and (y < 420) and (player_loc = "0001"))) else '0';
		
	draw_line <= '1' when
		(((y = 60) and (x > 180) and (x mod 10 < 7) and (x < 530)) or
		 ((y = 160) and (x > 180) and (x mod 10 < 7) and (x < 530)) or
		 ((y = 260) and (x > 180) and (x mod 10 < 7) and (x < 530)) or
		 ((y = 360) and (x > 180) and (x mod 10 < 7) and (x < 530)) or
		 ((y = 460) and (x > 180) and (x mod 10 < 7) and (x < 530))) else '0';

	draw_bg <= not draw_obst and not draw_plyr and not draw_line;
	
	score_integer <= conv_integer(score);

	change_bg_color: process(pixel_clk, score_integer)
	begin
      if(rising_edge(pixel_clk)) then
			if(((score_integer mod 10) = 0) and (score_integer /= 0)) then
				bg_color <= "01010101";
			else
				bg_color <= bg_color;
			end if;
		end if;
	end process change_bg_color;

	--mux

	color_selector <= draw_obst & draw_plyr & dead & draw_line & draw_bg;
	with color_selector select
		rgb <= "00000011" when "10000", -- draw the obstacles pixels
		-- not applicable because obstacles stop being generated when the user's dead
		--"00000011" when "1010", 
		
		-- draw the line pixels
		"11111111" when "00010",
		"11111111" when "00110",
		-- draw the player
		"11111111" when "01000",
		"11111111" when "11000",

		-- player should turn red when lose_state achieved.
		"11100000" when "01100",
		"11100000" when "11100",

		--the rest of the screen is the background.
		bg_color when others;
		
end Behavioral;