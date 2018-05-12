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
    Port ( pixel_clk   	: in STD_LOGIC;
	        player_loc  	: in STD_LOGIC_VECTOR (3 downto 0);
			  h_player_loc : in STD_LOGIC_VECTOR (1 downto 0);	
           obst_locs_1,
           obst_locs_2,
           obst_locs_3,
           obst_locs_4 	: in STD_LOGIC_VECTOR (31 downto 0);
			  level 			: in std_logic_vector (2 downto 0);
			  score 			: in std_logic_vector (7 downto 0);
			  top_lives_left : in std_logic_vector (1 downto 0);
			  dead        	: in STD_LOGIC;
			  hcount      	: in STD_LOGIC_VECTOR (10 downto 0);
			  vcount      	: in STD_LOGIC_VECTOR (10 downto 0);
			  --the rgb signal is 8 bits: 3 for red, 3 for green, and 2 for blue (See Nexys 3 Reference Manual for more information about VGA Port.)
			  rgb         	: out  STD_LOGIC_VECTOR (7 downto 0));
end graphics;

architecture Behavioral of graphics is
constant lane1_t : integer := 100; --distance between the top lane and top of the screen
signal x,y : integer range 0 to 650;

--These signals will...
signal draw_obst,
       draw_plyr ,
		 draw_life ,
		 draw_line ,
		 draw_level : std_logic; 
signal color_selector : std_logic_vector (5 downto 0);		 
signal score_integer : integer range 0 to 255;
signal level_digit, score_digit1, score_digit2, score_digit3 : Integer ;
begin


--Convert our 11-bit inputs, hcount and vcount, into integers,
--which will be easier to use to designate locations on the screen.
x <= conv_integer(hcount);
y <= conv_integer(vcount);

draw_obst <= '1' when

