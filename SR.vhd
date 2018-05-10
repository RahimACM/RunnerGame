----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:15:10 11/23/2014 
-- Design Name: 
-- Module Name:    SR - Behavioral 
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

entity SR is
    Port ( game_clock : in STD_LOGIC;
					enable : in STD_LOGIC;
	           obst_in : in STD_LOGIC;
				     dead : in STD_LOGIC;
			       reset : in STD_LOGIC;
             lane_out : out  STD_LOGIC_VECTOR (31 downto 0));
end SR;

architecture Behavioral of SR is
   signal s_D : std_logic_vector (31 downto 0) := "00000000000000000000000000000000";
begin
   shift : process (game_clock, OBST_IN, dead, reset)
	begin
	   if ((reset = '1') or (dead = '1')) then
		   s_D <= "00000000000000000000000000000000";
	   elsif (rising_edge(game_clock) and (enable = '1')) then
		   s_D <= OBST_IN & s_D (31 downto 1);
		end if;
	end process shift;
	
	lane_out <= s_D;


end Behavioral;