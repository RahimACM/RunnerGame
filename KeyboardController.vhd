----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:41:29 05/05/2018 
-- Design Name: 
-- Module Name:    KeyboardController - Behavioral 
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

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity KeyboardController is
    Port ( PS2KeyboardClock : in  STD_LOGIC;
           PS2KeyboardData : in  STD_LOGIC;
			  RightArrow : out STD_LOGIC;
			  UpArrow : out STD_LOGIC;
			  LeftArrow : out STD_LOGIC;
			  DownArrow : out STD_LOGIC
	);
end KeyboardController;

architecture Behavioral of KeyboardController is

signal bitCount 		: integer range 0 to 100 := 0;
signal scancodeReady : STD_LOGIC := '0';
signal scancode 		: STD_LOGIC_VECTOR(7 downto 0);
signal breakReceived : STD_LOGIC := '0';

constant keyboardLeftArrow  : STD_LOGIC_VECTOR(7 downto 0) := "01101011";
constant keyboardDownArrow  : STD_LOGIC_VECTOR(7 downto 0) := "01110010";
constant keyboardRightArrow : STD_LOGIC_VECTOR(7 downto 0) := "01110100";
constant keyboardUpArrow 	 : STD_LOGIC_VECTOR(7 downto 0) := "01110101";

begin

	keksfabrik : process(PS2KeyboardClock)
	begin
		if falling_edge(PS2KeyboardClock) then
			if bitCount = 0 and PS2KeyboardData = '0' then --keyboard wants to send data
				scancodeReady <= '0';
				bitCount <= bitCount + 1;
			elsif bitCount > 0 and bitCount < 9 then -- shift one bit into the scancode from the left
				scancode <= PS2KeyboardData & scancode(7 downto 1);
				bitCount <= bitCount + 1;
			elsif bitCount = 9 then -- parity bit
				bitCount <= bitCount + 1;
			elsif bitCount = 10 then -- end of message
				scancodeReady <= '1';
				bitCount <= 0;
			end if;
		end if;
	end process keksfabrik;
	
	kruemelfabrik : process(scancodeReady, scancode)
	begin
		if scancodeReady'event and scancodeReady = '1' then
			-- breakcode breaks the current scancode
			if breakReceived = '1' then 
				breakReceived <= '0';
				if scancode = keyboardLeftArrow then
					LeftArrow <= '0';
				elsif scancode = keyboardRightArrow then
					RightArrow <= '0';
				elsif scancode = keyboardUpArrow then
					UpArrow <= '0';
				elsif scancode = keyboardDownArrow then
					DownArrow <= '0';
				end if;
			elsif breakReceived = '0' then
				-- scancode processing
				if scancode = "11110000" then -- mark break for next scancode
					breakReceived <= '1';
				end if;
				
				if scancode = keyboardLeftArrow then
					LeftArrow <= '1';
				elsif scancode = keyboardDownArrow then
					DownArrow <= '1';
				elsif scancode = keyboardRightArrow then
					RightArrow <= '1';
 				elsif scancode = keyboardUpArrow then
					UpArrow <= '1';
				end if;
			end if;
		end if;
	end process kruemelfabrik;
end Behavioral;