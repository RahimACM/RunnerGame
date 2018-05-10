----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:44:28 11/21/2014 
-- Design Name: 
-- Module Name:    LFSR - Behavioral 
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

entity LFSR is
   port ( game_clock : in std_logic;
				  enable : in STD_LOGIC;
	             dead : in std_logic;
	            reset : in std_logic;
			   obst_out : out std_logic);
end LFSR;


--Output 5 bits: lfsr_out, inputs: clock and reset

architecture Behavioral of LFSR is
   signal lfsr : std_logic_vector (31 downto 0) := "00000000000000000000000000000100";
	signal lfsr_next : std_logic_vector (31 downto 0) := "00000000000000000000000000000100";
begin

   lfsr_seq : process(game_clock, reset)
	begin
	   if (dead = '1') then
		   lfsr <= "00000000000000000000000000000000";
	   elsif (reset = '1') then
		   lfsr <= "00000000000000000000000000000100";
	   else   
			if (rising_edge(game_clock) and (enable = '1')) then
			   lfsr <= lfsr_next;
		   end if;
		end if;
	end process lfsr_seq;
	
	lfsr_comb : process(lfsr)
	begin
	   lfsr_next (31 downto 1) <= lfsr (30 downto 0);
		lfsr_next (0) <= lfsr(31) xor lfsr(5);
	end process lfsr_comb;
	
	obst_out <= lfsr(0);


end Behavioral;