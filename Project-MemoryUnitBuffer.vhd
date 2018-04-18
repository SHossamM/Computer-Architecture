library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PMemoryUnitBuffer is
port( 
	clk : in std_logic;


	OPcode : in std_logic_vector(5 downto 0);
	PC     : in std_logic_vector(15 downto 0);
	Rs     : in std_logic_vector(15 downto 0);	-- ???? Address? Bits.. ?
	Rd     : in std_logic_vector(15 downto 0);	-- ???? Address? Bits.. ?
	Imm    : in std_logic_vector(15 downto 0);
	Mem    : in std_logic_vector(15 downto 0);
	ALUresult : in std_logic_vector(15 downto 0);
	RsValue: in std_logic_vector(15 downto 0);
	RdValue: in std_logic_vector(15 downto 0);
	MR     : in std_logic;
	MW     : in std_logic;
	RA     : in std_logic_vector(9 downto 0);
	WA     : in std_logic_vector(9 downto 0);
	WDS     : in std_logic_vector(15 downto 0);	-- ????? Bits.. ???
	DestSelect : in std_logic;			-- ????? Bits.. ???
	WBSignal:in std_logic;				-- Bits ?
	SP     : in std_logic_vector(15 downto 0);
							-- RA and WA repeated ?!!
	CCRE   : in std_logic_vector(3 downto 0);	-- ????? Bits.. ???
	RegWrite : in std_logic_vector(9 downto 0);	-- ????? Bits.. ????
	Input  : in std_logic_vector(15 downto 0);


	outOPcode : out std_logic_vector(5 downto 0);
	outPC     : out std_logic_vector(15 downto 0);
	outRs     : out std_logic_vector(15 downto 0);	-- ???? Address? Bits.. ?
	outRd     : out std_logic_vector(15 downto 0);	-- ???? Address? Bits.. ?
	outImm    : out std_logic_vector(15 downto 0);
	outMem    : out std_logic_vector(15 downto 0);
	outALUresult : out std_logic_vector(15 downto 0);
	outRsValue: out std_logic_vector(15 downto 0);
	outRdValue: out std_logic_vector(15 downto 0);
	outMR     : out std_logic;
	outMW     : out std_logic;
	outRA     : out std_logic_vector(9 downto 0);
	outWA     : out std_logic_vector(9 downto 0);
	outWDS       : out std_logic_vector(15 downto 0);	-- ????? Bits.. ???
	outDestSelect : out std_logic;			-- ????? Bits.. ???
	outWBSignal:out std_logic;				-- Bits ?
	outSP     : out std_logic_vector(15 downto 0);
							-- RA and WA repeated ?!!
	outCCRE   : out std_logic_vector(3 downto 0);	-- ????? Bits.. ???
	outRegWrite : out std_logic_vector(9 downto 0);	-- ????? Bits.. ????
	outInput  : out std_logic_vector(15 downto 0)
	
);
end entity PMemoryUnitBuffer;

architecture archPMemoryUnitBuffer of PMemoryUnitBuffer is
begin
	process(clk) is	
	begin
		if rising_edge(clk) then
			outOPcode <= OPcode; 
			outPC  <= PC;
			outRs  <= RS;
			outRd  <= Rd;
			outImm <= Imm;
			outMem <= Mem;
			outALUresult <= ALUresult;
			outRsValue <= RsValue;
			outRdValue <= RdValue;
			outMR  <= MR; 
			outMR  <= MW; 
			outRA  <= RA;
			outWA  <= WA;
			outWDS <= WDS;
			outDestSelect <= DestSelect;
			outWBSignal <= WBSignal;
			outSP  <= SP;  

		end if;
	end process;
end architecture;
