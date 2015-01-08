library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity logic_unit is
	port (
		A	: in std_logic_vector(31 downto 0);
		B	: in std_logic_vector(31 downto 0);
		Op	: in std_logic_vector(1 downto 0);
		Outs	: out std_logic_vector(31 downto 0));
end logic_unit;

architecture behavioral of logic_unit is
begin
	process(A, B, Op)
	begin
		case Op is
			when "00" => Outs <= A and B;
			when "01" => Outs <= A or B;
			when "10" => Outs <= A nor B;
			when "11" => Outs <= A xor B;
			when others => Outs <= std_logic_vector(to_unsigned(0, 32));
		end case;
	end process;
end behavioral;
