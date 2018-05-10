----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:31:30 12/03/2014 
-- Design Name: 
-- Module Name:    pick_a_lane - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pick_a_lane is
    Port (     game_clock : in  STD_LOGIC;
						 enable : in STD_LOGIC;
	               obst_in : in  STD_LOGIC;
           obst_to_lane_1 : out  STD_LOGIC;
           obst_to_lane_2 : out  STD_LOGIC;
           obst_to_lane_3 : out  STD_LOGIC;
           obst_to_lane_4 : out  STD_LOGIC);
end pick_a_lane;

architecture Behavioral of pick_a_lane is
   signal lfsr : std_logic_vector (15 downto 0) := "0001000010000001";
	signal lfsr_next : std_logic_vector (15 downto 0) := "0001000010000001";
begin

   lfsr_seq : process(game_clock)
	begin  
		if (rising_edge(game_clock) and (enable = '1')) then
			lfsr <= lfsr_next;
		end if;
	--this if statement chooses one of the lanes to get the obstacle based on the decimal value of lfsr
	   if (obst_in = '1') then
		   if ((conv_integer(lfsr)) > 49152) then
		      obst_to_lane_1 <= '1';
			   obst_to_lane_2 <= '0';
		   	obst_to_lane_3 <= '0';
			   obst_to_lane_4 <= '0';
		   elsif (((conv_integer(lfsr)) > 32768) and((conv_integer(lfsr)) < 49152)) then
		      obst_to_lane_1 <= '0';
		   	obst_to_lane_2 <= '1';
		   	obst_to_lane_3 <= '0';
		   	obst_to_lane_4 <= '0';
		   elsif (((conv_integer(lfsr)) > 16384) and((conv_integer(lfsr)) < 32768)) then
		      obst_to_lane_1 <= '0';
	   		obst_to_lane_2 <= '0';
	   		obst_to_lane_3 <= '1';
	   		obst_to_lane_4 <= '0';
	   	elsif ((conv_integer(lfsr)) < 16384) then
	   	   obst_to_lane_1 <= '0';
	   		obst_to_lane_2 <= '0';
	   		obst_to_lane_3 <= '0';
	   		obst_to_lane_4 <= '1';
	   	else
	   	   obst_to_lane_1 <= '0';
	   		obst_to_lane_2 <= '0';
	   		obst_to_lane_3 <= '0';
	   		obst_to_lane_4 <= '0';
	   	end if;
		--if obst_in from the obst_generator LFSR is not 1, then no obstacles are generated
		else
		   obst_to_lane_1 <= '0';
	      obst_to_lane_2 <= '0';
	   	obst_to_lane_3 <= '0';
	   	obst_to_lane_4 <= '0';
	   end if;
	end process lfsr_seq;
	
	lfsr_comb : process(lfsr)
	begin
	   lfsr_next (15 downto 1) <= lfsr (14 downto 0);
		lfsr_next (0) <= lfsr(15) xor lfsr(5);
	end process lfsr_comb;

end Behavioral;