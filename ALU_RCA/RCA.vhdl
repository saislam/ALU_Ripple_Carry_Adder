library ieee;
use ieee.std_logic_1164.all;

entity RCA is
	port(
		A  		: in std_logic_vector(31 downto 0);
		B  		: in std_logic_vector(31 downto 0);
		Cin 		: in std_logic;
		Op		: in std_logic;
		S  		: out std_logic_vector(31 downto 0);
		Cout 		: out std_logic;
		V		: out std_logic);
end RCA;

architecture BEHAVIORAL of RCA is

	component full_adder
		port (
			A  : in std_logic;
			B  : in std_logic;
			Cin : in std_logic;
			S  : out std_logic;
			Cout : out std_logic);
	end component;
	
	signal carry 	: std_logic_vector (32 downto 0);
	signal sum	: std_logic_vector (31 downto 0);

	begin
		carry(0) <= Cin;

		rc0: for I in 0 to 31 generate
			full_add: full_adder port map (A(I), B(I), carry(I), sum(I), carry(I+1));		
		end generate;
		
		Cout <= carry(32);
		S <= sum;

		V <= carry(32) xor carry(31); --(Op and carry(32)) or (not Op and (A(31) xnor B(31)) and sum(31));

end BEHAVIORAL;
