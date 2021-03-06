--This is the testbench for the Ripple Carry ALU

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity ALU_TB is
end ALU_TB;

architecture behavioral of ALU_TB is
	component ALU_RCA is
	  port(
		Clk	: in std_logic;
		Reset	: in std_logic;
		A	: in std_logic_vector(31 downto 0);
		B	: in std_logic_vector(31 downto 0);
		Op	: in std_logic_vector(3 downto 0);
		Outs	: out std_logic_vector(31 downto 0));
	end component ALU_RCA;


		-----------------------------------------------------------------------------
  -- Declarations
  -----------------------------------------------------------------------------

  constant Size    : integer := 1100;   --adjust to test vector count
  type Operand_array is array (Size downto 0) of std_logic_vector(31 downto 0);
  type OpCode_array is array (Size downto 0) of std_logic_vector(3 downto 0);

	signal Clk_tb, Reset_tb	: std_logic := '0';
	signal verify		: std_logic := '1';
	signal A_tb, B_tb	: std_logic_vector(31 downto 0);
	signal Op_tb		: std_logic_vector(3 downto 0);
	signal Outs_tb		: std_logic_vector(31 downto 0);
	signal ExpectOutSig	: std_logic_vector(31 downto 0);

	signal AMem		: Operand_array := (others => (others => '0'));
	signal BMem		: Operand_array := (others => (others => '0'));
	signal OpMem		: OpCode_array := (others => (others => '0'));
	signal ExpectOutMem	: Operand_array := (others => (others => '0'));
	signal I		: integer := 0;



  -----------------------------------------------------------------------------
  -- Functions
  -----------------------------------------------------------------------------

  function bin (
    myChar : character)
    return std_logic is
    variable bin : std_logic;
  begin
    case myChar is
      when '0' => bin := '0';
      when '1' => bin := '1';
      when 'x' => bin := '0';
      when others => assert (false) report "no binary character read" severity failure;
    end case;
    return bin;
  end bin;

  function loadOperand (
    fileName : string)
    return Operand_array is
    file objectFile : text open read_mode is fileName;
    variable memory : Operand_array;
    variable L      : line;
    variable index  : natural := 0;
    variable myChar : character;
  begin
    while not endfile(objectFile) loop
      readline(objectFile, L);
      for i in 31 downto 0 loop
        read(L, myChar);
        memory(index)(i) := bin(myChar);
      end loop;
      index := index + 1;
    end loop;
    return memory;
  end loadOperand;


  function loadOpCode (
    fileName : string)
    return OpCode_array is
    file objectFile : text open read_mode is fileName;
    variable memory : OpCode_array;
    variable L      : line;
    variable index  : natural := 0;
    variable myChar : character;
  begin
    while not endfile(objectFile) loop
      readline(objectFile, L);
      for i in 3 downto 0 loop
        read(L, myChar);
        memory(index)(i) := bin(myChar);
      end loop;
      index := index + 1;
    end loop;
    return memory;
  end loadOpCode;

	begin
		--Clk_tb <= '0';
		Reset_tb <= '1';
		process(Clk_tb)
		begin
		  Clk_tb <= not Clk_tb after 1050 ps;
		end process;

		alu0: ALU_RCA port map (Clk_tb, Reset_tb, A_tb, B_tb, Op_tb, Outs_tb);

		AMem <= loadOperand(string'("A.tv"));
		BMem <= loadOperand(string'("B.tv"));
		OpMem <= loadOpCode(string'("Op.tv"));
		ExpectOutMem <= loadOperand(string'("ExpectOut.tv"));
		
		process(Clk_tb)
		begin
		  if rising_edge(Clk_tb) then 
		    A_tb <= AMem(I);
		    B_tb <= BMem(I);
		    Op_tb <= OpMem(I);
		    ExpectOutSig <= ExpectOutMem(I);
		    I <= I+1;
		    
		   
		   if I > 2 then
		      assert Outs_tb=ExpectOutMem(I-3)
		      report "Failure!" severity warning;


		      if Outs_tb = ExpectOutMem(I-3) then
			verify <= '1';
		      else
			verify <= '0';
		      end if;
		    end if;

		   
		   if I = 1000 then
                      assert false report "tb finished" severity failure;
                   end if;
		  end if;
		end process;
end behavioral;
