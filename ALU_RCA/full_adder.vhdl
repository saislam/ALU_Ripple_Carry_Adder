-- This will contain the code for a full adder

--Define Libraries and Includes
library ieee;
use ieee.std_logic_1164.all;

--Define Entity
entity full_adder is
	port(
		A  : in std_logic;
		B  : in std_logic;
		Cin : in std_logic;
		S  : out std_logic;
		Cout : out std_logic);
end full_adder;

--Entity Architecture
architecture BEHAVIORAL of full_adder is
	begin
		S  <= A xor B xor Cin;
		Cout <= ((A or B) and Cin) or (A and B);
end BEHAVIORAL;
