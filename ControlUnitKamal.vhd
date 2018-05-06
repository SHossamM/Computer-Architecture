library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity ControlUnit is
port (
	opcode: in std_logic_vector (5 downto 0);
	fn: in std_logic_vector(3 downto 0);
	Interrupt: in std_logic;
	Reset: in std_logic;
	FlushFromStaticPrediction: in std_logic;
	ALUEnable: out std_logic;
	RegWrite: out std_logic;
	wb_signal_select: out std_logic_vector (2 downto 0);
	MR: out std_logic; --Memory Read
	MW: out std_logic; --Memory Write
	RdestSignal: out std_logic;
	JumpCall: out std_logic;
	Flush: out std_logic;
	ControlSelect: out std_logic; -- To choose whether to stall or to produce control signals
	SWE: out std_logic;
	PC_Select: out std_logic_vector(1 downto 0); --PC MUX Selection
	Mem_Read_Address_Select: out std_logic_vector(2 downto 0); --Read Address MUX Selection
	Mem_Write_Address_Select: out std_logic_vector(1 downto 0); --Write Address MUX Selection
	WB_Dest_Select: out std_logic_vector(1 downto 0); --Write Data In Memory Select
	CCR_Select1: out std_logic; --ALU Flags OR Restoring from WB
	CCR_Select2: out std_logic_vector(1 downto 0); -- CLRC , SETC , ALU CF , Restore WB(0)
	CCR_Enable: out std_logic; --Enable the CCR Register
	control_a_select: out std_logic_vector(1 downto 0); --TO FORWARDING UNIT
	control_b_select: out std_logic_vector(1 downto 0);
	destination_select: out std_logic --SELECT REGISTER ADDRESS IN REGISTER FILE TO WRITE IN
);
end entity ControlUnit;

architecture archControlUnit of ControlUnit is
begin
	 
ALUEnable <= '1' when opcode="000000" and Interrupt='0' and Reset='0' else --ADD
	     '0';


RegWrite <=  '1' when opcode="000000" and Interrupt='0' and Reset='0' else --ADD
	     '1' when opcode="010001" and Interrupt='0' and Reset='0' else --POP
	     '1' when opcode="010011" and Interrupt='0' and Reset='0' else --IN
	     '1' when opcode="010110" and Interrupt='0' and Reset='0' else --LDM
	     '1' when opcode="010111" and Interrupt='0' and Reset='0' else --LDD
	     '0';


wb_signal_select <= "000" when opcode="010110" and Interrupt='0' and Reset='0' else --LDM  --Output 0 Immediate Value 
		    "001" when opcode="010111" and Interrupt='0' and Reset='0' else --LDD
		    "001" when opcode="010101" and Interrupt='0' and Reset='0' else --RTI  --Output 1 Memory 
		    "001" when opcode="010100" and Interrupt='0' and Reset='0' else --RET
		    "001" when opcode="010001" and Interrupt='0' and Reset='0' else --POP

		    "010" when opcode="000000" and Interrupt='0' and Reset='0' else --ADD  --Output 2 ALU Result

		    ---------------------- OUTPUT 3??????????????------------------

		    "100" when opcode="100100" and Interrupt='0' and Reset='0' else --JZ  --Output 4 Rd Value 
		    "100" when opcode="100010" and Interrupt='0' and Reset='0' else --JC
		    "100" when opcode="100101" and Interrupt='0' and Reset='0' else --JN
		    "100" when opcode="100010" and Interrupt='0' and Reset='0' else --JMP
		    "100" when opcode="100011" and Interrupt='0' and Reset='0' else --CALL

		    "101" when opcode="010011" and Interrupt='0' and Reset='0' else --IN  --Output 5 INPUT
		    "000";



MR <= '1' when opcode="010001" and Interrupt='0' and Reset='0' else --POP
      '1' when opcode="010100" and Interrupt='0' and Reset='0' else --RET
      '1' when opcode="010101" and Interrupt='0' and Reset='0' else --RTI
      '1' when opcode="010111" and Interrupt='0' and Reset='0' else --LDD
      '0';


MW <= '1' when opcode="011000" and Interrupt='0' and Reset='0' else --STD
      '1' when opcode="100011" and Interrupt='0' and Reset='0' else --CALL
      '1' when opcode="010000" and Interrupt='0' and Reset='0' else --PUSH
      '0';


RdestSignal <= '0' when FlushFromStaticPrediction='1' else
	       '1' when opcode="100010" and Interrupt='0' and Reset='0' else --JC
	       '1' when opcode="100100" and Interrupt='0' and Reset='0' else --JZ
	       '1' when opcode="100101" and Interrupt='0' and Reset='0' else --JN
	       '0';