--These 32 are for lane 1.
  (((x > 503) and (x < 508) and (y > 100) and (y < 105) and (obst_locs_1(31) = '1')) or
	((x > 493) and (x < 498) and (y > 100) and (y < 105) and (obst_locs_1(30) = '1')) or
   ((x > 483) and (x < 488) and (y > 100) and (y < 105) and (obst_locs_1(29) = '1')) or
	((x > 473) and (x < 478) and (y > 100) and (y < 105) and (obst_locs_1(28) = '1')) or
	((x > 463) and (x < 468) and (y > 100) and (y < 105) and (obst_locs_1(27) = '1')) or
	((x > 453) and (x < 458) and (y > 100) and (y < 105) and (obst_locs_1(26) = '1')) or
	((x > 443) and (x < 448) and (y > 100) and (y < 105) and (obst_locs_1(25) = '1')) or
   ((x > 433) and (x < 438) and (y > 100) and (y < 105) and (obst_locs_1(24) = '1')) or
   ((x > 423) and (x < 428) and (y > 100) and (y < 105) and (obst_locs_1(23) = '1')) or
	((x > 413) and (x < 418) and (y > 100) and (y < 105) and (obst_locs_1(22) = '1')) or
	((x > 403) and (x < 408) and (y > 100) and (y < 105) and (obst_locs_1(21) = '1')) or
	((x > 393) and (x < 398) and (y > 100) and (y < 105) and (obst_locs_1(20) = '1')) or
	((x > 383) and (x < 388) and (y > 100) and (y < 105) and (obst_locs_1(19) = '1')) or
	((x > 373) and (x < 378) and (y > 100) and (y < 105) and (obst_locs_1(18) = '1')) or
	((x > 363) and (x < 368) and (y > 100) and (y < 105) and (obst_locs_1(17) = '1')) or
	((x > 353) and (x < 358) and (y > 100) and (y < 105) and (obst_locs_1(16) = '1')) or
	((x > 343) and (x < 348) and (y > 100) and (y < 105) and (obst_locs_1(15) = '1')) or
	((x > 333) and (x < 338) and (y > 100) and (y < 105) and (obst_locs_1(14) = '1')) or
	((x > 323) and (x < 328) and (y > 100) and (y < 105) and (obst_locs_1(13) = '1')) or
	((x > 313) and (x < 318) and (y > 100) and (y < 105) and (obst_locs_1(12) = '1')) or
	((x > 303) and (x < 308) and (y > 100) and (y < 105) and (obst_locs_1(11) = '1')) or
	((x > 293) and (x < 298) and (y > 100) and (y < 105) and (obst_locs_1(10) = '1')) or
	((x > 283) and (x < 288) and (y > 100) and (y < 105) and (obst_locs_1(9) = '1')) or
	((x > 273) and (x < 278) and (y > 100) and (y < 105) and (obst_locs_1(8) = '1')) or
	((x > 263) and (x < 268) and (y > 100) and (y < 105) and (obst_locs_1(7) = '1')) or
   ((x > 253) and (x < 258) and (y > 100) and (y < 105) and (obst_locs_1(6) = '1')) or
	((x > 243) and (x < 248) and (y > 100) and (y < 105) and (obst_locs_1(5) = '1')) or
	((x > 233) and (x < 238) and (y > 100) and (y < 105) and (obst_locs_1(4) = '1')) or
	((x > 223) and (x < 228) and (y > 100) and (y < 105) and (obst_locs_1(3) = '1')) or
	((x > 213) and (x < 218) and (y > 100) and (y < 105) and (obst_locs_1(2) = '1')) or
	((x > 203) and (x < 208) and (y > 100) and (y < 105) and (obst_locs_1(1) = '1')) or
	((x > 193) and (x < 198) and (y > 100) and (y < 105) and (obst_locs_1(0) = '1')) or

   ((x > 515) and (x < 520) and (y > 100) and (y < 105) and (obst_locs_1(31) = '1')) or
	((x > 505) and (x < 510) and (y > 100) and (y < 105) and (obst_locs_1(30) = '1')) or
   ((x > 495) and (x < 500) and (y > 100) and (y < 105) and (obst_locs_1(29) = '1')) or
	((x > 485) and (x < 490) and (y > 100) and (y < 105) and (obst_locs_1(28) = '1')) or
	((x > 475) and (x < 480) and (y > 100) and (y < 105) and (obst_locs_1(27) = '1')) or
	((x > 465) and (x < 470) and (y > 100) and (y < 105) and (obst_locs_1(26) = '1')) or
	((x > 455) and (x < 460) and (y > 100) and (y < 105) and (obst_locs_1(25) = '1')) or
   ((x > 445) and (x < 450) and (y > 100) and (y < 105) and (obst_locs_1(24) = '1')) or
   ((x > 435) and (x < 440) and (y > 100) and (y < 105) and (obst_locs_1(23) = '1')) or
	((x > 425) and (x < 430) and (y > 100) and (y < 105) and (obst_locs_1(22) = '1')) or
	((x > 415) and (x < 420) and (y > 100) and (y < 105) and (obst_locs_1(21) = '1')) or
	((x > 405) and (x < 410) and (y > 100) and (y < 105) and (obst_locs_1(20) = '1')) or
	((x > 395) and (x < 400) and (y > 100) and (y < 105) and (obst_locs_1(19) = '1')) or
	((x > 385) and (x < 390) and (y > 100) and (y < 105) and (obst_locs_1(18) = '1')) or
	((x > 375) and (x < 380) and (y > 100) and (y < 105) and (obst_locs_1(17) = '1')) or
	((x > 365) and (x < 370) and (y > 100) and (y < 105) and (obst_locs_1(16) = '1')) or
	((x > 355) and (x < 360) and (y > 100) and (y < 105) and (obst_locs_1(15) = '1')) or
	((x > 345) and (x < 350) and (y > 100) and (y < 105) and (obst_locs_1(14) = '1')) or
	((x > 335) and (x < 340) and (y > 100) and (y < 105) and (obst_locs_1(13) = '1')) or
	((x > 325) and (x < 330) and (y > 100) and (y < 105) and (obst_locs_1(12) = '1')) or
	((x > 315) and (x < 320) and (y > 100) and (y < 105) and (obst_locs_1(11) = '1')) or
	((x > 305) and (x < 310) and (y > 100) and (y < 105) and (obst_locs_1(10) = '1')) or
	((x > 295) and (x < 300) and (y > 100) and (y < 105) and (obst_locs_1(9) = '1')) or
	((x > 285) and (x < 290) and (y > 100) and (y < 105) and (obst_locs_1(8) = '1')) or
	((x > 275) and (x < 280) and (y > 100) and (y < 105) and (obst_locs_1(7) = '1')) or
   ((x > 265) and (x < 270) and (y > 100) and (y < 105) and (obst_locs_1(6) = '1')) or
	((x > 255) and (x < 260) and (y > 100) and (y < 105) and (obst_locs_1(5) = '1')) or
	((x > 245) and (x < 250) and (y > 100) and (y < 105) and (obst_locs_1(4) = '1')) or
	((x > 235) and (x < 240) and (y > 100) and (y < 105) and (obst_locs_1(3) = '1')) or
	((x > 225) and (x < 230) and (y > 100) and (y < 105) and (obst_locs_1(2) = '1')) or
	((x > 215) and (x < 220) and (y > 100) and (y < 105) and (obst_locs_1(1) = '1')) or
	((x > 205) and (x < 210) and (y > 100) and (y < 105) and (obst_locs_1(0) = '1')) or

   ((x > 500) and (x < 518) and (y > 105) and (y < 115) and (obst_locs_1(31) = '1')) or
	((x > 490) and (x < 508) and (y > 105) and (y < 115) and (obst_locs_1(30) = '1')) or
   ((x > 480) and (x < 498) and (y > 105) and (y < 115) and (obst_locs_1(29) = '1')) or
	((x > 470) and (x < 488) and (y > 105) and (y < 115) and (obst_locs_1(28) = '1')) or
	((x > 460) and (x < 478) and (y > 105) and (y < 115) and (obst_locs_1(27) = '1')) or
	((x > 450) and (x < 468) and (y > 105) and (y < 115) and (obst_locs_1(26) = '1')) or
	((x > 440) and (x < 458) and (y > 105) and (y < 115) and (obst_locs_1(25) = '1')) or
   ((x > 430) and (x < 448) and (y > 105) and (y < 115) and (obst_locs_1(24) = '1')) or
   ((x > 420) and (x < 438) and (y > 105) and (y < 115) and (obst_locs_1(23) = '1')) or
	((x > 410) and (x < 428) and (y > 105) and (y < 115) and (obst_locs_1(22) = '1')) or
	((x > 400) and (x < 418) and (y > 105) and (y < 115) and (obst_locs_1(21) = '1')) or
	((x > 390) and (x < 408) and (y > 105) and (y < 115) and (obst_locs_1(20) = '1')) or
	((x > 380) and (x < 398) and (y > 105) and (y < 115) and (obst_locs_1(19) = '1')) or
	((x > 370) and (x < 388) and (y > 105) and (y < 115) and (obst_locs_1(18) = '1')) or
	((x > 360) and (x < 378) and (y > 105) and (y < 115) and (obst_locs_1(17) = '1')) or
	((x > 350) and (x < 368) and (y > 105) and (y < 115) and (obst_locs_1(16) = '1')) or
	((x > 340) and (x < 358) and (y > 105) and (y < 115) and (obst_locs_1(15) = '1')) or
	((x > 330) and (x < 348) and (y > 105) and (y < 115) and (obst_locs_1(14) = '1')) or
	((x > 320) and (x < 338) and (y > 105) and (y < 115) and (obst_locs_1(13) = '1')) or
	((x > 310) and (x < 328) and (y > 105) and (y < 115) and (obst_locs_1(12) = '1')) or
	((x > 300) and (x < 318) and (y > 105) and (y < 115) and (obst_locs_1(11) = '1')) or
	((x > 290) and (x < 308) and (y > 105) and (y < 115) and (obst_locs_1(10) = '1')) or
	((x > 280) and (x < 298) and (y > 105) and (y < 115) and (obst_locs_1(9) = '1')) or
	((x > 270) and (x < 288) and (y > 105) and (y < 115) and (obst_locs_1(8) = '1')) or
	((x > 260) and (x < 278) and (y > 105) and (y < 115) and (obst_locs_1(7) = '1')) or
   ((x > 250) and (x < 268) and (y > 105) and (y < 115) and (obst_locs_1(6) = '1')) or
	((x > 240) and (x < 258) and (y > 105) and (y < 115) and (obst_locs_1(5) = '1')) or
	((x > 230) and (x < 248) and (y > 105) and (y < 115) and (obst_locs_1(4) = '1')) or
	((x > 220) and (x < 238) and (y > 105) and (y < 115) and (obst_locs_1(3) = '1')) or
	((x > 210) and (x < 228) and (y > 105) and (y < 115) and (obst_locs_1(2) = '1')) or
	((x > 200) and (x < 218) and (y > 105) and (y < 115) and (obst_locs_1(1) = '1')) or
	((x > 190) and (x < 208) and (y > 105) and (y < 115) and (obst_locs_1(0) = '1')) or

   ((x > 503) and (x < 508) and (y > 115) and (y < 120) and (obst_locs_1(31) = '1')) or
	((x > 493) and (x < 498) and (y > 115) and (y < 120) and (obst_locs_1(30) = '1')) or
   ((x > 483) and (x < 488) and (y > 115) and (y < 120) and (obst_locs_1(29) = '1')) or
	((x > 473) and (x < 478) and (y > 115) and (y < 120) and (obst_locs_1(28) = '1')) or
	((x > 463) and (x < 468) and (y > 115) and (y < 120) and (obst_locs_1(27) = '1')) or
	((x > 453) and (x < 458) and (y > 115) and (y < 120) and (obst_locs_1(26) = '1')) or
	((x > 443) and (x < 448) and (y > 115) and (y < 120) and (obst_locs_1(25) = '1')) or
   ((x > 433) and (x < 438) and (y > 115) and (y < 120) and (obst_locs_1(24) = '1')) or
   ((x > 423) and (x < 428) and (y > 115) and (y < 120) and (obst_locs_1(23) = '1')) or
	((x > 413) and (x < 418) and (y > 115) and (y < 120) and (obst_locs_1(22) = '1')) or
	((x > 403) and (x < 408) and (y > 115) and (y < 120) and (obst_locs_1(21) = '1')) or
	((x > 393) and (x < 398) and (y > 115) and (y < 120) and (obst_locs_1(20) = '1')) or
	((x > 383) and (x < 388) and (y > 115) and (y < 120) and (obst_locs_1(19) = '1')) or
	((x > 373) and (x < 378) and (y > 115) and (y < 120) and (obst_locs_1(18) = '1')) or
	((x > 363) and (x < 368) and (y > 115) and (y < 120) and (obst_locs_1(17) = '1')) or
	((x > 353) and (x < 358) and (y > 115) and (y < 120) and (obst_locs_1(16) = '1')) or
	((x > 343) and (x < 348) and (y > 115) and (y < 120) and (obst_locs_1(15) = '1')) or
	((x > 333) and (x < 338) and (y > 115) and (y < 120) and (obst_locs_1(14) = '1')) or
	((x > 323) and (x < 328) and (y > 115) and (y < 120) and (obst_locs_1(13) = '1')) or
	((x > 313) and (x < 318) and (y > 115) and (y < 120) and (obst_locs_1(12) = '1')) or
	((x > 303) and (x < 308) and (y > 115) and (y < 120) and (obst_locs_1(11) = '1')) or
	((x > 293) and (x < 298) and (y > 115) and (y < 120) and (obst_locs_1(10) = '1')) or
	((x > 283) and (x < 288) and (y > 115) and (y < 120) and (obst_locs_1(9) = '1')) or
	((x > 273) and (x < 278) and (y > 115) and (y < 120) and (obst_locs_1(8) = '1')) or
	((x > 263) and (x < 268) and (y > 115) and (y < 120) and (obst_locs_1(7) = '1')) or
   ((x > 253) and (x < 258) and (y > 115) and (y < 120) and (obst_locs_1(6) = '1')) or
	((x > 243) and (x < 248) and (y > 115) and (y < 120) and (obst_locs_1(5) = '1')) or
	((x > 233) and (x < 238) and (y > 115) and (y < 120) and (obst_locs_1(4) = '1')) or
	((x > 223) and (x < 228) and (y > 115) and (y < 120) and (obst_locs_1(3) = '1')) or
	((x > 213) and (x < 218) and (y > 115) and (y < 120) and (obst_locs_1(2) = '1')) or
	((x > 203) and (x < 208) and (y > 115) and (y < 120) and (obst_locs_1(1) = '1')) or
	((x > 193) and (x < 198) and (y > 115) and (y < 120) and (obst_locs_1(0) = '1')) or

   ((x > 515) and (x < 520) and (y > 115) and (y < 120) and (obst_locs_1(31) = '1')) or
	((x > 505) and (x < 510) and (y > 115) and (y < 120) and (obst_locs_1(30) = '1')) or
   ((x > 495) and (x < 500) and (y > 115) and (y < 120) and (obst_locs_1(29) = '1')) or
	((x > 485) and (x < 490) and (y > 115) and (y < 120) and (obst_locs_1(28) = '1')) or
	((x > 475) and (x < 480) and (y > 115) and (y < 120) and (obst_locs_1(27) = '1')) or
	((x > 465) and (x < 470) and (y > 115) and (y < 120) and (obst_locs_1(26) = '1')) or
	((x > 455) and (x < 460) and (y > 115) and (y < 120) and (obst_locs_1(25) = '1')) or
   ((x > 445) and (x < 450) and (y > 115) and (y < 120) and (obst_locs_1(24) = '1')) or
   ((x > 435) and (x < 440) and (y > 115) and (y < 120) and (obst_locs_1(23) = '1')) or
	((x > 425) and (x < 430) and (y > 115) and (y < 120) and (obst_locs_1(22) = '1')) or
	((x > 415) and (x < 420) and (y > 115) and (y < 120) and (obst_locs_1(21) = '1')) or
	((x > 405) and (x < 410) and (y > 115) and (y < 120) and (obst_locs_1(20) = '1')) or
	((x > 395) and (x < 400) and (y > 115) and (y < 120) and (obst_locs_1(19) = '1')) or
	((x > 385) and (x < 390) and (y > 115) and (y < 120) and (obst_locs_1(18) = '1')) or
	((x > 375) and (x < 380) and (y > 115) and (y < 120) and (obst_locs_1(17) = '1')) or
	((x > 365) and (x < 370) and (y > 115) and (y < 120) and (obst_locs_1(16) = '1')) or
	((x > 355) and (x < 360) and (y > 115) and (y < 120) and (obst_locs_1(15) = '1')) or
	((x > 345) and (x < 350) and (y > 115) and (y < 120) and (obst_locs_1(14) = '1')) or
	((x > 335) and (x < 340) and (y > 115) and (y < 120) and (obst_locs_1(13) = '1')) or
	((x > 325) and (x < 330) and (y > 115) and (y < 120) and (obst_locs_1(12) = '1')) or
	((x > 315) and (x < 320) and (y > 115) and (y < 120) and (obst_locs_1(11) = '1')) or
	((x > 305) and (x < 310) and (y > 115) and (y < 120) and (obst_locs_1(10) = '1')) or
	((x > 295) and (x < 300) and (y > 115) and (y < 120) and (obst_locs_1(9) = '1')) or
	((x > 285) and (x < 290) and (y > 115) and (y < 120) and (obst_locs_1(8) = '1')) or
	((x > 275) and (x < 280) and (y > 115) and (y < 120) and (obst_locs_1(7) = '1')) or
   ((x > 265) and (x < 270) and (y > 115) and (y < 120) and (obst_locs_1(6) = '1')) or
	((x > 255) and (x < 260) and (y > 115) and (y < 120) and (obst_locs_1(5) = '1')) or
	((x > 245) and (x < 250) and (y > 115) and (y < 120) and (obst_locs_1(4) = '1')) or
	((x > 235) and (x < 240) and (y > 115) and (y < 120) and (obst_locs_1(3) = '1')) or
	((x > 225) and (x < 230) and (y > 115) and (y < 120) and (obst_locs_1(2) = '1')) or
	((x > 215) and (x < 220) and (y > 115) and (y < 120) and (obst_locs_1(1) = '1')) or
	((x > 205) and (x < 210) and (y > 115) and (y < 120) and (obst_locs_1(0) = '1')) or
	
--These 32 are for lane 2.
   ((x > 503) and (x < 508) and (y > 200) and (y < 205) and (obst_locs_2(31) = '1')) or
	((x > 493) and (x < 498) and (y > 200) and (y < 205) and (obst_locs_2(30) = '1')) or
   ((x > 483) and (x < 488) and (y > 200) and (y < 205) and (obst_locs_2(29) = '1')) or
	((x > 473) and (x < 478) and (y > 200) and (y < 205) and (obst_locs_2(28) = '1')) or
	((x > 463) and (x < 468) and (y > 200) and (y < 205) and (obst_locs_2(27) = '1')) or
	((x > 453) and (x < 458) and (y > 200) and (y < 205) and (obst_locs_2(26) = '1')) or
	((x > 443) and (x < 448) and (y > 200) and (y < 205) and (obst_locs_2(25) = '1')) or
   ((x > 433) and (x < 438) and (y > 200) and (y < 205) and (obst_locs_2(24) = '1')) or
   ((x > 423) and (x < 428) and (y > 200) and (y < 205) and (obst_locs_2(23) = '1')) or
	((x > 413) and (x < 418) and (y > 200) and (y < 205) and (obst_locs_2(22) = '1')) or
	((x > 403) and (x < 408) and (y > 200) and (y < 205) and (obst_locs_2(21) = '1')) or
	((x > 393) and (x < 398) and (y > 200) and (y < 205) and (obst_locs_2(20) = '1')) or
	((x > 383) and (x < 388) and (y > 200) and (y < 205) and (obst_locs_2(19) = '1')) or
	((x > 373) and (x < 378) and (y > 200) and (y < 205) and (obst_locs_2(18) = '1')) or
	((x > 363) and (x < 368) and (y > 200) and (y < 205) and (obst_locs_2(17) = '1')) or
	((x > 353) and (x < 358) and (y > 200) and (y < 205) and (obst_locs_2(16) = '1')) or
	((x > 343) and (x < 348) and (y > 200) and (y < 205) and (obst_locs_2(15) = '1')) or
	((x > 333) and (x < 338) and (y > 200) and (y < 205) and (obst_locs_2(14) = '1')) or
	((x > 323) and (x < 328) and (y > 200) and (y < 205) and (obst_locs_2(13) = '1')) or
	((x > 313) and (x < 318) and (y > 200) and (y < 205) and (obst_locs_2(12) = '1')) or
	((x > 303) and (x < 308) and (y > 200) and (y < 205) and (obst_locs_2(11) = '1')) or
	((x > 293) and (x < 298) and (y > 200) and (y < 205) and (obst_locs_2(10) = '1')) or
	((x > 283) and (x < 288) and (y > 200) and (y < 205) and (obst_locs_2(9) = '1')) or
	((x > 273) and (x < 278) and (y > 200) and (y < 205) and (obst_locs_2(8) = '1')) or
	((x > 263) and (x < 268) and (y > 200) and (y < 205) and (obst_locs_2(7) = '1')) or
   ((x > 253) and (x < 258) and (y > 200) and (y < 205) and (obst_locs_2(6) = '1')) or
	((x > 243) and (x < 248) and (y > 200) and (y < 205) and (obst_locs_2(5) = '1')) or
	((x > 233) and (x < 238) and (y > 200) and (y < 205) and (obst_locs_2(4) = '1')) or
	((x > 223) and (x < 228) and (y > 200) and (y < 205) and (obst_locs_2(3) = '1')) or
	((x > 213) and (x < 218) and (y > 200) and (y < 205) and (obst_locs_2(2) = '1')) or
	((x > 203) and (x < 208) and (y > 200) and (y < 205) and (obst_locs_2(1) = '1')) or
	((x > 193) and (x < 198) and (y > 200) and (y < 205) and (obst_locs_2(0) = '1')) or

   ((x > 515) and (x < 520) and (y > 200) and (y < 205) and (obst_locs_2(31) = '1')) or
	((x > 505) and (x < 510) and (y > 200) and (y < 205) and (obst_locs_2(30) = '1')) or
   ((x > 495) and (x < 500) and (y > 200) and (y < 205) and (obst_locs_2(29) = '1')) or
	((x > 485) and (x < 490) and (y > 200) and (y < 205) and (obst_locs_2(28) = '1')) or
	((x > 475) and (x < 480) and (y > 200) and (y < 205) and (obst_locs_2(27) = '1')) or
	((x > 465) and (x < 470) and (y > 200) and (y < 205) and (obst_locs_2(26) = '1')) or
	((x > 455) and (x < 460) and (y > 200) and (y < 205) and (obst_locs_2(25) = '1')) or
   ((x > 445) and (x < 450) and (y > 200) and (y < 205) and (obst_locs_2(24) = '1')) or
   ((x > 435) and (x < 440) and (y > 200) and (y < 205) and (obst_locs_2(23) = '1')) or
	((x > 425) and (x < 430) and (y > 200) and (y < 205) and (obst_locs_2(22) = '1')) or
	((x > 415) and (x < 420) and (y > 200) and (y < 205) and (obst_locs_2(21) = '1')) or
	((x > 405) and (x < 410) and (y > 200) and (y < 205) and (obst_locs_2(20) = '1')) or
	((x > 395) and (x < 400) and (y > 200) and (y < 205) and (obst_locs_2(19) = '1')) or
	((x > 385) and (x < 390) and (y > 200) and (y < 205) and (obst_locs_2(18) = '1')) or
	((x > 375) and (x < 380) and (y > 200) and (y < 205) and (obst_locs_2(17) = '1')) or
	((x > 365) and (x < 370) and (y > 200) and (y < 205) and (obst_locs_2(16) = '1')) or
	((x > 355) and (x < 360) and (y > 200) and (y < 205) and (obst_locs_2(15) = '1')) or
	((x > 345) and (x < 350) and (y > 200) and (y < 205) and (obst_locs_2(14) = '1')) or
	((x > 335) and (x < 340) and (y > 200) and (y < 205) and (obst_locs_2(13) = '1')) or
	((x > 325) and (x < 330) and (y > 200) and (y < 205) and (obst_locs_2(12) = '1')) or
	((x > 315) and (x < 320) and (y > 200) and (y < 205) and (obst_locs_2(11) = '1')) or
	((x > 305) and (x < 310) and (y > 200) and (y < 205) and (obst_locs_2(10) = '1')) or
	((x > 295) and (x < 300) and (y > 200) and (y < 205) and (obst_locs_2(9) = '1')) or
	((x > 285) and (x < 290) and (y > 200) and (y < 205) and (obst_locs_2(8) = '1')) or
	((x > 275) and (x < 280) and (y > 200) and (y < 205) and (obst_locs_2(7) = '1')) or
   ((x > 265) and (x < 270) and (y > 200) and (y < 205) and (obst_locs_2(6) = '1')) or
	((x > 255) and (x < 260) and (y > 200) and (y < 205) and (obst_locs_2(5) = '1')) or
	((x > 245) and (x < 250) and (y > 200) and (y < 205) and (obst_locs_2(4) = '1')) or
	((x > 235) and (x < 240) and (y > 200) and (y < 205) and (obst_locs_2(3) = '1')) or
	((x > 225) and (x < 230) and (y > 200) and (y < 205) and (obst_locs_2(2) = '1')) or
	((x > 215) and (x < 220) and (y > 200) and (y < 205) and (obst_locs_2(1) = '1')) or
	((x > 205) and (x < 210) and (y > 200) and (y < 205) and (obst_locs_2(0) = '1')) or

   ((x > 500) and (x < 518) and (y > 205) and (y < 215) and (obst_locs_2(31) = '1')) or
	((x > 490) and (x < 508) and (y > 205) and (y < 215) and (obst_locs_2(30) = '1')) or
   ((x > 480) and (x < 498) and (y > 205) and (y < 215) and (obst_locs_2(29) = '1')) or
	((x > 470) and (x < 488) and (y > 205) and (y < 215) and (obst_locs_2(28) = '1')) or
	((x > 460) and (x < 478) and (y > 205) and (y < 215) and (obst_locs_2(27) = '1')) or
	((x > 450) and (x < 468) and (y > 205) and (y < 215) and (obst_locs_2(26) = '1')) or
	((x > 440) and (x < 458) and (y > 205) and (y < 215) and (obst_locs_2(25) = '1')) or
   ((x > 430) and (x < 448) and (y > 205) and (y < 215) and (obst_locs_2(24) = '1')) or
   ((x > 420) and (x < 438) and (y > 205) and (y < 215) and (obst_locs_2(23) = '1')) or
	((x > 410) and (x < 428) and (y > 205) and (y < 215) and (obst_locs_2(22) = '1')) or
	((x > 400) and (x < 418) and (y > 205) and (y < 215) and (obst_locs_2(21) = '1')) or
	((x > 390) and (x < 408) and (y > 205) and (y < 215) and (obst_locs_2(20) = '1')) or
	((x > 380) and (x < 398) and (y > 205) and (y < 215) and (obst_locs_2(19) = '1')) or
	((x > 370) and (x < 388) and (y > 205) and (y < 215) and (obst_locs_2(18) = '1')) or
	((x > 360) and (x < 378) and (y > 205) and (y < 215) and (obst_locs_2(17) = '1')) or
	((x > 350) and (x < 368) and (y > 205) and (y < 215) and (obst_locs_2(16) = '1')) or
	((x > 340) and (x < 358) and (y > 205) and (y < 215) and (obst_locs_2(15) = '1')) or
	((x > 330) and (x < 348) and (y > 205) and (y < 215) and (obst_locs_2(14) = '1')) or
	((x > 320) and (x < 338) and (y > 205) and (y < 215) and (obst_locs_2(13) = '1')) or
	((x > 310) and (x < 328) and (y > 205) and (y < 215) and (obst_locs_2(12) = '1')) or
	((x > 300) and (x < 318) and (y > 205) and (y < 215) and (obst_locs_2(11) = '1')) or
	((x > 290) and (x < 308) and (y > 205) and (y < 215) and (obst_locs_2(10) = '1')) or
	((x > 280) and (x < 298) and (y > 205) and (y < 215) and (obst_locs_2(9) = '1')) or
	((x > 270) and (x < 288) and (y > 205) and (y < 215) and (obst_locs_2(8) = '1')) or
	((x > 260) and (x < 278) and (y > 205) and (y < 215) and (obst_locs_2(7) = '1')) or
   ((x > 250) and (x < 268) and (y > 205) and (y < 215) and (obst_locs_2(6) = '1')) or
	((x > 240) and (x < 258) and (y > 205) and (y < 215) and (obst_locs_2(5) = '1')) or
	((x > 230) and (x < 248) and (y > 205) and (y < 215) and (obst_locs_2(4) = '1')) or
	((x > 220) and (x < 238) and (y > 205) and (y < 215) and (obst_locs_2(3) = '1')) or
	((x > 210) and (x < 228) and (y > 205) and (y < 215) and (obst_locs_2(2) = '1')) or
	((x > 200) and (x < 218) and (y > 205) and (y < 215) and (obst_locs_2(1) = '1')) or
	((x > 190) and (x < 208) and (y > 205) and (y < 215) and (obst_locs_2(0) = '1')) or

   ((x > 503) and (x < 508) and (y > 215) and (y < 220) and (obst_locs_2(31) = '1')) or
	((x > 493) and (x < 498) and (y > 215) and (y < 220) and (obst_locs_2(30) = '1')) or
   ((x > 483) and (x < 488) and (y > 215) and (y < 220) and (obst_locs_2(29) = '1')) or
	((x > 473) and (x < 478) and (y > 215) and (y < 220) and (obst_locs_2(28) = '1')) or
	((x > 463) and (x < 468) and (y > 215) and (y < 220) and (obst_locs_2(27) = '1')) or
	((x > 453) and (x < 458) and (y > 215) and (y < 220) and (obst_locs_2(26) = '1')) or
	((x > 443) and (x < 448) and (y > 215) and (y < 220) and (obst_locs_2(25) = '1')) or
   ((x > 433) and (x < 438) and (y > 215) and (y < 220) and (obst_locs_2(24) = '1')) or
   ((x > 423) and (x < 428) and (y > 215) and (y < 220) and (obst_locs_2(23) = '1')) or
	((x > 413) and (x < 418) and (y > 215) and (y < 220) and (obst_locs_2(22) = '1')) or
	((x > 403) and (x < 408) and (y > 215) and (y < 220) and (obst_locs_2(21) = '1')) or
	((x > 393) and (x < 398) and (y > 215) and (y < 220) and (obst_locs_2(20) = '1')) or
	((x > 383) and (x < 388) and (y > 215) and (y < 220) and (obst_locs_2(19) = '1')) or
	((x > 373) and (x < 378) and (y > 215) and (y < 220) and (obst_locs_2(18) = '1')) or
	((x > 363) and (x < 368) and (y > 215) and (y < 220) and (obst_locs_2(17) = '1')) or
	((x > 353) and (x < 358) and (y > 215) and (y < 220) and (obst_locs_2(16) = '1')) or
	((x > 343) and (x < 348) and (y > 215) and (y < 220) and (obst_locs_2(15) = '1')) or
	((x > 333) and (x < 338) and (y > 215) and (y < 220) and (obst_locs_2(14) = '1')) or
	((x > 323) and (x < 328) and (y > 215) and (y < 220) and (obst_locs_2(13) = '1')) or
	((x > 313) and (x < 318) and (y > 215) and (y < 220) and (obst_locs_2(12) = '1')) or
	((x > 303) and (x < 308) and (y > 215) and (y < 220) and (obst_locs_2(11) = '1')) or
	((x > 293) and (x < 298) and (y > 215) and (y < 220) and (obst_locs_2(10) = '1')) or
	((x > 283) and (x < 288) and (y > 215) and (y < 220) and (obst_locs_2(9) = '1')) or
	((x > 273) and (x < 278) and (y > 215) and (y < 220) and (obst_locs_2(8) = '1')) or
	((x > 263) and (x < 268) and (y > 215) and (y < 220) and (obst_locs_2(7) = '1')) or
   ((x > 253) and (x < 258) and (y > 215) and (y < 220) and (obst_locs_2(6) = '1')) or
	((x > 243) and (x < 248) and (y > 215) and (y < 220) and (obst_locs_2(5) = '1')) or
	((x > 233) and (x < 238) and (y > 215) and (y < 220) and (obst_locs_2(4) = '1')) or
	((x > 223) and (x < 228) and (y > 215) and (y < 220) and (obst_locs_2(3) = '1')) or
	((x > 213) and (x < 218) and (y > 215) and (y < 220) and (obst_locs_2(2) = '1')) or
	((x > 203) and (x < 208) and (y > 215) and (y < 220) and (obst_locs_2(1) = '1')) or
	((x > 193) and (x < 198) and (y > 215) and (y < 220) and (obst_locs_2(0) = '1')) or

   ((x > 515) and (x < 520) and (y > 215) and (y < 220) and (obst_locs_2(31) = '1')) or
	((x > 505) and (x < 510) and (y > 215) and (y < 220) and (obst_locs_2(30) = '1')) or
   ((x > 495) and (x < 500) and (y > 215) and (y < 220) and (obst_locs_2(29) = '1')) or
	((x > 485) and (x < 490) and (y > 215) and (y < 220) and (obst_locs_2(28) = '1')) or
	((x > 475) and (x < 480) and (y > 215) and (y < 220) and (obst_locs_2(27) = '1')) or
	((x > 465) and (x < 470) and (y > 215) and (y < 220) and (obst_locs_2(26) = '1')) or
	((x > 455) and (x < 460) and (y > 215) and (y < 220) and (obst_locs_2(25) = '1')) or
   ((x > 445) and (x < 450) and (y > 215) and (y < 220) and (obst_locs_2(24) = '1')) or
   ((x > 435) and (x < 440) and (y > 215) and (y < 220) and (obst_locs_2(23) = '1')) or
	((x > 425) and (x < 430) and (y > 215) and (y < 220) and (obst_locs_2(22) = '1')) or
	((x > 415) and (x < 420) and (y > 215) and (y < 220) and (obst_locs_2(21) = '1')) or
	((x > 405) and (x < 410) and (y > 215) and (y < 220) and (obst_locs_2(20) = '1')) or
	((x > 395) and (x < 400) and (y > 215) and (y < 220) and (obst_locs_2(19) = '1')) or
	((x > 385) and (x < 390) and (y > 215) and (y < 220) and (obst_locs_2(18) = '1')) or
	((x > 375) and (x < 380) and (y > 215) and (y < 220) and (obst_locs_2(17) = '1')) or
	((x > 365) and (x < 370) and (y > 215) and (y < 220) and (obst_locs_2(16) = '1')) or
	((x > 355) and (x < 360) and (y > 215) and (y < 220) and (obst_locs_2(15) = '1')) or
	((x > 345) and (x < 350) and (y > 215) and (y < 220) and (obst_locs_2(14) = '1')) or
	((x > 335) and (x < 340) and (y > 215) and (y < 220) and (obst_locs_2(13) = '1')) or
	((x > 325) and (x < 330) and (y > 215) and (y < 220) and (obst_locs_2(12) = '1')) or
	((x > 315) and (x < 320) and (y > 215) and (y < 220) and (obst_locs_2(11) = '1')) or
	((x > 305) and (x < 310) and (y > 215) and (y < 220) and (obst_locs_2(10) = '1')) or
	((x > 295) and (x < 300) and (y > 215) and (y < 220) and (obst_locs_2(9) = '1')) or
	((x > 285) and (x < 290) and (y > 215) and (y < 220) and (obst_locs_2(8) = '1')) or
	((x > 275) and (x < 280) and (y > 215) and (y < 220) and (obst_locs_2(7) = '1')) or
   ((x > 265) and (x < 270) and (y > 215) and (y < 220) and (obst_locs_2(6) = '1')) or
	((x > 255) and (x < 260) and (y > 215) and (y < 220) and (obst_locs_2(5) = '1')) or
	((x > 245) and (x < 250) and (y > 215) and (y < 220) and (obst_locs_2(4) = '1')) or
	((x > 235) and (x < 240) and (y > 215) and (y < 220) and (obst_locs_2(3) = '1')) or
	((x > 225) and (x < 230) and (y > 215) and (y < 220) and (obst_locs_2(2) = '1')) or
	((x > 215) and (x < 220) and (y > 215) and (y < 220) and (obst_locs_2(1) = '1')) or
	((x > 205) and (x < 210) and (y > 215) and (y < 220) and (obst_locs_2(0) = '1')) or

--These 32 are for lane 3.
   ((x > 503) and (x < 508) and (y > 300) and (y < 305) and (obst_locs_3(31) = '1')) or
	((x > 493) and (x < 498) and (y > 300) and (y < 305) and (obst_locs_3(30) = '1')) or
   ((x > 483) and (x < 488) and (y > 300) and (y < 305) and (obst_locs_3(29) = '1')) or
	((x > 473) and (x < 478) and (y > 300) and (y < 305) and (obst_locs_3(28) = '1')) or
	((x > 463) and (x < 468) and (y > 300) and (y < 305) and (obst_locs_3(27) = '1')) or
	((x > 453) and (x < 458) and (y > 300) and (y < 305) and (obst_locs_3(26) = '1')) or
	((x > 443) and (x < 448) and (y > 300) and (y < 305) and (obst_locs_3(25) = '1')) or
   ((x > 433) and (x < 438) and (y > 300) and (y < 305) and (obst_locs_3(24) = '1')) or
   ((x > 423) and (x < 428) and (y > 300) and (y < 305) and (obst_locs_3(23) = '1')) or
	((x > 413) and (x < 418) and (y > 300) and (y < 305) and (obst_locs_3(22) = '1')) or
	((x > 403) and (x < 408) and (y > 300) and (y < 305) and (obst_locs_3(21) = '1')) or
	((x > 393) and (x < 398) and (y > 300) and (y < 305) and (obst_locs_3(20) = '1')) or
	((x > 383) and (x < 388) and (y > 300) and (y < 305) and (obst_locs_3(19) = '1')) or
	((x > 373) and (x < 378) and (y > 300) and (y < 305) and (obst_locs_3(18) = '1')) or
	((x > 363) and (x < 368) and (y > 300) and (y < 305) and (obst_locs_3(17) = '1')) or
	((x > 353) and (x < 358) and (y > 300) and (y < 305) and (obst_locs_3(16) = '1')) or
	((x > 343) and (x < 348) and (y > 300) and (y < 305) and (obst_locs_3(15) = '1')) or
	((x > 333) and (x < 338) and (y > 300) and (y < 305) and (obst_locs_3(14) = '1')) or
	((x > 323) and (x < 328) and (y > 300) and (y < 305) and (obst_locs_3(13) = '1')) or
	((x > 313) and (x < 318) and (y > 300) and (y < 305) and (obst_locs_3(12) = '1')) or
	((x > 303) and (x < 308) and (y > 300) and (y < 305) and (obst_locs_3(11) = '1')) or
	((x > 293) and (x < 298) and (y > 300) and (y < 305) and (obst_locs_3(10) = '1')) or
	((x > 283) and (x < 288) and (y > 300) and (y < 305) and (obst_locs_3(9) = '1')) or
	((x > 273) and (x < 278) and (y > 300) and (y < 305) and (obst_locs_3(8) = '1')) or
	((x > 263) and (x < 268) and (y > 300) and (y < 305) and (obst_locs_3(7) = '1')) or
   ((x > 253) and (x < 258) and (y > 300) and (y < 305) and (obst_locs_3(6) = '1')) or
	((x > 243) and (x < 248) and (y > 300) and (y < 305) and (obst_locs_3(5) = '1')) or
	((x > 233) and (x < 238) and (y > 300) and (y < 305) and (obst_locs_3(4) = '1')) or
	((x > 223) and (x < 228) and (y > 300) and (y < 305) and (obst_locs_3(3) = '1')) or
	((x > 213) and (x < 218) and (y > 300) and (y < 305) and (obst_locs_3(2) = '1')) or
	((x > 203) and (x < 208) and (y > 300) and (y < 305) and (obst_locs_3(1) = '1')) or
	((x > 193) and (x < 198) and (y > 300) and (y < 305) and (obst_locs_3(0) = '1')) or

   ((x > 515) and (x < 520) and (y > 300) and (y < 305) and (obst_locs_3(31) = '1')) or
	((x > 505) and (x < 510) and (y > 300) and (y < 305) and (obst_locs_3(30) = '1')) or
   ((x > 495) and (x < 500) and (y > 300) and (y < 305) and (obst_locs_3(29) = '1')) or
	((x > 485) and (x < 490) and (y > 300) and (y < 305) and (obst_locs_3(28) = '1')) or
	((x > 475) and (x < 480) and (y > 300) and (y < 305) and (obst_locs_3(27) = '1')) or
	((x > 465) and (x < 470) and (y > 300) and (y < 305) and (obst_locs_3(26) = '1')) or
	((x > 455) and (x < 460) and (y > 300) and (y < 305) and (obst_locs_3(25) = '1')) or
   ((x > 445) and (x < 450) and (y > 300) and (y < 305) and (obst_locs_3(24) = '1')) or
   ((x > 435) and (x < 440) and (y > 300) and (y < 305) and (obst_locs_3(23) = '1')) or
	((x > 425) and (x < 430) and (y > 300) and (y < 305) and (obst_locs_3(22) = '1')) or
	((x > 415) and (x < 420) and (y > 300) and (y < 305) and (obst_locs_3(21) = '1')) or
	((x > 405) and (x < 410) and (y > 300) and (y < 305) and (obst_locs_3(20) = '1')) or
	((x > 395) and (x < 400) and (y > 300) and (y < 305) and (obst_locs_3(19) = '1')) or
	((x > 385) and (x < 390) and (y > 300) and (y < 305) and (obst_locs_3(18) = '1')) or
	((x > 375) and (x < 380) and (y > 300) and (y < 305) and (obst_locs_3(17) = '1')) or
	((x > 365) and (x < 370) and (y > 300) and (y < 305) and (obst_locs_3(16) = '1')) or
	((x > 355) and (x < 360) and (y > 300) and (y < 305) and (obst_locs_3(15) = '1')) or
	((x > 345) and (x < 350) and (y > 300) and (y < 305) and (obst_locs_3(14) = '1')) or
	((x > 335) and (x < 340) and (y > 300) and (y < 305) and (obst_locs_3(13) = '1')) or
	((x > 325) and (x < 330) and (y > 300) and (y < 305) and (obst_locs_3(12) = '1')) or
	((x > 315) and (x < 320) and (y > 300) and (y < 305) and (obst_locs_3(11) = '1')) or
	((x > 305) and (x < 310) and (y > 300) and (y < 305) and (obst_locs_3(10) = '1')) or
	((x > 295) and (x < 300) and (y > 300) and (y < 305) and (obst_locs_3(9) = '1')) or
	((x > 285) and (x < 290) and (y > 300) and (y < 305) and (obst_locs_3(8) = '1')) or
	((x > 275) and (x < 280) and (y > 300) and (y < 305) and (obst_locs_3(7) = '1')) or
   ((x > 265) and (x < 270) and (y > 300) and (y < 305) and (obst_locs_3(6) = '1')) or
	((x > 255) and (x < 260) and (y > 300) and (y < 305) and (obst_locs_3(5) = '1')) or
	((x > 245) and (x < 250) and (y > 300) and (y < 305) and (obst_locs_3(4) = '1')) or
	((x > 235) and (x < 240) and (y > 300) and (y < 305) and (obst_locs_3(3) = '1')) or
	((x > 225) and (x < 230) and (y > 300) and (y < 305) and (obst_locs_3(2) = '1')) or
	((x > 215) and (x < 220) and (y > 300) and (y < 305) and (obst_locs_3(1) = '1')) or
	((x > 205) and (x < 210) and (y > 300) and (y < 305) and (obst_locs_3(0) = '1')) or

   ((x > 500) and (x < 518) and (y > 305) and (y < 315) and (obst_locs_3(31) = '1')) or
	((x > 490) and (x < 508) and (y > 305) and (y < 315) and (obst_locs_3(30) = '1')) or
   ((x > 480) and (x < 498) and (y > 305) and (y < 315) and (obst_locs_3(29) = '1')) or
	((x > 470) and (x < 488) and (y > 305) and (y < 315) and (obst_locs_3(28) = '1')) or
	((x > 460) and (x < 478) and (y > 305) and (y < 315) and (obst_locs_3(27) = '1')) or
	((x > 450) and (x < 468) and (y > 305) and (y < 315) and (obst_locs_3(26) = '1')) or
	((x > 440) and (x < 458) and (y > 305) and (y < 315) and (obst_locs_3(25) = '1')) or
   ((x > 430) and (x < 448) and (y > 305) and (y < 315) and (obst_locs_3(24) = '1')) or
   ((x > 420) and (x < 438) and (y > 305) and (y < 315) and (obst_locs_3(23) = '1')) or
	((x > 410) and (x < 428) and (y > 305) and (y < 315) and (obst_locs_3(22) = '1')) or
	((x > 400) and (x < 418) and (y > 305) and (y < 315) and (obst_locs_3(21) = '1')) or
	((x > 390) and (x < 408) and (y > 305) and (y < 315) and (obst_locs_3(20) = '1')) or
	((x > 380) and (x < 398) and (y > 305) and (y < 315) and (obst_locs_3(19) = '1')) or
	((x > 370) and (x < 388) and (y > 305) and (y < 315) and (obst_locs_3(18) = '1')) or
	((x > 360) and (x < 378) and (y > 305) and (y < 315) and (obst_locs_3(17) = '1')) or
	((x > 350) and (x < 368) and (y > 305) and (y < 315) and (obst_locs_3(16) = '1')) or
	((x > 340) and (x < 358) and (y > 305) and (y < 315) and (obst_locs_3(15) = '1')) or
	((x > 330) and (x < 348) and (y > 305) and (y < 315) and (obst_locs_3(14) = '1')) or
	((x > 320) and (x < 338) and (y > 305) and (y < 315) and (obst_locs_3(13) = '1')) or
	((x > 310) and (x < 328) and (y > 305) and (y < 315) and (obst_locs_3(12) = '1')) or
	((x > 300) and (x < 318) and (y > 305) and (y < 315) and (obst_locs_3(11) = '1')) or
	((x > 290) and (x < 308) and (y > 305) and (y < 315) and (obst_locs_3(10) = '1')) or
	((x > 280) and (x < 298) and (y > 305) and (y < 315) and (obst_locs_3(9) = '1')) or
	((x > 270) and (x < 288) and (y > 305) and (y < 315) and (obst_locs_3(8) = '1')) or
	((x > 260) and (x < 278) and (y > 305) and (y < 315) and (obst_locs_3(7) = '1')) or
   ((x > 250) and (x < 268) and (y > 305) and (y < 315) and (obst_locs_3(6) = '1')) or
	((x > 240) and (x < 258) and (y > 305) and (y < 315) and (obst_locs_3(5) = '1')) or
	((x > 230) and (x < 248) and (y > 305) and (y < 315) and (obst_locs_3(4) = '1')) or
	((x > 220) and (x < 238) and (y > 305) and (y < 315) and (obst_locs_3(3) = '1')) or
	((x > 210) and (x < 228) and (y > 305) and (y < 315) and (obst_locs_3(2) = '1')) or
	((x > 200) and (x < 218) and (y > 305) and (y < 315) and (obst_locs_3(1) = '1')) or
	((x > 190) and (x < 208) and (y > 305) and (y < 315) and (obst_locs_3(0) = '1')) or

   ((x > 503) and (x < 508) and (y > 315) and (y < 320) and (obst_locs_3(31) = '1')) or
	((x > 493) and (x < 498) and (y > 315) and (y < 320) and (obst_locs_3(30) = '1')) or
   ((x > 483) and (x < 488) and (y > 315) and (y < 320) and (obst_locs_3(29) = '1')) or
	((x > 473) and (x < 478) and (y > 315) and (y < 320) and (obst_locs_3(28) = '1')) or
	((x > 463) and (x < 468) and (y > 315) and (y < 320) and (obst_locs_3(27) = '1')) or
	((x > 453) and (x < 458) and (y > 315) and (y < 320) and (obst_locs_3(26) = '1')) or
	((x > 443) and (x < 448) and (y > 315) and (y < 320) and (obst_locs_3(25) = '1')) or
   ((x > 433) and (x < 438) and (y > 315) and (y < 320) and (obst_locs_3(24) = '1')) or
   ((x > 423) and (x < 428) and (y > 315) and (y < 320) and (obst_locs_3(23) = '1')) or
	((x > 413) and (x < 418) and (y > 315) and (y < 320) and (obst_locs_3(22) = '1')) or
	((x > 403) and (x < 408) and (y > 315) and (y < 320) and (obst_locs_3(21) = '1')) or
	((x > 393) and (x < 398) and (y > 315) and (y < 320) and (obst_locs_3(20) = '1')) or
	((x > 383) and (x < 388) and (y > 315) and (y < 320) and (obst_locs_3(19) = '1')) or
	((x > 373) and (x < 378) and (y > 315) and (y < 320) and (obst_locs_3(18) = '1')) or
	((x > 363) and (x < 368) and (y > 315) and (y < 320) and (obst_locs_3(17) = '1')) or
	((x > 353) and (x < 358) and (y > 315) and (y < 320) and (obst_locs_3(16) = '1')) or
	((x > 343) and (x < 348) and (y > 315) and (y < 320) and (obst_locs_3(15) = '1')) or
	((x > 333) and (x < 338) and (y > 315) and (y < 320) and (obst_locs_3(14) = '1')) or
	((x > 323) and (x < 328) and (y > 315) and (y < 320) and (obst_locs_3(13) = '1')) or
	((x > 313) and (x < 318) and (y > 315) and (y < 320) and (obst_locs_3(12) = '1')) or
	((x > 303) and (x < 308) and (y > 315) and (y < 320) and (obst_locs_3(11) = '1')) or
	((x > 293) and (x < 298) and (y > 315) and (y < 320) and (obst_locs_3(10) = '1')) or
	((x > 283) and (x < 288) and (y > 315) and (y < 320) and (obst_locs_3(9) = '1')) or
	((x > 273) and (x < 278) and (y > 315) and (y < 320) and (obst_locs_3(8) = '1')) or
	((x > 263) and (x < 268) and (y > 315) and (y < 320) and (obst_locs_3(7) = '1')) or
   ((x > 253) and (x < 258) and (y > 315) and (y < 320) and (obst_locs_3(6) = '1')) or
	((x > 243) and (x < 248) and (y > 315) and (y < 320) and (obst_locs_3(5) = '1')) or
	((x > 233) and (x < 238) and (y > 315) and (y < 320) and (obst_locs_3(4) = '1')) or
	((x > 223) and (x < 228) and (y > 315) and (y < 320) and (obst_locs_3(3) = '1')) or
	((x > 213) and (x < 218) and (y > 315) and (y < 320) and (obst_locs_3(2) = '1')) or
	((x > 203) and (x < 208) and (y > 315) and (y < 320) and (obst_locs_3(1) = '1')) or
	((x > 193) and (x < 198) and (y > 315) and (y < 320) and (obst_locs_3(0) = '1')) or

   ((x > 515) and (x < 520) and (y > 315) and (y < 320) and (obst_locs_3(31) = '1')) or
	((x > 505) and (x < 510) and (y > 315) and (y < 320) and (obst_locs_3(30) = '1')) or
   ((x > 495) and (x < 500) and (y > 315) and (y < 320) and (obst_locs_3(29) = '1')) or
	((x > 485) and (x < 490) and (y > 315) and (y < 320) and (obst_locs_3(28) = '1')) or
	((x > 475) and (x < 480) and (y > 315) and (y < 320) and (obst_locs_3(27) = '1')) or
	((x > 465) and (x < 470) and (y > 315) and (y < 320) and (obst_locs_3(26) = '1')) or
	((x > 455) and (x < 460) and (y > 315) and (y < 320) and (obst_locs_3(25) = '1')) or
   ((x > 445) and (x < 450) and (y > 315) and (y < 320) and (obst_locs_3(24) = '1')) or
   ((x > 435) and (x < 440) and (y > 315) and (y < 320) and (obst_locs_3(23) = '1')) or
	((x > 425) and (x < 430) and (y > 315) and (y < 320) and (obst_locs_3(22) = '1')) or
	((x > 415) and (x < 420) and (y > 315) and (y < 320) and (obst_locs_3(21) = '1')) or
	((x > 405) and (x < 410) and (y > 315) and (y < 320) and (obst_locs_3(20) = '1')) or
	((x > 395) and (x < 400) and (y > 315) and (y < 320) and (obst_locs_3(19) = '1')) or
	((x > 385) and (x < 390) and (y > 315) and (y < 320) and (obst_locs_3(18) = '1')) or
	((x > 375) and (x < 380) and (y > 315) and (y < 320) and (obst_locs_3(17) = '1')) or
	((x > 365) and (x < 370) and (y > 315) and (y < 320) and (obst_locs_3(16) = '1')) or
	((x > 355) and (x < 360) and (y > 315) and (y < 320) and (obst_locs_3(15) = '1')) or
	((x > 345) and (x < 350) and (y > 315) and (y < 320) and (obst_locs_3(14) = '1')) or
	((x > 335) and (x < 340) and (y > 315) and (y < 320) and (obst_locs_3(13) = '1')) or
	((x > 325) and (x < 330) and (y > 315) and (y < 320) and (obst_locs_3(12) = '1')) or
	((x > 315) and (x < 320) and (y > 315) and (y < 320) and (obst_locs_3(11) = '1')) or
	((x > 305) and (x < 310) and (y > 315) and (y < 320) and (obst_locs_3(10) = '1')) or
	((x > 295) and (x < 300) and (y > 315) and (y < 320) and (obst_locs_3(9) = '1')) or
	((x > 285) and (x < 290) and (y > 315) and (y < 320) and (obst_locs_3(8) = '1')) or
	((x > 275) and (x < 280) and (y > 315) and (y < 320) and (obst_locs_3(7) = '1')) or
   ((x > 265) and (x < 270) and (y > 315) and (y < 320) and (obst_locs_3(6) = '1')) or
	((x > 255) and (x < 260) and (y > 315) and (y < 320) and (obst_locs_3(5) = '1')) or
	((x > 245) and (x < 250) and (y > 315) and (y < 320) and (obst_locs_3(4) = '1')) or
	((x > 235) and (x < 240) and (y > 315) and (y < 320) and (obst_locs_3(3) = '1')) or
	((x > 225) and (x < 230) and (y > 315) and (y < 320) and (obst_locs_3(2) = '1')) or
	((x > 215) and (x < 220) and (y > 315) and (y < 320) and (obst_locs_3(1) = '1')) or
	((x > 205) and (x < 210) and (y > 315) and (y < 320) and (obst_locs_3(0) = '1')) or

--These 32 are for lane 4.
   
	((x > 503) and (x < 508) and (y > 400) and (y < 405) and (obst_locs_4(31) = '1')) or
	((x > 493) and (x < 498) and (y > 400) and (y < 405) and (obst_locs_4(30) = '1')) or
   ((x > 483) and (x < 488) and (y > 400) and (y < 405) and (obst_locs_4(29) = '1')) or
	((x > 473) and (x < 478) and (y > 400) and (y < 405) and (obst_locs_4(28) = '1')) or
	((x > 463) and (x < 468) and (y > 400) and (y < 405) and (obst_locs_4(27) = '1')) or
	((x > 453) and (x < 458) and (y > 400) and (y < 405) and (obst_locs_4(26) = '1')) or
	((x > 443) and (x < 448) and (y > 400) and (y < 405) and (obst_locs_4(25) = '1')) or
   ((x > 433) and (x < 438) and (y > 400) and (y < 405) and (obst_locs_4(24) = '1')) or
   ((x > 423) and (x < 428) and (y > 400) and (y < 405) and (obst_locs_4(23) = '1')) or
	((x > 413) and (x < 418) and (y > 400) and (y < 405) and (obst_locs_4(22) = '1')) or
	((x > 403) and (x < 408) and (y > 400) and (y < 405) and (obst_locs_4(21) = '1')) or
	((x > 393) and (x < 398) and (y > 400) and (y < 405) and (obst_locs_4(20) = '1')) or
	((x > 383) and (x < 388) and (y > 400) and (y < 405) and (obst_locs_4(19) = '1')) or
	((x > 373) and (x < 378) and (y > 400) and (y < 405) and (obst_locs_4(18) = '1')) or
	((x > 363) and (x < 368) and (y > 400) and (y < 405) and (obst_locs_4(17) = '1')) or
	((x > 353) and (x < 358) and (y > 400) and (y < 405) and (obst_locs_4(16) = '1')) or
	((x > 343) and (x < 348) and (y > 400) and (y < 405) and (obst_locs_4(15) = '1')) or
	((x > 333) and (x < 338) and (y > 400) and (y < 405) and (obst_locs_4(14) = '1')) or
	((x > 323) and (x < 328) and (y > 400) and (y < 405) and (obst_locs_4(13) = '1')) or
	((x > 313) and (x < 318) and (y > 400) and (y < 405) and (obst_locs_4(12) = '1')) or
	((x > 303) and (x < 308) and (y > 400) and (y < 405) and (obst_locs_4(11) = '1')) or
	((x > 293) and (x < 298) and (y > 400) and (y < 405) and (obst_locs_4(10) = '1')) or
	((x > 283) and (x < 288) and (y > 400) and (y < 405) and (obst_locs_4(9) = '1')) or
	((x > 273) and (x < 278) and (y > 400) and (y < 405) and (obst_locs_4(8) = '1')) or
	((x > 263) and (x < 268) and (y > 400) and (y < 405) and (obst_locs_4(7) = '1')) or
   ((x > 253) and (x < 258) and (y > 400) and (y < 405) and (obst_locs_4(6) = '1')) or
	((x > 243) and (x < 248) and (y > 400) and (y < 405) and (obst_locs_4(5) = '1')) or
	((x > 233) and (x < 238) and (y > 400) and (y < 405) and (obst_locs_4(4) = '1')) or
	((x > 223) and (x < 228) and (y > 400) and (y < 405) and (obst_locs_4(3) = '1')) or
	((x > 213) and (x < 218) and (y > 400) and (y < 405) and (obst_locs_4(2) = '1')) or
	((x > 203) and (x < 208) and (y > 400) and (y < 405) and (obst_locs_4(1) = '1')) or
	((x > 193) and (x < 198) and (y > 400) and (y < 405) and (obst_locs_4(0) = '1')) or

   ((x > 515) and (x < 520) and (y > 400) and (y < 405) and (obst_locs_4(31) = '1')) or
	((x > 505) and (x < 510) and (y > 400) and (y < 405) and (obst_locs_4(30) = '1')) or
   ((x > 495) and (x < 500) and (y > 400) and (y < 405) and (obst_locs_4(29) = '1')) or
	((x > 485) and (x < 490) and (y > 400) and (y < 405) and (obst_locs_4(28) = '1')) or
	((x > 475) and (x < 480) and (y > 400) and (y < 405) and (obst_locs_4(27) = '1')) or
	((x > 465) and (x < 470) and (y > 400) and (y < 405) and (obst_locs_4(26) = '1')) or
	((x > 455) and (x < 460) and (y > 400) and (y < 405) and (obst_locs_4(25) = '1')) or
   ((x > 445) and (x < 450) and (y > 400) and (y < 405) and (obst_locs_4(24) = '1')) or
   ((x > 435) and (x < 440) and (y > 400) and (y < 405) and (obst_locs_4(23) = '1')) or
	((x > 425) and (x < 430) and (y > 400) and (y < 405) and (obst_locs_4(22) = '1')) or
	((x > 415) and (x < 420) and (y > 400) and (y < 405) and (obst_locs_4(21) = '1')) or
	((x > 405) and (x < 410) and (y > 400) and (y < 405) and (obst_locs_4(20) = '1')) or
	((x > 395) and (x < 400) and (y > 400) and (y < 405) and (obst_locs_4(19) = '1')) or
	((x > 385) and (x < 390) and (y > 400) and (y < 405) and (obst_locs_4(18) = '1')) or
	((x > 375) and (x < 380) and (y > 400) and (y < 405) and (obst_locs_4(17) = '1')) or
	((x > 365) and (x < 370) and (y > 400) and (y < 405) and (obst_locs_4(16) = '1')) or
	((x > 355) and (x < 360) and (y > 400) and (y < 405) and (obst_locs_4(15) = '1')) or
	((x > 345) and (x < 350) and (y > 400) and (y < 405) and (obst_locs_4(14) = '1')) or
	((x > 335) and (x < 340) and (y > 400) and (y < 405) and (obst_locs_4(13) = '1')) or
	((x > 325) and (x < 330) and (y > 400) and (y < 405) and (obst_locs_4(12) = '1')) or
	((x > 315) and (x < 320) and (y > 400) and (y < 405) and (obst_locs_4(11) = '1')) or
	((x > 305) and (x < 310) and (y > 400) and (y < 405) and (obst_locs_4(10) = '1')) or
	((x > 295) and (x < 300) and (y > 400) and (y < 405) and (obst_locs_4(9) = '1')) or
	((x > 285) and (x < 290) and (y > 400) and (y < 405) and (obst_locs_4(8) = '1')) or
	((x > 275) and (x < 280) and (y > 400) and (y < 405) and (obst_locs_4(7) = '1')) or
   ((x > 265) and (x < 270) and (y > 400) and (y < 405) and (obst_locs_4(6) = '1')) or
	((x > 255) and (x < 260) and (y > 400) and (y < 405) and (obst_locs_4(5) = '1')) or
	((x > 245) and (x < 250) and (y > 400) and (y < 405) and (obst_locs_4(4) = '1')) or
	((x > 235) and (x < 240) and (y > 400) and (y < 405) and (obst_locs_4(3) = '1')) or
	((x > 225) and (x < 230) and (y > 400) and (y < 405) and (obst_locs_4(2) = '1')) or
	((x > 215) and (x < 220) and (y > 400) and (y < 405) and (obst_locs_4(1) = '1')) or
	((x > 205) and (x < 210) and (y > 400) and (y < 405) and (obst_locs_4(0) = '1')) or

   ((x > 500) and (x < 518) and (y > 405) and (y < 415) and (obst_locs_4(31) = '1')) or
	((x > 490) and (x < 508) and (y > 405) and (y < 415) and (obst_locs_4(30) = '1')) or
   ((x > 480) and (x < 498) and (y > 405) and (y < 415) and (obst_locs_4(29) = '1')) or
	((x > 470) and (x < 488) and (y > 405) and (y < 415) and (obst_locs_4(28) = '1')) or
	((x > 460) and (x < 478) and (y > 405) and (y < 415) and (obst_locs_4(27) = '1')) or
	((x > 450) and (x < 468) and (y > 405) and (y < 415) and (obst_locs_4(26) = '1')) or
	((x > 440) and (x < 458) and (y > 405) and (y < 415) and (obst_locs_4(25) = '1')) or
   ((x > 430) and (x < 448) and (y > 405) and (y < 415) and (obst_locs_4(24) = '1')) or
   ((x > 420) and (x < 438) and (y > 405) and (y < 415) and (obst_locs_4(23) = '1')) or
	((x > 410) and (x < 428) and (y > 405) and (y < 415) and (obst_locs_4(22) = '1')) or
	((x > 400) and (x < 418) and (y > 405) and (y < 415) and (obst_locs_4(21) = '1')) or
	((x > 390) and (x < 408) and (y > 405) and (y < 415) and (obst_locs_4(20) = '1')) or
	((x > 380) and (x < 398) and (y > 405) and (y < 415) and (obst_locs_4(19) = '1')) or
	((x > 370) and (x < 388) and (y > 405) and (y < 415) and (obst_locs_4(18) = '1')) or
	((x > 360) and (x < 378) and (y > 405) and (y < 415) and (obst_locs_4(17) = '1')) or
	((x > 350) and (x < 368) and (y > 405) and (y < 415) and (obst_locs_4(16) = '1')) or
	((x > 340) and (x < 358) and (y > 405) and (y < 415) and (obst_locs_4(15) = '1')) or
	((x > 330) and (x < 348) and (y > 405) and (y < 415) and (obst_locs_4(14) = '1')) or
	((x > 320) and (x < 338) and (y > 405) and (y < 415) and (obst_locs_4(13) = '1')) or
	((x > 310) and (x < 328) and (y > 405) and (y < 415) and (obst_locs_4(12) = '1')) or
	((x > 300) and (x < 318) and (y > 405) and (y < 415) and (obst_locs_4(11) = '1')) or
	((x > 290) and (x < 308) and (y > 405) and (y < 415) and (obst_locs_4(10) = '1')) or
	((x > 280) and (x < 298) and (y > 405) and (y < 415) and (obst_locs_4(9) = '1')) or
	((x > 270) and (x < 288) and (y > 405) and (y < 415) and (obst_locs_4(8) = '1')) or
	((x > 260) and (x < 278) and (y > 405) and (y < 415) and (obst_locs_4(7) = '1')) or
   ((x > 250) and (x < 268) and (y > 405) and (y < 415) and (obst_locs_4(6) = '1')) or
	((x > 240) and (x < 258) and (y > 405) and (y < 415) and (obst_locs_4(5) = '1')) or
	((x > 230) and (x < 248) and (y > 405) and (y < 415) and (obst_locs_4(4) = '1')) or
	((x > 220) and (x < 238) and (y > 405) and (y < 415) and (obst_locs_4(3) = '1')) or
	((x > 210) and (x < 228) and (y > 405) and (y < 415) and (obst_locs_4(2) = '1')) or
	((x > 200) and (x < 218) and (y > 405) and (y < 415) and (obst_locs_4(1) = '1')) or
	((x > 190) and (x < 208) and (y > 405) and (y < 415) and (obst_locs_4(0) = '1')) or

   ((x > 503) and (x < 508) and (y > 415) and (y < 420) and (obst_locs_4(31) = '1')) or
	((x > 493) and (x < 498) and (y > 415) and (y < 420) and (obst_locs_4(30) = '1')) or
   ((x > 483) and (x < 488) and (y > 415) and (y < 420) and (obst_locs_4(29) = '1')) or
	((x > 473) and (x < 478) and (y > 415) and (y < 420) and (obst_locs_4(28) = '1')) or
	((x > 463) and (x < 468) and (y > 415) and (y < 420) and (obst_locs_4(27) = '1')) or
	((x > 453) and (x < 458) and (y > 415) and (y < 420) and (obst_locs_4(26) = '1')) or
	((x > 443) and (x < 448) and (y > 415) and (y < 420) and (obst_locs_4(25) = '1')) or
   ((x > 433) and (x < 438) and (y > 415) and (y < 420) and (obst_locs_4(24) = '1')) or
   ((x > 423) and (x < 428) and (y > 415) and (y < 420) and (obst_locs_4(23) = '1')) or
	((x > 413) and (x < 418) and (y > 415) and (y < 420) and (obst_locs_4(22) = '1')) or
	((x > 403) and (x < 408) and (y > 415) and (y < 420) and (obst_locs_4(21) = '1')) or
	((x > 393) and (x < 398) and (y > 415) and (y < 420) and (obst_locs_4(20) = '1')) or
	((x > 383) and (x < 388) and (y > 415) and (y < 420) and (obst_locs_4(19) = '1')) or
	((x > 373) and (x < 378) and (y > 415) and (y < 420) and (obst_locs_4(18) = '1')) or
	((x > 363) and (x < 368) and (y > 415) and (y < 420) and (obst_locs_4(17) = '1')) or
	((x > 353) and (x < 358) and (y > 415) and (y < 420) and (obst_locs_4(16) = '1')) or
	((x > 343) and (x < 348) and (y > 415) and (y < 420) and (obst_locs_4(15) = '1')) or
	((x > 333) and (x < 338) and (y > 415) and (y < 420) and (obst_locs_4(14) = '1')) or
	((x > 323) and (x < 328) and (y > 415) and (y < 420) and (obst_locs_4(13) = '1')) or
	((x > 313) and (x < 318) and (y > 415) and (y < 420) and (obst_locs_4(12) = '1')) or
	((x > 303) and (x < 308) and (y > 415) and (y < 420) and (obst_locs_4(11) = '1')) or
	((x > 293) and (x < 298) and (y > 415) and (y < 420) and (obst_locs_4(10) = '1')) or
	((x > 283) and (x < 288) and (y > 415) and (y < 420) and (obst_locs_4(9) = '1')) or
	((x > 273) and (x < 278) and (y > 415) and (y < 420) and (obst_locs_4(8) = '1')) or
	((x > 263) and (x < 268) and (y > 415) and (y < 420) and (obst_locs_4(7) = '1')) or
   ((x > 253) and (x < 258) and (y > 415) and (y < 420) and (obst_locs_4(6) = '1')) or
	((x > 243) and (x < 248) and (y > 415) and (y < 420) and (obst_locs_4(5) = '1')) or
	((x > 233) and (x < 238) and (y > 415) and (y < 420) and (obst_locs_4(4) = '1')) or
	((x > 223) and (x < 228) and (y > 415) and (y < 420) and (obst_locs_4(3) = '1')) or
	((x > 213) and (x < 218) and (y > 415) and (y < 420) and (obst_locs_4(2) = '1')) or
	((x > 203) and (x < 208) and (y > 415) and (y < 420) and (obst_locs_4(1) = '1')) or
	((x > 193) and (x < 198) and (y > 415) and (y < 420) and (obst_locs_4(0) = '1')) or

   ((x > 515) and (x < 520) and (y > 415) and (y < 420) and (obst_locs_4(31) = '1')) or
	((x > 505) and (x < 510) and (y > 415) and (y < 420) and (obst_locs_4(30) = '1')) or
   ((x > 495) and (x < 500) and (y > 415) and (y < 420) and (obst_locs_4(29) = '1')) or
	((x > 485) and (x < 490) and (y > 415) and (y < 420) and (obst_locs_4(28) = '1')) or
	((x > 475) and (x < 480) and (y > 415) and (y < 420) and (obst_locs_4(27) = '1')) or
	((x > 465) and (x < 470) and (y > 415) and (y < 420) and (obst_locs_4(26) = '1')) or
	((x > 455) and (x < 460) and (y > 415) and (y < 420) and (obst_locs_4(25) = '1')) or
   ((x > 445) and (x < 450) and (y > 415) and (y < 420) and (obst_locs_4(24) = '1')) or
   ((x > 435) and (x < 440) and (y > 415) and (y < 420) and (obst_locs_4(23) = '1')) or
	((x > 425) and (x < 430) and (y > 415) and (y < 420) and (obst_locs_4(22) = '1')) or
	((x > 415) and (x < 420) and (y > 415) and (y < 420) and (obst_locs_4(21) = '1')) or
	((x > 405) and (x < 410) and (y > 415) and (y < 420) and (obst_locs_4(20) = '1')) or
	((x > 395) and (x < 400) and (y > 415) and (y < 420) and (obst_locs_4(19) = '1')) or
	((x > 385) and (x < 390) and (y > 415) and (y < 420) and (obst_locs_4(18) = '1')) or
	((x > 375) and (x < 380) and (y > 415) and (y < 420) and (obst_locs_4(17) = '1')) or
	((x > 365) and (x < 370) and (y > 415) and (y < 420) and (obst_locs_4(16) = '1')) or
	((x > 355) and (x < 360) and (y > 415) and (y < 420) and (obst_locs_4(15) = '1')) or
	((x > 345) and (x < 350) and (y > 415) and (y < 420) and (obst_locs_4(14) = '1')) or
	((x > 335) and (x < 340) and (y > 415) and (y < 420) and (obst_locs_4(13) = '1')) or
	((x > 325) and (x < 330) and (y > 415) and (y < 420) and (obst_locs_4(12) = '1')) or
	((x > 315) and (x < 320) and (y > 415) and (y < 420) and (obst_locs_4(11) = '1')) or
	((x > 305) and (x < 310) and (y > 415) and (y < 420) and (obst_locs_4(10) = '1')) or
	((x > 295) and (x < 300) and (y > 415) and (y < 420) and (obst_locs_4(9) = '1')) or
	((x > 285) and (x < 290) and (y > 415) and (y < 420) and (obst_locs_4(8) = '1')) or
	((x > 275) and (x < 280) and (y > 415) and (y < 420) and (obst_locs_4(7) = '1')) or
   ((x > 265) and (x < 270) and (y > 415) and (y < 420) and (obst_locs_4(6) = '1')) or
	((x > 255) and (x < 260) and (y > 415) and (y < 420) and (obst_locs_4(5) = '1')) or
	((x > 245) and (x < 250) and (y > 415) and (y < 420) and (obst_locs_4(4) = '1')) or
	((x > 235) and (x < 240) and (y > 415) and (y < 420) and (obst_locs_4(3) = '1')) or
	((x > 225) and (x < 230) and (y > 415) and (y < 420) and (obst_locs_4(2) = '1')) or
	((x > 215) and (x < 220) and (y > 415) and (y < 420) and (obst_locs_4(1) = '1')) or
	((x > 205) and (x < 210) and (y > 415) and (y < 420) and (obst_locs_4(0) = '1')) 
	) else '0';

	
