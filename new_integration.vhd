Library ieee;
Use ieee.std_logic_1164.all;
Entity first_Integrate is
  port(--inputs
        port1_selec,port2_selec,mem_wb_Rs,mem_wb_Rd, Mem_Read_Address_Select : in std_logic_vector(2 downto 0);
        alu_op_select,CCR_Select2,A_Select,B_Select, WB_Dest_Select, Mem_Write_Address_Select : in Std_logic_vector(1 downto 0);
        CCR_Select1,W_Enable,clk,Reset,Aenable,DEnable,Read_Enable,destination_select, MR,MW : in std_logic ;
        W_Value,WB_Result,Imediate_Value,MEM_WB_ALUResult, SP, PC : in std_logic_vector(15 downto 0);
        aluOperation:in std_logic_vector(3 downto 0);
         --outputs
        
        ccr:out std_logic_vector(3 downto 0)
    
       );
  
  
end  first_Integrate;


architecture  first_Integrate_arch of  first_Integrate is
  
  -----components
  ----Mux4x1
  component Mux4x1 is 
generic(n:integer:=16);
  port(a,b,c,d:in std_logic_vector(n-1 downto 0);
       selectin:in std_logic_vector(1 downto 0);
       dataout:out std_logic_vector(n-1 downto 0)
     );
     
end component;

  ----Mux8x1
  component Mux8x1 is 
generic(n:integer:=16);
  port(
       a,b,c,d,e,f,g,h:in std_logic_vector(n-1 downto 0);
       selectin:in std_logic_vector(2 downto 0);
       dataout:out std_logic_vector(n-1 downto 0)
     );
     
end component;

--MUX4x1_1bit
component Mux4x1_1bit is 
  port(a,b,c,d:in std_logic;
       selectin:in std_logic_vector(1 downto 0);
       dataout:out std_logic
     );
     
end component;


  ----MUX2X1
component Mux2x1 is 
generic(n:integer:=16);
  port(a,b:in std_logic_vector(n-1 downto 0);
       selectin:in std_logic;
       dataout:out std_logic_vector(n-1 downto 0)
       );
     
end component;
  
  --register file
component Registerfile is
port(
port1_selec,port2_selec,W_selector : in std_logic_vector(2 downto 0);
W_Enable,clk,Reset,Enable,Read_Enable : in std_logic ;
W_Value : in std_logic_vector(15 downto 0);
Port1data,Port2data : out std_logic_vector(15 downto 0));
end component;


---alu
component ALU is
  port(aluOperation:in std_logic_vector(3 downto 0);
       a,b: in std_logic_vector(15 downto 0);
       cin,enable: in std_logic;
       result: out  std_logic_vector(15 downto 0);
       carryFlag,ZeroFlag,overflowFlag,negativeFlag: out std_logic
     );
end component;
---Register
component Registern is
Generic ( n : integer := 8);
port( Clk,Rst : in std_logic;
d : in std_logic_vector(n-1 downto 0);
q : out std_logic_vector(n-1 downto 0);
enable : in std_logic );
end component;
--1 bit Register Component
Component Reg is
	port( 
		clk,rst, d: in std_logic;
       		q:out std_logic;
		enable : in std_logic
	);
end component;

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

signal   Port1data,Port2data, Port1dataout,Port2dataout ,Alu_input1,ALU_input2: std_logic_vector(15 downto 0);
signal   ccr_regin,selectedfunction:std_logic_vector(3 downto 0);
signal   ccr_mux1_in : std_logic_vector(2 downto 0);
signal  carryFlag,ZeroFlag,overflowFlag,negativeFlag: std_logic;
signal  W_selector:std_logic_vector(2 downto 0);

--Decode outputs
signal Imediate_Decode_out, Decode_SP_Out, Decode_PC_Out: std_logic_vector(15 downto 0);
signal ccr_regout: std_logic_vector(3 downto 0);
signal Decode_MR_out, Decode_MW_out: std_logic;
signal Decode_WB_Dest_Select_out, Decode_Mem_Write_Address_Select_out: std_logic_vector(1 downto 0);
signal Decode_Mem_Read_Address_Select_out	: std_logic_vector(2 downto 0);



