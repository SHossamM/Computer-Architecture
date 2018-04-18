
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PMFetchUnitBuffer is
port( 
	clk : in std_logic;

	PC     : in std_logic_vector(15 downto 0);
	OPcode : in std_logic_vector(5 downto 0);
	Func   : in std_logic_vector(3 downto 0);
	Rs     : in std_logic_vector(2 downto 0);
	Rd     : in std_logic_vector(2 downto 0);
	Flush  : in std_logic;
	Input  : in std_logic_vector(15 downto 0);

	outPC     : out std_logic_vector(15 downto 0);
	outOPcode : out std_logic_vector(5 downto 0);
	outFunc   : out std_logic_vector(3 downto 0);
	outRs     : out std_logic_vector(2 downto 0);
	outRd     : out std_logic_vector(2 downto 0);
	outFlush  : out std_logic;
	outInput  : out std_logic_vector(15 downto 0)
);
end entity PMFetchUnitBuffer;

architecture archPMFetchUnitBuffer of PMFetchUnitBuffer is
begin
	process(clk) is	
	begin
		if rising_edge(clk) then
			outPC <= PC;
			outOPcode <= OPcode;
			outFunc <= Func;
			outRs <= Rs;
			outRd <= Rd;
			outFlush <= Flush;
			outInput <= Input;
		end if;
	end process;
end architecture;