JumpCall <= '1' when FlushFromStaticPrediction='1' else
	    '1' when opcode="100010" and Interrupt='0' and Reset='0' else --JMP
	    '1' when opcode="100011" and Interrupt='0' and Reset='0' else --CALL
            '0'; 


Flush <= '1' when opcode="100010" and Interrupt='0' and Reset='0' else --JMP
	 '1' when opcode="100011" and Interrupt='0' and Reset='0' else --CALL
	 '0'; 


--STALL 2 CYCLES????????????????????/
ControlSelect <= '1' when opcode="000000" and fn="1000" and Interrupt='0' and Reset='0' else  --SHL
		 '1' when opcode="000000" and fn="1001" and Interrupt='0' and Reset='0' else  --SHR
		 '1' when opcode="010111" and Interrupt='0' and Reset='0' else  --LDD
		 '1' when opcode="010110" and Interrupt='0' and Reset='0' else  --LDM
		 '1' when opcode="011000" and Interrupt='0' and Reset='0' else  --STD
		 '0';

--SP WRITE ENABLE
--SWE <= 

--hna fe confusion bnsba ll jmps n5tar a 22 wla 40 ka slka 22 wb value 40 mux el jmp call
PC_Select <= "00" when opcode="100100" and Interrupt='0' and Reset='0' else  --JZ
	     "00" when opcode="100010" and Interrupt='0' and Reset='0' else  --JC
	     "00" when opcode="100101" and Interrupt='0' and Reset='0' else  --JN
	     "00" when opcode="100010" and Interrupt='0' and Reset='0' else  --JMP
	     "00" when opcode="100011" and Interrupt='0' and Reset='0' else  --CALL
	     "00" when opcode="010100" and Interrupt='0' and Reset='0' else  --RET
	     "00" when opcode="010101" and Interrupt='0' and Reset='0' else  --RTI

	     --"01" ????????

	     "10" when Reset='1' else
	     "11" when Interrupt='1' else
	     "01"; --EL MAFROD TB2A PC +1 ( TO BE HANDLED)


--OSMAN ??????????????????????????????? check el lo7a
Mem_Read_Address_Select <= --Stack Pointer to be handled after change(tl3nah bara) ++SP
				"001" when opcode="010111" and Interrupt='0' and Reset='0' else --LDD
				"010" when opcode="010111" and Interrupt='0' and Reset='0' else --SP????????????????????????????
				"011" when Interrupt='1' else --Interrupt
           			"100" when Reset='1' else --Reset
				"000";

-- CHECK AHMED ISMAIL fel CALL
Mem_Write_Address_Select <= "00" when opcode="010000" and Interrupt='0' and Reset='0' else -- (SP--) WHEN PUSH
			    "01" when opcode="011000" and Interrupt='0' and Reset='0' else --STD
			    "01" when opcode="100011" and Interrupt='0' and Reset='0' else --CALL
			    "00";


WB_Dest_Select <= "00" when opcode="100011" and Interrupt='0' and Reset='0' else --CALL
		  "01" when opcode="011000" and Interrupt='0' and Reset='0' else --STD
		  "10" when Interrupt='1' else --Interrupt
		  "00";


CCR_Select1 <= '0' when opcode="000000" and Interrupt='0' and Reset='0' else --R TYPE
	       '1' when opcode="010101" and Interrupt='0' and Reset='0' else --RTI Flags Restored (Takes WB Result)
	       '0';

CCR_Select2 <= "00" when opcode="110001" and Interrupt='0' and Reset='0' else --CLRC
	       "01" when opcode="110000" and Interrupt='0' and Reset='0' else --SETC
	       "10" when opcode="000000" and Interrupt='0' and Reset='0' else --R TYPE
	       "11" when opcode="010101" and Interrupt='0' and Reset='0' else --RTI Flags Restored (Takes WB Result)
	       "00";

CCR_Enable <=  '1' when opcode="110001" and Interrupt='0' and Reset='0' else --CLRC
	       '1' when opcode="110000" and Interrupt='0' and Reset='0' else --SETC
	       '1' when opcode="000000" and Interrupt='0' and Reset='0' else --R TYPE
	       '1' when opcode="010101" and Interrupt='0' and Reset='0' else --RTI Flags Restored (Takes WB Result)
	       '0';


control_a_select <= "00" when opcode="000000" and Interrupt='0' and Reset='0' else --R TYPE
		    "00";

control_b_select <= "11" when opcode="000000" and fn="1000" and Interrupt='0' and Reset='0' else --SHL
		    "11" when opcode="000000" and fn="1001" and Interrupt='0' and Reset='0' else --SHR
		    "00" when opcode="000000" and Interrupt='0' and Reset='0' else --R TYPE
		    "00";
		    
--TO BE CONTINUED
destination_select <= '1' when opcode="000000" and Interrupt='0' and Reset='0' else --R TYPE
		      '0';


end architecture archControlUnit;
