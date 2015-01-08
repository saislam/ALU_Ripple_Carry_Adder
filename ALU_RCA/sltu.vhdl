library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sltu is
	port (	V	: in std_logic;
		Cout	: in std_logic;
		Sign	: in std_logic;
		Op	: in std_logic;
		Outs	: out std_logic_vector(31 downto 0));
end sltu;

architecture behavioral of sltu is

signal unsigned_slt	: std_logic;
signal signed_slt	: std_logic;
signal out_sig		: std_logic;

begin
	unsigned_slt 	<= Op and not Cout;
	signed_slt	<= not Op and (V xor Sign);
	out_sig <= unsigned_slt or signed_slt;
	Outs <= (0 => out_sig, others =>'0');
end behavioral;