draw_plyr <= '1' when
  (
-- ANCIENS
	((x > 190) and (x < 197) and (y > 100) and (y < 105) and (h_player_loc = "00") and (player_loc = "1000")) or
	((x > 205) and (x < 212) and (y > 100) and (y < 105) and (h_player_loc = "00") and (player_loc = "1000")) or
	((x > 193) and (x < 216) and (y > 105) and (y < 115) and (h_player_loc = "00") and (player_loc = "1000")) or
	((x > 190) and (x < 197) and (y > 115) and (y < 120) and (h_player_loc = "00") and (player_loc = "1000")) or
	((x > 205) and (x < 212) and (y > 115) and (y < 120) and (h_player_loc = "00") and (player_loc = "1000")) or
	
	((x > 200) and (x < 207) and (y > 100) and (y < 105) and (h_player_loc = "01") and (player_loc = "1000")) or
	((x > 215) and (x < 222) and (y > 100) and (y < 105) and (h_player_loc = "01") and (player_loc = "1000")) or
	((x > 203) and (x < 226) and (y > 105) and (y < 115) and (h_player_loc = "01") and (player_loc = "1000")) or
	((x > 200) and (x < 207) and (y > 115) and (y < 120) and (h_player_loc = "01") and (player_loc = "1000")) or
	((x > 215) and (x < 222) and (y > 115) and (y < 120) and (h_player_loc = "01") and (player_loc = "1000")) or
	
	((x > 210) and (x < 217) and (y > 100) and (y < 105) and (h_player_loc = "10") and (player_loc = "1000")) or
	((x > 225) and (x < 232) and (y > 100) and (y < 105) and (h_player_loc = "10") and (player_loc = "1000")) or
	((x > 213) and (x < 236) and (y > 105) and (y < 115) and (h_player_loc = "10") and (player_loc = "1000")) or
	((x > 210) and (x < 217) and (y > 115) and (y < 120) and (h_player_loc = "10") and (player_loc = "1000")) or
	((x > 225) and (x < 232) and (y > 115) and (y < 120) and (h_player_loc = "10") and (player_loc = "1000")) or 
--	END FIRST LANE
	((x > 190) and (x < 197) and (y > 200) and (y < 205) and (h_player_loc = "00") and (player_loc = "0100")) or
	((x > 205) and (x < 212) and (y > 200) and (y < 205) and (h_player_loc = "00") and (player_loc = "0100")) or
	((x > 193) and (x < 216) and (y > 205) and (y < 215) and (h_player_loc = "00") and (player_loc = "0100")) or
	((x > 190) and (x < 197) and (y > 215) and (y < 220) and (h_player_loc = "00") and (player_loc = "0100")) or
	((x > 205) and (x < 212) and (y > 215) and (y < 220) and (h_player_loc = "00") and (player_loc = "0100")) or
	
	((x > 200) and (x < 207) and (y > 200) and (y < 205) and (h_player_loc = "01") and (player_loc = "0100")) or
	((x > 215) and (x < 222) and (y > 200) and (y < 205) and (h_player_loc = "01") and (player_loc = "0100")) or
	((x > 203) and (x < 226) and (y > 205) and (y < 215) and (h_player_loc = "01") and (player_loc = "0100")) or
	((x > 200) and (x < 207) and (y > 215) and (y < 220) and (h_player_loc = "01") and (player_loc = "0100")) or
	((x > 215) and (x < 222) and (y > 215) and (y < 220) and (h_player_loc = "01") and (player_loc = "0100")) or
	
	((x > 210) and (x < 217) and (y > 200) and (y < 205) and (h_player_loc = "10") and (player_loc = "0100")) or
	((x > 225) and (x < 232) and (y > 200) and (y < 205) and (h_player_loc = "10") and (player_loc = "0100")) or
	((x > 213) and (x < 236) and (y > 205) and (y < 215) and (h_player_loc = "10") and (player_loc = "0100")) or
	((x > 210) and (x < 217) and (y > 215) and (y < 220) and (h_player_loc = "10") and (player_loc = "0100")) or
	((x > 225) and (x < 232) and (y > 215) and (y < 220) and (h_player_loc = "10") and (player_loc = "0100")) or 
--END SECOND LANE
	((x > 190) and (x < 197) and (y > 300) and (y < 305) and (h_player_loc = "00") and (player_loc = "0010")) or
	((x > 205) and (x < 212) and (y > 300) and (y < 305) and (h_player_loc = "00") and (player_loc = "0010")) or
	((x > 193) and (x < 216) and (y > 305) and (y < 315) and (h_player_loc = "00") and (player_loc = "0010")) or
	((x > 190) and (x < 197) and (y > 315) and (y < 320) and (h_player_loc = "00") and (player_loc = "0010")) or
	((x > 205) and (x < 212) and (y > 315) and (y < 320) and (h_player_loc = "00") and (player_loc = "0010")) or
	
	((x > 200) and (x < 207) and (y > 300) and (y < 305) and (h_player_loc = "01") and (player_loc = "0010")) or
	((x > 215) and (x < 222) and (y > 300) and (y < 305) and (h_player_loc = "01") and (player_loc = "0010")) or
	((x > 203) and (x < 226) and (y > 305) and (y < 315) and (h_player_loc = "01") and (player_loc = "0010")) or
	((x > 200) and (x < 207) and (y > 315) and (y < 320) and (h_player_loc = "01") and (player_loc = "0010")) or
	((x > 215) and (x < 222) and (y > 315) and (y < 320) and (h_player_loc = "01") and (player_loc = "0010")) or
	
	((x > 210) and (x < 217) and (y > 300) and (y < 305) and (h_player_loc = "10") and (player_loc = "0010")) or
	((x > 225) and (x < 232) and (y > 300) and (y < 305) and (h_player_loc = "10") and (player_loc = "0010")) or
	((x > 213) and (x < 236) and (y > 305) and (y < 315) and (h_player_loc = "10") and (player_loc = "0010")) or
	((x > 210) and (x < 217) and (y > 315) and (y < 320) and (h_player_loc = "10") and (player_loc = "0010")) or
	((x > 225) and (x < 232) and (y > 315) and (y < 320) and (h_player_loc = "10") and (player_loc = "0010")) or
--END THIRD LANE
	((x > 190) and (x < 197) and (y > 400) and (y < 405) and (h_player_loc = "00") and (player_loc = "0001")) or
	((x > 205) and (x < 212) and (y > 400) and (y < 405) and (h_player_loc = "00") and (player_loc = "0001")) or
	((x > 193) and (x < 216) and (y > 405) and (y < 415) and (h_player_loc = "00") and (player_loc = "0001")) or
	((x > 190) and (x < 197) and (y > 415) and (y < 420) and (h_player_loc = "00") and (player_loc = "0001")) or
	((x > 205) and (x < 212) and (y > 415) and (y < 420) and (h_player_loc = "00") and (player_loc = "0001")) or
	
	((x > 200) and (x < 207) and (y > 400) and (y < 405) and (h_player_loc = "01") and (player_loc = "0001")) or
	((x > 215) and (x < 222) and (y > 400) and (y < 405) and (h_player_loc = "01") and (player_loc = "0001")) or
	((x > 203) and (x < 226) and (y > 405) and (y < 415) and (h_player_loc = "01") and (player_loc = "0001")) or
	((x > 200) and (x < 207) and (y > 415) and (y < 420) and (h_player_loc = "01") and (player_loc = "0001")) or
	((x > 215) and (x < 222) and (y > 415) and (y < 420) and (h_player_loc = "01") and (player_loc = "0001")) or
	
	((x > 210) and (x < 217) and (y > 400) and (y < 405) and (h_player_loc = "10") and (player_loc = "0001")) or
	((x > 225) and (x < 232) and (y > 400) and (y < 405) and (h_player_loc = "10") and (player_loc = "0001")) or
	((x > 213) and (x < 236) and (y > 405) and (y < 415) and (h_player_loc = "10") and (player_loc = "0001")) or
	((x > 210) and (x < 217) and (y > 415) and (y < 420) and (h_player_loc = "10") and (player_loc = "0001")) or
	((x > 225) and (x < 232) and (y > 415) and (y < 420) and (h_player_loc = "10") and (player_loc = "0001"))
--END FOURTH LANE
) else '0';
	
					
level_digit <= conv_integer(level);