--Exe outputs
signal EX_MEM_ALUResult, Imediate_Exe_out, result, Execute_SP_Out, Execute_PC_Out, exe_Rs_out, exe_Rd_out: std_logic_vector(15 downto 0);
signal Execute_CCR_Select1_out: std_logic;
signal Execute_CCR_Select2_out: std_logic_vector(1 downto 0);
signal exe_ccr_regout: std_logic_vector(3 downto 0);
signal exe_MR_out, exe_MW_out: std_logic;
signal exe_WB_Dest_Select_out, exe_Mem_Write_Address_Select_out: std_logic_vector(1 downto 0);
signal exe_Mem_Read_Address_Select_out	: std_logic_vector(2 downto 0);


--Memory outputs
signal mem_Read_Address, mem_Write_Address, Mem_CCR_Extend: std_logic_vector(15 downto 0);

begin



--Mux select between mem_wb_Rs& mem_wb_Rd  between r-type  and load use Rs instead of Rd
  mux0:Mux2x1 generic map(n=>3) port map(mem_wb_Rs,mem_wb_Rd,destination_select ,W_selector);
  
  
  --Decode stage
  decode0: Registerfile port map(port1_selec,port2_selec,W_selector,
                                  W_Enable,clk,Reset,dEnable,Read_Enable, 
                                   W_Value , Port1data,Port2data);
  
  --Decode Buffer                                
  Decode_Imm_Buffer: registern generic map(n=>16)  port map(clk,reset, Imediate_Value,Imediate_Decode_out,'1');                                 
  Decode_Rs_Buffer: registern generic map(n=>16)  port map(clk,reset, Port1data,Port1dataout,'1');
  Decode_Rd_Buffer: registern generic map(n=>16)  port map(clk,reset,Port2data,Port2dataout,'1');
  Decode_SP_Buffer: registern generic map(n=>16)  port map(clk,reset,SP,Decode_SP_Out,'1');  
  Decode_PC_Buffer: registern generic map(n=>16)  port map(clk,reset,PC,Decode_PC_Out,'1');  
  Decode_WB_Dest_Select_Buffer: registern generic map(n=>2)  port map(clk,reset,WB_Dest_Select,Decode_WB_Dest_Select_out,'1');
  Decode_MW_Buffer: reg port map(clk,reset,MW,Decode_MW_out,'1');
  Decode_MR_Buffer: reg  port map(clk,reset,MR,Decode_MR_out,'1');
  Decode_Mem_Read_Address_Select_Buffer: registern generic map(n=>3)  port map(clk,reset,Mem_Read_Address_Select,Decode_Mem_Read_Address_Select_out,'1');
  Decode_Mem_Write_Address_Select_Buffer: registern generic map(n=>2)  port map(clk,reset,Mem_Write_Address_Select,Decode_Mem_Write_Address_Select_out,'1');
    
  ----------------------------------------------------------------------------------

  ccr_mux1_in<=ZeroFlag&negativeFlag&overflowFlag;
