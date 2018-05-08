----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:16:44 11/22/2014 
-- Design Name: 
-- Module Name:    runner_toplevel_wiring - Behavioral 
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
--
--
--
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

entity game_logic is
   port ( Clk          : in std_logic;
	       --Only one bit of player_input should be high at any time, and "000" means no input detected.
			 --"100 will be "Up", "010" will be "Down", and "001" will be "Reset".
			 player_input : in std_logic_vector (2 downto 0);
			 -- '1' when paused, '0' when played
			 paused 		  : in std_logic;
			 player_loc   : out std_logic_vector (3 downto 0);
			 --External signals for locations of obstacles that will be drawn by another module.
			 obst_locs_1  : out std_logic_vector (31 downto 0);
			 obst_locs_2  : out std_logic_vector (31 downto 0);
			 obst_locs_3  : out std_logic_vector (31 downto 0);
			 obst_locs_4  : out std_logic_vector (31 downto 0);
			       score  : out std_logic_vector (7 downto 0);
		  top_lives_left : out std_logic_vector (1 downto 0);
		  top_level_dead : out std_logic);
	       
end game_logic;

architecture Behavioral of game_logic is

------Constants------

--This constant represents the frequency of the input clock signal. In this case, it's the "actual" value of the
--pixel clock, approximately 25.174 MHz. This constant is used in a process below to create an enable
--signal to update game logic with the desired frequency (currently 8Hz).
constant clock_freq : integer := 25184000;

--This constant represents our desired frequency of game logic updates.
constant game_freq : integer := 8;

------This section lists the components we need in our circuit to run the game logic.

--There will be four SR (shift register) components to handle the four lanes of obstacles.
component SR
   port ( game_clock : in std_logic;
  				  enable : in STD_LOGIC;
	          obst_in : in std_logic;
				    dead : in std_logic;
				   reset : in std_logic;
		      lane_out : out std_logic_vector (31 downto 0));
end component;

--This LFSR (linear feedback shift register) works to handle the pseudo-random number generation
--to generate obstacles in the game. obst_out from this LFSR goes to the pick_a_lane module,
--which then decides which of the four lanes the new obstacle will go to.
component LFSR
   port (game_clock : in std_logic;
				 enable : in STD_LOGIC;
	            dead : in std_logic;
	           reset : in std_logic;
	        obst_out : out std_logic);
end component;

component pick_a_lane
   port (game_clock : in  STD_LOGIC;
				 enable : in STD_LOGIC;
	         obst_in : in  STD_LOGIC;
     obst_to_lane_1 : out  STD_LOGIC;
     obst_to_lane_2 : out  STD_LOGIC;
     obst_to_lane_3 : out  STD_LOGIC;
     obst_to_lane_4 : out  STD_LOGIC);
end component;
 
------Intermediate Signals------
--This signal is effectively our "game clock", as it will only be active 8 times per second (see game_freq_gen process below).
signal enable_game_update : std_logic := '0';

--This signal becomes high when the player reaches zero lives remaining. It's then sent to the other components to tell them to
--stop generating new obstacles.
signal lose_state : std_logic := '0';

--Running record of where the player currently is. Should be thought of as existing
--in the "game_memory" from the box diagram. (Right?)
--MSB high means player is in top lane (Lane 1), and LSB being high means player is in bottom lane (Lane 4).
--Clearly, only one bit in this 4-bit bus should be high at any time.
signal current_player_location : std_logic_vector (3 downto 0) := "0100";

--lane1 is the topmost lane, and lane4 is the bottom lane.
--Each lane is modeled as a shift register that has an obstacle generated at the MSB,
--which then propagates down the lane (right-to-left) until it reaches the player zone
--at the LSB of the register.
--These lanes equate to the "obst_locations" in the box diagram.
signal lane1, lane2, lane3, lane4 :  std_logic_vector (31 downto 0);

--Internal signal to "keep track(?)" of what sequence the LFSR is currently holding.
--Used by the four lane SRs to determine when a new obstacle must be generated.
signal current_obst : std_logic;

signal current_obst_to_L1,
       current_obst_to_L2,
		 current_obst_to_L3,
		 current_obst_to_L4 : std_logic;

--Keeps track of how many "hits" the player can take before Game Over.
--Game begins with 3 "total" lives (i.e., 3 total hits before game ends).
--Therefore:      "11" means 3 hits remaining,    "10" means 2 hits remaining,    "01" means 1 hit remaining,    "00" means Game Over   
signal lives_left : std_logic_vector (1 downto 0) := "11";

--This clock signal is intended specifically for the "game logic" of our circuit.
--It will be much slower than any other clock signal (perhaps 15-16 Hz?) because
--it determines how frequently the objects on the screen are updated, and how
--quickly the obstacles move across the screen.
--signal game_clock : std_logic;

--This signal will be linked to all components of the game logic, and when it's activated, should
--effectively reset all elements of the game (full lives, 0 score, no obstacles, etc.)
signal global_reset : std_logic;


signal current_score : std_logic_vector (7 downto 0) := "00000000";
begin

global_reset <= player_input(0);



--Here we instantiate the four SRs for the four lanes.
--The obstacles coming in to each lane are decided by the pick_a_lane module.
lane1_sr : SR
   port map ( game_clock => enable_game_update,
						enable => not paused,
	              obst_in => current_obst_to_L1,
					     dead => lose_state,
			          reset => global_reset,
					 lane_out => lane1);