score_integer <= conv_integer(score);
score_digit1 <= score_integer mod 10;
score_digit2 <= ((score_integer - score_digit1 )/10 ) mod 10;
score_digit3 <= ((score_integer  - score_digit1 - score_digit2*10 )/100) mod 10;

draw_level <= '1' when
	(
	  ((y<=350) and (y>=280) and ((x=80)  or (x=130))) or -- vertical bars
	  
	  (((y=280) or (y=350)) and (x>80)  and (x<130)) or -- horizonal bars
	  
	  ((y>300) and (y<305) and (x>100) and (x<110)	and 
	  (
	  (level_digit = 0)or
	  (level_digit = 2)or
	  (level_digit = 3)or
	  (level_digit = 5)or
	  (level_digit = 6)or
	  (level_digit = 7)or
	  (level_digit = 8)or
	  (level_digit = 9)
	  )) or
	  ((y>305) and (y<315) and (x>110) and (x <115)	and 
	  (
	  (level_digit = 0)or
	  (level_digit = 1)or
	  (level_digit = 2)or
	  (level_digit = 3)or
	  (level_digit = 4)or
	  (level_digit = 7)or
	  (level_digit = 8)or
	  (level_digit = 9)
	  ))or
	  ((y>305) and (y<315) and (x>95) and (x <100)	and 
	  (
	  (level_digit = 0)or
	  (level_digit = 4)or
	  (level_digit = 5)or
	  (level_digit = 6)or
	  (level_digit = 8)or
	  (level_digit = 9)
	  ))or
	  ((y>315) and (y<320) and (x>100) and (x <110)	and 
	  (
	  (level_digit = 2)or
	  (level_digit = 3)or
	  (level_digit = 4)or
	  (level_digit = 5)or
	  (level_digit = 6)or
	  (level_digit = 8)or
	  (level_digit = 9)
	  ))or
	  ((y>320) and (y<330) and (x>110) and (x <115)	and 
	  (
	  (level_digit = 0)or
	  (level_digit = 1)or
	  (level_digit = 3)or
	  (level_digit = 4)or
	  (level_digit = 5)or
	  (level_digit = 6)or
	  (level_digit = 7)or
	  (level_digit = 8)or
	  (level_digit = 9)
	  ))or
	  ((y>320) and (y<330) and (x>95) and (x <100)	and 
	  (
	  (level_digit = 0)or
	  (level_digit = 2)or
	  (level_digit = 6)or
	  (level_digit = 8)
	  ))or
	  ((y>330) and (y<335) and (x>100) and (x <110)	and 
	  (
	  (level_digit = 0)or
	  (level_digit = 2)or
	  (level_digit = 3)or
	  (level_digit = 5)or
	  (level_digit = 6)or
	  (level_digit = 8)or
	  (level_digit = 9)
	  ))
	  
	) else '0';