--Mux to select the inputs to the CCR 
  mux_ccrSelect1:Mux2x1 generic map(n=>3) port map(ccr_mux1_in,WB_Result(3 downto 1),CCR_SELECT1,ccr_regin(2 downto 0));
  mux_ccrSelect2:Mux4x1_1bit  port map('0','1',carryFlag,WB_Result(0),CCR_Select2,ccr_regin(3));
  
  --ccr register
  
  ccr0:registern generic map(n=>4)  port map(clk,reset,ccr_regin,ccr_regout,'1');
  
  ccr<=ccr_regout;
  
   ----------------------------------------------------------------------------------
  
  
    
  
  
  
  
  
  
  ----------------------------------------------------------------------------------
  --ALU stage
  Mux_ASelect:Mux4x1  port map(Port1dataout,EX_MEM_ALUResult,MEM_WB_ALUResult,"0000000000000000",A_SELECT,Alu_input1);
  Mux_BSelect:Mux4x1  port map(Port2dataout,EX_MEM_ALUResult,MEM_WB_ALUResult,Imediate_Decode_out,B_SELECT,Alu_input2);
  Mux_ALU_Operations:Mux4x1 generic map (n=>4)  port map("1101","1101",aluOperation,aluOperation,AlU_OP_select,selectedfunction);  
  alu0:ALU port map(selectedfunction,Alu_input1,Alu_input2,ccr_regout(0),aenable,result,
                         carryFlag,ZeroFlag,overflowFlag,negativeFlag);
  
  --ALU Bffers
  EXE_RESULT_Buffer: registern generic map(n=>16)  port map(clk,reset, result,EX_MEM_ALUResult,'1');
  EXE_Imm_Buffer: registern generic map(n=>16)  port map(clk,reset, Imediate_Decode_out,Imediate_Exe_out,'1');
  EXE_SP_Buffer: registern generic map(n=>16)  port map(clk,reset,Decode_SP_Out,Execute_SP_Out,'1'); 
  EXE_PC_Buffer: registern generic map(n=>16)  port map(clk,reset,Decode_PC_Out,Execute_PC_Out,'1'); 
  EXE_CCRs1_Buffer: Reg port map(clk,reset,CCR_Select1,Execute_CCR_Select1_out,'1');
  EXE_CCRs2_Buffer: registern generic map(n=>2)  port map(clk,reset,CCR_Select2,Execute_CCR_Select2_out,'1');
  EXE_CCR_Buffer: registern generic map(n=>4)  port map(clk,reset,ccr_regout,exe_ccr_regout,'1');
  
  Execute_WB_Dest_Select_Buffer: registern generic map(n=>2)  port map(clk,reset,Decode_WB_Dest_Select_out,exe_WB_Dest_Select_out,'1');
  Execute_MW_Buffer: reg port map(clk,reset,Decode_MW_out,exe_MW_out,'1');
  Execute_MR_Buffer: reg  port map(clk,reset,Decode_MR_out,exe_MR_out,'1');
  Execute_Mem_Read_Address_Select_Buffer: registern generic map(n=>3)  port map(clk,reset,Decode_Mem_Read_Address_Select_out,exe_Mem_Read_Address_Select_out,'1');
  Execute_Mem_Write_Address_Select_Buffer: registern generic map(n=>2)  port map(clk,reset,Decode_Mem_Write_Address_Select_out,exe_Mem_Write_Address_Select_out,'1');
  Execute_Rs_Buffer: registern generic map(n=>16)  port map(clk,reset, Port1dataout,exe_Rs_out,'1');
  Execute_Rd_Buffer: registern generic map(n=>16)  port map(clk,reset,Port2dataout,exe_Rd_out,'1');
    
  ----------------------------------------------------------------------------------
  --Memory stage
  Mux_Read_Address: Mux8x1 port map(EX_MEM_ALUResult, Imediate_Exe_out, Execute_SP_Out, "0000000000000001", "0000000000000000", 
                                    "0000000000000000", "0000000000000000", "0000000000000000", exe_Mem_Read_Address_Select_out, mem_Read_Address);  
  Mux_Write_Address: Mux4x1 port map(EX_MEM_ALUResult, Imediate_Exe_out, Execute_SP_Out, "0000000000000000", exe_Mem_Write_Address_Select_out, mem_Write_Address);
 
  Mem_CCR_Extend <= ("000000000000" & exe_ccr_regout);
  Mux_Write_Data: Mux4x1 port map(Execute_PC_Out,exe_Rs_out, Mem_CCR_Extend, "0000000000000000", exe_WB_Dest_Select_out, mem_Write_Address);
  
  --memoryunit: PMemoryUnit port map (clk,exe_MR_out,exe_MW_out,mem_Write_Address,mem_Read_Address,WriteData,sigMemReadData);
  
end  first_Integrate_arch;






