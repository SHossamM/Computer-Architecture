library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity PWriteBack is
port (
	clk: in std_logic;
	WBSignal: in std_logic_vector(2 downto 0); --WB Signal Selection
	Imm: in std_logic_vector(15 downto 0); --Immediate Value (000)
	Mem: in std_logic_vector(15 downto 0); --Memory Value (001)
 	ALUResult: in std_logic_vector(15 downto 0); --ALU Result Value (010)
	RSValue: in std_logic_vector(15 downto 0); --Rsource Value (011)
	Input: in std_logic_vector(15 downto 0); --INPUT Value (100)
	RDValue: in std_logic_vector(15 downto 0); --Rdest Value (101)

	WB: out std_logic_vector(15 downto 0) --Write Back Unit Output
);
end entity PWriteBack;

Architecture arch_PWriteBack of PWriteBack is
begin
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(WBSignal = "000") then
				WB <= Imm;
			elsif (WBSignal = "001") then
				WB <= Mem;
			elsif (WBSignal = "010") then
				WB <= ALUResult;
			elsif (WBSignal = "011") then
				WB <= RSValue;
			elsif (WBSignal = "100") then
				WB <= Input;
			elsif (WBSignal = "101") then
				WB <= RDValue;
			end if;      
		end if;
	end process;
end arch_PWriteBack;
