library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tower is 
	port(
		update : in std_logic;
		gamestate : in std_logic;
		towerxpos : out unsigned(9 downto 0);
		towerypos : out unsigned(9 downto 0)
	);
end entity;

architecture synth of tower is 

signal xpos : unsigned (9 downto 0);
signal counter : unsigned(9 downto 0) := "1010010011";
type state is (ALIVE, DEAD);
signal s : state := DEAD;

begin
	towerxpos <= xpos;
	towerypos <= 50 + (counter mod 280);
	
	
	process(update) is begin
		
		if rising_edge(update) then
		
			case s is 
				when DEAD =>
					if gamestate = '0' then
						s <= ALIVE;
					else 
						s <= DEAD;
					end if;
				when ALIVE =>
					if gamestate = '1' then
						s <= DEAD;
					else 
						s <= ALIVE;
					end if;
				when others => s <= DEAD;
			end case;
			
			xpos <= 10d"690" when (s = DEAD or xpos = 0) else xpos - 4;
			
			if (xpos = 10d"690") then
				-- add a "random" big number and mod it to simulate randomness
				counter <= counter + 2435;
			end if;
		end if;
	end process;
end architecture;