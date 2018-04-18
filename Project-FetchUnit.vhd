
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PFetchUnit is
port( 
	clk : in std_logic;
	PC:   in std_logic_vector(15 downto 0);
	
	Inst: out std_logic_vector(15 downto 0)
);
end entity PFetchUnit;

architecture archPFetchUnit of PFetchUnit is
Component PMemory is
	generic(n:integer:=10; m:integer:=16);
	port( 
		clk : in std_logic;
		we : in std_logic;
		address : in std_logic_vector(n-1 downto 0);
		datain : in std_logic_vector(m-1 downto 0);
		dataout : out std_logic_vector(m-1 downto 0)
	);
end component;
begin
	mem : PMemory generic map ( n => 10, m => 16) port map (clk, '0', PC(9 downto 0), "0000000000000000", Inst); --Data in is a dont care. useless
	
end architecture;