lane2_sr : SR
   port map ( game_clock => enable_game_update,
						enable => not paused,
	              obst_in => current_obst_to_L2,
					     dead => lose_state,
				       reset => global_reset,
					 lane_out => lane2);
					 
lane3_sr : SR
   port map ( game_clock => enable_game_update,
						enable => not paused,
	              obst_in => current_obst_to_L3,
					     dead => lose_state,
				       reset => global_reset,
					 lane_out => lane3);
					 
lane4_sr : SR
   port map ( game_clock => enable_game_update,
						enable => not paused,
	              obst_in => current_obst_to_L4,
					     dead => lose_state,
				       reset => global_reset,
					 lane_out => lane4);
					 
--Here, the outputs of the four SRs are tied to the outputs of this game_mechanics module (they'll be sent to graphics module).
obst_locs_1 <= lane1;
obst_locs_2 <= lane2;
obst_locs_3 <= lane3;
obst_locs_4 <= lane4;

				
--Here we instantiate one LFSR that will be used to generate
--new obstacles in the four lanes in a pseudo-random fashion.				
obst_generator : LFSR
   port map ( game_clock => enable_game_update,
						enable => not paused,
	                 dead => lose_state,
	                reset => global_reset,
					 obst_out => current_obst);
					 
lane_selector : pick_a_lane
   port map ( game_clock => enable_game_update,
						enable => not paused,
	              obst_in => current_obst,
          obst_to_lane_1 => current_obst_to_L1,
          obst_to_lane_2 => current_obst_to_L2,
          obst_to_lane_3 => current_obst_to_L3,
          obst_to_lane_4 => current_obst_to_L4);
	           
--This process essentially generates our desired "game clock" with a frequency of 8Hz.
--The signal enable_game_update will only be high 8 times per second...	           
   game_freq_gen : process(Clk)
	   variable count : integer := 0;
	begin
	   if (rising_edge(Clk)) then
		   enable_game_update <= '0';
			count := (count + 1);
			--...due to this if statement.
	      if (count = (clock_freq / game_freq)) then
			   enable_game_update <= '1';
				count := 0;
			end if;
		end if;
	end process game_freq_gen;

   --This process is responsible for moving the player up and down within their zone (between the four possible locations).
   --It should run whenever a change in player input is detected, because that's when the user wants to move their character.
   player_movement : process(enable_game_update, player_input)
   begin
	   if (rising_edge(enable_game_update) and (paused = '0')) then
	      --This first if statement lists the actions that should take place when the player is in Lane 1. They can only move down.
         if ((current_player_location = "1000") and (player_input = "010")) then
		      current_player_location <= "0100"; --moves player down to Lane 2.
	   	--This elsif statement lists the movements that should take place when the player is in Lane 2.
	   	elsif (current_player_location = "0100") then
		      if (player_input = "100") then
			      current_player_location <= "1000"; --moves player up to Lane 1.
		   	elsif (player_input = "010") then
			      current_player_location <= "0010"; --moves player down to Lane 3.
			   end if;
	      --This elsif statement lists the movements that should take place when the player is in Lane 3.
	   	elsif (current_player_location = "0010") then
		      if (player_input = "100") then
			      current_player_location <= "0100"; --moves player up to Lane 2.
			   elsif (player_input = "010") then
			      current_player_location <= "0001"; --moves player down to Lane 4.
			   end if;
		   --This else statement lists the movements that should take place when the player is in Lane 4. They can only move up.
		   elsif ((current_player_location = "0001") and (player_input = "100")) then
		      current_player_location <= "0010"; --moves player up to Lane 3.
		   end if;
	   	player_loc <= current_player_location;
		end if;
	end process player_movement;
	
   --This process	is responsible for checking to see if the player runs into an obstacle when the obstacle enters the "player zone".
	hit_detection : process(enable_game_update)
	begin
	   if (rising_edge(enable_game_update)) then
	      if (global_reset = '1') then
		      lives_left <= "11";
	      elsif ((current_player_location = "1000" and (lane1(0) = '1')) or
		       (current_player_location = "0100" and (lane2(0) = '1')) or
			    (current_player_location = "0010" and (lane3(0) = '1')) or
			    (current_player_location = "0001" and (lane4(0) = '1'))) then
		      lives_left <= (lives_left - 1);
		   end if;
	   end if;
	end process hit_detection;

  --The player's score should be 0 whenever the game starts or is reset,
  --and with the current system, the player receives 1 point per second.
   scoring_system : process(enable_game_update)
	variable count : integer := 0;
	begin
	   if (global_reset = '1') then
			current_score <= "00000000";
		else
			if (rising_edge(enable_game_update) and (paused = '0')) then
				--This if statement makes sure that the players score only goes up while they
				--still have lives remaining. Their score should stop increasing while in the
				--dead/lose state.
				if (lives_left /= "00") then
					count := count + 1;
					if (count = 8) then
						current_score <= current_score + 1;
						count := 0;
					end if;
				end if;
			end if;
		end if;
	end process scoring_system;
	
	
	score <= current_score;

   --When the player has 0 lives remaining, the game transitions to the lose state,
	--where the obstacles disappear, the LFSR stops generating new obstacles, the score
	--stops increasing, and the player's white box turns red.
   check_for_game_over : process (enable_game_update)
	begin
	   if (rising_edge(enable_game_update)) then
	      if (global_reset = '1') then
			   lose_state <= '0';
			elsif (lives_left = "00") then
			   lose_state <= '1';
         end if;
		end if;
	end process check_for_game_over;

top_lives_left <= lives_left;
top_level_dead <= lose_state;

end Behavioral;