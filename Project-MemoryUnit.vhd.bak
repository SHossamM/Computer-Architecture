

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PMemoryUnit is
port( 
	clk : in std_logic;
	MR: in std_logic;
	MW: in std_logic;
	WriteAddress: in std_logic_vector(9 downto 0);
	ReadAddress: in std_logic_vector(9 downto 0);
	WriteData: in std_logic_vector(15 downto 0); 

	ReadData: out std_logic_vector(15 downto 0)
);
end entity PMemoryUnit;

architecture archPMemoryUnit of PMemoryUnit is
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
signal signalMemoryAddress: std_logic_vector(9 downto 0);
signal signalDataOut: std_logic_vector(15 downto 0);
begin
	mem : PMemory generic map ( n => 10, m => 16) port map (clk, MW, signalMemoryAddress, WriteData, signalDataOut);
	
	ReadData <=  signalDataOut when (MR = '1' AND MW= '0') else
		     WriteData when (MR='1' AND MW= '1');	--Incase '1 1' assume that it writes then reads at same time
	
	signalMemoryAddress <= 	WriteAddress when (MR='0' AND MW='0') else	--Dont Care. Any Value
				WriteAddress when (MR='0' AND MW='1') else
				ReadAddress when (MR='1' AND MW='0') else
				WriteAddress;	--If Mr=1  MW=1

	
	
end architecture;

