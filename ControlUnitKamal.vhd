library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity ControlUnit is
port (
	opcode: in std_logic_vector (5 downto 0);
	Interrupt: in std_logic;
	Reset: in std_logic;
	ALUOp: out std_logic_vector (1 downto 0); --ALU MUX Selection
	ALUEnable: out std_logic;
	RegWrite: out std_logic;
	WBSignal: out std_logic_vector (2 downto 0);
	MR: out std_logic; --Memory Read
	MW: out std_logic; --Memory Write
	RdestSignal: out std_logic;
	JumpCall: out std_logic;
	Flush: out std_logic;
	ControlSelect: out std_logic; -- To choose whether to stall or to produce control signals
	SWE: out std_logic;
	PCSelect: out std_logic; --PC MUX Selection
	RA: out std_logic_vector(1 downto 0); --Read Address MUX Selection
	WA: out std_logic_vector(1 downto 0); --Write Address MUX Selection
	CCR2: out std_logic; --Carry Flag for SETC and CLRC
	CCRE: out std_logic;
	CCRE1: out std_logic;
	CCRE2: out std_logic
);
end entity ControlUnit;

architecture archControlUnit of ControlUnit is
begin
-- el SETC we CLRC by5lo kol el signals be 0 ma3ada ely mktob wla la2?
-- eh el conditions ely lazem a-check 3leha enha be zero zy el interrupt wel reset?
-- el ControlSelect law 3mlt 3leha check fe kolo enha be zero mesh h2dr m3a el NOP 3shan heya bt5leha be 1 we kolo sh3'al concurrent
--VERY IMPORTANT: lma condition fel CU yb2a mesh mktob 3ndo ALUOp bkam a5leha bkam aw aktb el condition ezay fel ALUOp?
ALUOp <= "10" when opcode="000000" and Interrupt='0' and Reset='0' else --ADD
	 "10" when opcode="000001" and Interrupt='0' and Reset='0' else --SUB
	 "10" when opcode="000010" and Interrupt='0' and Reset='0' else --AND
	 "10" when opcode="000011" and Interrupt='0' and Reset='0' else --OR
	 "10" when opcode="000100" and Interrupt='0' and Reset='0' else --RLC
	 "10" when opcode="000101" and Interrupt='0' and Reset='0' else --RRC
	 "10" when opcode="001000" and Interrupt='0' and Reset='0' else --NOT
	 "10" when opcode="001001" and Interrupt='0' and Reset='0' else --NEG
	 "10" when opcode="001010" and Interrupt='0' and Reset='0' else --SHR
	 "10" when opcode="001011" and Interrupt='0' and Reset='0' else --SHL
	 "10" when opcode="001100" and Interrupt='0' and Reset='0' else --INC
	 "10" when opcode="001101" and Interrupt='0' and Reset='0' else --DEC
	 "10" when opcode="001110" and Interrupt='0' and Reset='0' else --MOV
	 "01" when opcode="010001" and Interrupt='0' and Reset='0' else --POP
	 "00" when opcode="010000" and Interrupt='0' and Reset='0' else --PUSH
	 "00" when opcode="010010" and Interrupt='0' and Reset='0' else --OUT
	 "00" when opcode="010100" and Interrupt='0' and Reset='0' else --RET
	 "00" when opcode="010110" and Interrupt='0' and Reset='0' else --LDM
	 "00" when opcode="100000" and Interrupt='0' and Reset='0'; --NOP
	 
	 
ALUEnable <= '1' when opcode="000000" and Interrupt='0' and Reset='0' else --ADD
	     '1' when opcode="000001" and Interrupt='0' and Reset='0' else --SUB
	     '1' when opcode="000010" and Interrupt='0' and Reset='0' else --AND
	     '1' when opcode="000011" and Interrupt='0' and Reset='0' else --OR
	     '1' when opcode="000100" and Interrupt='0' and Reset='0' else --RLC
	     '1' when opcode="000101" and Interrupt='0' and Reset='0' else --RRC
	     '1' when opcode="001000" and Interrupt='0' and Reset='0' else --NOT
	     '1' when opcode="001001" and Interrupt='0' and Reset='0' else --NEG
	     '1' when opcode="001010" and Interrupt='0' and Reset='0' else --SHR
	     '1' when opcode="001011" and Interrupt='0' and Reset='0' else --SHL
	     '1' when opcode="001100" and Interrupt='0' and Reset='0' else --INC
	     '1' when opcode="001101" and Interrupt='0' and Reset='0' else --DEC
	     '1' when opcode="001110" and Interrupt='0' and Reset='0'; --MOV












end architecture archControlUnit;
