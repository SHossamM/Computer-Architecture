
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Memory is
generic(n:integer:=10; m:integer:=16);
port(
	clk : in std_logic;
	we : in std_logic;
	address : in std_logic_vector(9 downto 0);
	datain : in std_logic_vector(15 downto 0);
	dataout : out std_logic_vector(15 downto 0);
	Mem0,Mem1:out std_logic_vector(15 downto 0)
	 );
end entity Memory;

architecture archMemory of Memory is
type ram_type is array (0 to 1023) of std_logic_vector(15 downto 0);  
signal ram : ram_type;
signal m0,m1:std_logic_vector(9 downto 0);
begin
	process(clk) is
	begin
		if rising_edge(clk) then
			if we = '1' then
				ram(to_integer(unsigned(address))) <= datain;
			end if;
		end if;
end process;
	dataout <= ram(to_integer(unsigned(address))) when address(0) = '0' OR address(0) = '1' else
		   (others=>'0');	--FOR FIRST TIME ONLY !!
		   m0<="0000000000";
		   m1<="0000000001";
		   Mem0<=ram(to_integer(unsigned(m0)));
		   Mem1<=ram(to_integer(unsigned(m1)));
end architecture; 



