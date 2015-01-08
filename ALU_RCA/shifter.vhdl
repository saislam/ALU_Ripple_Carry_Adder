library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shifter is
	port( 	A	: in std_logic_vector(31 downto 0);
		B	: in std_logic_vector(4 downto 0);
		Op	: in std_logic_vector(1 downto 0);
		Outs	: out std_logic_vector(31 downto 0));
end shifter;

architecture behavioral of shifter is
begin

  Outs <= std_logic_vector(shift_left(signed(A), to_integer(unsigned(B)))) 	when Op="00" else
	  std_logic_vector(shift_right(unsigned(A), to_integer(unsigned(B)))) 	when Op="10" else
	  std_logic_vector(shift_right(signed(A), to_integer(unsigned(B)))) 	when Op="11" else
	  (others => '0');
end behavioral;