draw_line <= '1' when
 (
  ((y=60) and (x>180)  and (x < 530)) or --and (x mod 10 < 7)
  ((y=160) and (x>180) and (x mod 10 < 7) and (x < 530)) or
  ((y=260) and (x>180) and (x mod 10 < 7) and (x < 530)) or
  ((y=360) and (x>180) and (x mod 10 < 7) and (x < 530)) or
  ((y=460) and (x>180)  and (x < 530)) or --and (x mod 10 < 7)
  
  --((y<460) and (y>60) and ((x=180)  or (x = 530))) or-- vertical
  
  
  
  ((y<=150) and (y>=80) and ((x=50)  or (x = 160))) or-- vertical score
  
  (((y=80) or (y=150)) and (x>50)  and (x < 160)) or --horizon score 
  
  --score_digit1 
  ((y>100) and (y<105) and (x>130) and (x <140)	and 
  (
  (score_digit1 = 0)or
  (score_digit1 = 2)or
  (score_digit1 = 3)or
  (score_digit1 = 5)or
  (score_digit1 = 6)or
  (score_digit1 = 7)or
  (score_digit1 = 8)or
  (score_digit1 = 9)
  ))or
  ((y>105) and (y<115) and (x>140) and (x <145)	and 
  (
  (score_digit1 = 0)or
  (score_digit1 = 1)or
  (score_digit1 = 2)or
  (score_digit1 = 3)or
  (score_digit1 = 4)or
  (score_digit1 = 7)or
  (score_digit1 = 8)or
  (score_digit1 = 9)
  ))or
  ((y>105) and (y<115) and (x>125) and (x <130)	and 
  (
  (score_digit1 = 0)or
  (score_digit1 = 4)or
  (score_digit1 = 5)or
  (score_digit1 = 6)or
  (score_digit1 = 8)or
  (score_digit1 = 9)
  ))or
  ((y>115) and (y<120) and (x>130) and (x <140)	and 
  (
  (score_digit1 = 2)or
  (score_digit1 = 3)or
  (score_digit1 = 4)or
  (score_digit1 = 5)or
  (score_digit1 = 6)or
  (score_digit1 = 8)or
  (score_digit1 = 9)
  ))or
  ((y>120) and (y<130) and (x>140) and (x <145)	and 
  (
  (score_digit1 = 0)or
  (score_digit1 = 1)or
  (score_digit1 = 3)or
  (score_digit1 = 4)or
  (score_digit1 = 5)or
  (score_digit1 = 6)or
  (score_digit1 = 7)or
  (score_digit1 = 8)or
  (score_digit1 = 9)
  ))or
  ((y>120) and (y<130) and (x>125) and (x <130)	and 
  (
  (score_digit1 = 0)or
  (score_digit1 = 2)or
  (score_digit1 = 6)or
  (score_digit1 = 8)
  ))or
  ((y>130) and (y<135) and (x>130) and (x <140)	and 
  (
  (score_digit1 = 0)or
  (score_digit1 = 2)or
  (score_digit1 = 3)or
  (score_digit1 = 5)or
  (score_digit1 = 6)or
  (score_digit1 = 8)or
  (score_digit1 = 9)
  ))or
  
  --score_digit2
  ((y>100) and (y<105) and (x>100) and (x <110) and 
  (
  (score_digit2 = 0)or
  (score_digit2 = 2)or
  (score_digit2 = 3)or
  (score_digit2 = 5)or
  (score_digit2 = 6)or
  (score_digit2 = 7)or
  (score_digit2 = 8)or
  (score_digit2 = 9)
  ))or
  ((y>105) and (y<115) and (x>110) and (x <115) and 
  (
  (score_digit2 = 0)or
  (score_digit2 = 1)or
  (score_digit2 = 2)or
  (score_digit2 = 3)or
  (score_digit2 = 4)or
  (score_digit2 = 7)or
  (score_digit2 = 8)or
  (score_digit2 = 9)
  ))or
  ((y>105) and (y<115) and (x>95) and (x <100) and 
  (
  (score_digit2 = 0)or
  (score_digit2 = 4)or
  (score_digit2 = 5)or
  (score_digit2 = 6)or
  (score_digit2 = 8)or
  (score_digit2 = 9)
  ))or
  ((y>115) and (y<120) and (x>100) and (x <110) and 
  (
  (score_digit2 = 2)or
  (score_digit2 = 3)or
  (score_digit2 = 4)or
  (score_digit2 = 5)or
  (score_digit2 = 6)or
  (score_digit2 = 8)or
  (score_digit2 = 9)
  ))or
  ((y>120) and (y<130) and (x>110) and (x <115) 	and 
  (
  (score_digit2 = 0)or
  (score_digit2 = 1)or
  (score_digit2 = 3)or
  (score_digit2 = 4)or
  (score_digit2 = 5)or
  (score_digit2 = 6)or
  (score_digit2 = 7)or
  (score_digit2 = 8)or
  (score_digit2 = 9)
  ))or
  ((y>120) and (y<130) and (x>95) and (x <100) 	and 
  (
  (score_digit2 = 0)or
  (score_digit2 = 2)or
  (score_digit2 = 6)or
  (score_digit2 = 8)
  ))or
  ((y>130) and (y<135) and (x>100) and (x <110) 	and 
  (
  (score_digit2 = 0)or
  (score_digit2 = 2)or
  (score_digit2 = 3)or
  (score_digit2 = 5)or
  (score_digit2 = 6)or
  (score_digit2 = 8)or
  (score_digit2 = 9)
  ))or
  
  --score_digit3
 
  ((y>100) and (y<105) and (x>70) and (x <80) and 
  (
  (score_digit3 = 0)or
  (score_digit3 = 2)or
  (score_digit3 = 3)or
  (score_digit3 = 5)or
  (score_digit3 = 6)or
  (score_digit3 = 7)or
  (score_digit3 = 8)or
  (score_digit3 = 9)
  ))or
  ((y>105) and (y<115) and (x>80) and (x <85) and 
  (
  (score_digit3 = 0)or
  (score_digit3 = 1)or
  (score_digit3 = 2)or
  (score_digit3 = 3)or
  (score_digit3 = 4)or
  (score_digit3 = 7)or
  (score_digit3 = 8)or
  (score_digit3 = 9)
  ))or
  ((y>105) and (y<115) and (x>65) and (x <70) and 
  (
  (score_digit3 = 0)or
  (score_digit3 = 4)or
  (score_digit3 = 5)or
  (score_digit3 = 6)or
  (score_digit3 = 8)or
  (score_digit3 = 9)
  ))or
  ((y>115) and (y<120) and (x>70) and (x <80) and 
  (
  (score_digit3 = 2)or
  (score_digit3 = 3)or
  (score_digit3 = 4)or
  (score_digit3 = 5)or
  (score_digit3 = 6)or
  (score_digit3 = 8)or
  (score_digit3 = 9)
  ))or
  ((y>120) and (y<130) and (x>80) and (x <85) 	and 
  (
  (score_digit3 = 0)or
  (score_digit3 = 1)or
  (score_digit3 = 3)or
  (score_digit3 = 4)or
  (score_digit3 = 5)or
  (score_digit3 = 6)or
  (score_digit3 = 7)or
  (score_digit3 = 8)or
  (score_digit3 = 9)
  ))or
  ((y>120) and (y<130) and (x>65) and (x <70) 	and 
  (
  (score_digit3 = 0)or
  (score_digit3 = 2)or
  (score_digit3 = 6)or
  (score_digit3 = 8)
  ))or
  ((y>130) and (y<135) and (x>70) and (x <80) and 
  (
  (score_digit3 = 0)or
  (score_digit3 = 2)or
  (score_digit3 = 3)or
  (score_digit3 = 5)or
  (score_digit3 = 6)or
  (score_digit3 = 8)or
  (score_digit3 = 9)
  ))

 )else '0';
 
