library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PMemWB is
port( 
	--Memory Unit inputs
	clk : in std_logic;
	MR: in std_logic;
	MW: in std_logic;
	WriteAddress: in std_logic_vector(9 downto 0);
	ReadAddress: in std_logic_vector(9 downto 0);
	WriteData: in std_logic_vector(15 downto 0);

	--BUFFER INPUTS
	enable : in std_logic;
	OPcode : in std_logic_vector(5 downto 0);
	PC     : in std_logic_vector(15 downto 0);
	Rs     : in std_logic_vector(2 downto 0);	-- ???? Address? Bits.. ?
	Rd     : in std_logic_vector(2 downto 0);	-- ???? Address? Bits.. ?
	--MR     : in std_logic;
	--MW     : in std_logic;
	--RA     : in std_logic_vector(9 downto 0);
	--WA     : in std_logic_vector(9 downto 0);
	WDS     : in std_logic_vector(1 downto 0);	-- ????? Bits.. ???
	DestSelect : in std_logic;			-- ????? Bits.. ???
	WBSignal:in std_logic_vector(2 downto 0);				
	SP     : in std_logic_vector(15 downto 0);					
	CCR_Enable   : in std_logic;	-- ????? Bits.. ???
	RegWrite : in std_logic;	-- ????? Bits.. ????
	rst: in std_logic;
	Imm: in std_logic_vector(15 downto 0); --Immediate Value (000)
	ALUResult: in std_logic_vector(15 downto 0); --ALU Result Value (010)
	RSValue: in std_logic_vector(15 downto 0); --Rsource Value (011)
	Input: in std_logic_vector(15 downto 0); --INPUT Value (100)
	RDValue: in std_logic_vector(15 downto 0); --Rdest Value (101)
	
	--Other inputs for WB
	--WBSignal: in std_logic_vector(2 downto 0);

	--WB Output
	WB: out std_logic_vector(15 downto 0)
);
end entity PMemWB;

architecture archPMemWB of PMemWB is
--Memory Unit Component
Component PMemoryUnit is
	port( 
		clk : in std_logic;
		MR: in std_logic;
		MW: in std_logic;
		WriteAddress: in std_logic_vector(9 downto 0);
		ReadAddress: in std_logic_vector(9 downto 0);
		WriteData: in std_logic_vector(15 downto 0); 

		ReadData: out std_logic_vector(15 downto 0)
	);
end component;
--Writeback Unit Component
Component PWriteBack is
	port( 
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
end component;
--Register Component
Component Registern is
	Generic ( n : integer := 8);
	port( 
		Clk,Rst : in std_logic;
		d : in std_logic_vector(n-1 downto 0);
		q : out std_logic_vector(n-1 downto 0);
		enable : in std_logic
	);
end component;
--1 bit Register Component
Component Reg is
	port( 
		clk,rst, d: in std_logic;
       		q:out std_logic;
		enable : in std_logic
	);
end component;

--Outputs of memory
signal sigMemReadData: std_logic_vector(15 downto 0);

--Outputs of Buffer
signal BufferMR, BufferMW, BufferDestSelect, BufferCCR_Enable, BufferRegWrite: std_logic;
signal BufferWDS: std_logic_vector(1 downto 0);
signal BufferRs, BufferRd, BufferWBSignal: std_logic_vector(2 downto 0);
signal BufferOPcode: std_logic_vector(5 downto 0);
signal BufferReadAddress, BufferWriteAddress: std_logic_vector(9 downto 0);
signal BufferPC, BufferSP, BufferImm, BufferALUResult, BufferRSValue, BufferInput, BufferRDValue, BufferMem: std_logic_vector(15 downto 0);

--Outputs of Writeback
signal signalWB: std_logic_vector(15 downto 0);

begin
	memoryunit: PMemoryUnit port map (clk,MR,MW,WriteAddress,ReadAddress,WriteData,sigMemReadData);

	--Buffer
	regOPCode: Registern generic map(n=> 6) port map(clk,rst,OPcode,BufferOPcode,enable);
	regPC: Registern generic map(n=> 16) port map(clk,rst,PC,BufferPC,enable);
	regRs: Registern generic map(n=> 3) port map(clk,rst,Rs,BufferRs,enable);
	regRd: Registern generic map(n=> 3) port map(clk,rst,Rd,BufferRd,enable);
	regMR: Reg port map(clk,rst,MR,BufferMR,enable);
	regMW: Reg port map(clk,rst,MW,BufferMW,enable);
	regRA: Registern generic map(n=> 10) port map(clk,rst,ReadAddress,BufferReadAddress,enable);
	regWA: Registern generic map(n=> 10) port map(clk,rst,WriteAddress,BufferWriteAddress,enable);
	regWDS: Registern generic map(n=> 2) port map(clk,rst,WDS,BufferWDS,enable);
	regDestSelect: Reg port map(clk,rst,DestSelect,BufferDestSelect,enable);
	regWBSignal: Registern generic map(n=> 3) port map(clk,rst,WBSignal,BufferWBSignal,enable);
	regSP: Registern generic map(n=> 16) port map(clk,rst,SP,BufferSP,enable);
	regCCR_Enable: Reg port map(clk,rst,CCR_Enable,BufferCCR_Enable,enable);
	regRegWrite: Reg port map(clk,rst,RegWrite,BufferRegWrite,enable);
	regImm: Registern generic map(n=> 16) port map(clk,rst,Imm,BufferImm,enable);
	regALUResult: Registern generic map(n=> 16) port map(clk,rst,ALUResult,BufferALUResult,enable);
	regRSValue: Registern generic map(n=> 16) port map(clk,rst,RSValue,BufferRSValue,enable);
	regInput: Registern generic map(n=> 16) port map(clk,rst,Input,BufferInput,enable);
	regRDValue: Registern generic map(n=> 16) port map(clk,rst,RDValue,BufferRDValue,enable);
	regMem: Registern generic map(n=> 16) port map(clk,rst,sigMemReadData,BufferMem,enable);

	writeback: PWriteBack port map (clk,BufferWBSignal,BufferImm,BufferMem,BufferALUResult,BufferRSValue,BufferInput,BufferRDValue,signalWB);
	
	WB <= signalWB;
end architecture;
