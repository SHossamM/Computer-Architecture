
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PMemory is
generic(n:integer:=10; m:integer:=16);
port(
	clk : in std_logic;
	we : in std_logic;
	address : in std_logic_vector(n-1 downto 0);
	datain : in std_logic_vector(m-1 downto 0);
	dataout : out std_logic_vector(m-1 downto 0) );
end entity PMemory;

architecture archPMemory of PMemory is
type ram_type is array (0 to 2**n-1) of std_logic_vector(m-1 downto 0);   --Power is **	--2D array
signal ram : ram_type;
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
end architecture; 