draw_life <= '1' when
 

 (
((y<=240) and (y>=190) and ((x=50)  or (x = 160))) or-- vertical score
  
  (((y=190) or (y=240)) and (x>50)  and (x < 160)) or --horizon score
  
 ((y>200) and (y<205) and (x>140) and (x <145)	and (top_lives_left="01")  )or
 ((y>225) and (y<230) and (x>140) and (x <145)	and (top_lives_left="01")  )or
 ((y>200) and (y<230) and (x>130) and (x <140)	and (top_lives_left="01")  )or
 ((y>200) and (y<205) and (x>125) and (x <130)	and (top_lives_left="01")  )or
 ((y>225) and (y<230) and (x>125) and (x <130)	and (top_lives_left="01")  )or

 ((y>200) and (y<205) and (x>140) and (x <145)	and (top_lives_left="10")  )or
 ((y>225) and (y<230) and (x>140) and (x <145)	and (top_lives_left="10")  )or
 ((y>200) and (y<230) and (x>130) and (x <140)	and (top_lives_left="10")  )or
 ((y>200) and (y<205) and (x>125) and (x <130)	and (top_lives_left="10")  )or
 ((y>225) and (y<230) and (x>125) and (x <130)	and (top_lives_left="10")  )or

 ((y>200) and (y<205) and (x>140) and (x <145)	and (top_lives_left="11")  )or
 ((y>225) and (y<230) and (x>140) and (x <145)	and (top_lives_left="11")  )or
 ((y>200) and (y<230) and (x>130) and (x <140)	and (top_lives_left="11")  )or
 ((y>200) and (y<205) and (x>125) and (x <130)	and (top_lives_left="11")  )or
 ((y>225) and (y<230) and (x>125) and (x <130)	and (top_lives_left="11")  )or



  ((y>200) and (y<205) and (x>110) and (x <115)	and (top_lives_left="10") 	)or
 ((y>225) and (y<230) and (x>110) and (x <115)	and (top_lives_left="10")  )or
 ((y>200) and (y<230) and (x>100) and (x <110)	and (top_lives_left="10")  )or
 ((y>200) and (y<205) and (x>95) and (x <100)	and (top_lives_left="10")  )or
 ((y>225) and (y<230) and (x>95) and (x <100)	and (top_lives_left="10")  )or

  
( (y>200) and (y<205) and (x>110) and (x <115)	and (top_lives_left="11") 	)or
 ((y>225) and (y<230) and (x>110) and (x <115)	and (top_lives_left="11")  )or
 ((y>200) and (y<230) and (x>100) and (x <110)	and (top_lives_left="11")  )or
 ((y>200) and (y<205) and (x>95) and (x <100)	and (top_lives_left="11")  )or
 ((y>225) and (y<230) and (x>95) and (x <100)	and (top_lives_left="11")  )or
  
( (y>200) and (y<205) and (x>80) and (x <85)	and (top_lives_left="11") 	)or
 ((y>225) and (y<230) and (x>80) and (x <85)	and (top_lives_left="11")  )or
 ((y>200) and (y<230) and (x>70) and (x <80)	and (top_lives_left="11")  )or
 ((y>200) and (y<205) and (x>65) and (x <70)	and (top_lives_left="11")  )or
 ((y>225) and (y<230) and (x>65) and (x <70)	and (top_lives_left="11")  )
 )else '0';

--mux

color_selector <= draw_obst & draw_plyr & dead & draw_line & draw_life & draw_level;
with color_selector select
   rgb <= "00000011" when "100000",
   "11111111" when "110000",
	
	"11111111" when "010000",
	
	--player should turn red when lose_state achieved.
	-- "11100000" when "10100",	-- cas normalement pas possible
	"11100000" when "111000",
	
	"11100000" when "011000",
	
	"11111111" when "000100",
	"11111111" when "001100",
	
	"00111011" when "000010",
	"00111011" when "001010",

	"11011001" when "000001",
	"11011001" when "001001",

	--the rest of the screen should be black.
	"00000000" when others;
			 
end Behavioral;