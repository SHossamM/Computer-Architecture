Library ieee;
Use ieee.std_logic_1164.all;
Entity Dcode_ALU_Integrate is
  port(--inputs
        port1_selec,port2_selec,mem_wb_Rs,mem_wb_Rd : in std_logic_vector(2 downto 0);
        alu_op_select,CCR_Select2,A_Select,B_Select : in Std_logic_vector(1 downto 0);
        CCR_Select1,W_Enable,clk,Reset,Aenable,DEnable,Read_Enable,destination_select : in std_logic ;
        W_Value,WB_Result,Imediate_Value,MEM_WB_ALUResult,sp : in std_logic_vector(15 downto 0);
        aluOperation:in std_logic_vector(3 downto 0);
         --outputs
        result: out  std_logic_vector(15 downto 0);
        ccr:out std_logic_vector(3 downto 0)
    
       );
  
  
end  Dcode_ALU_Integrate;


architecture  Dcode_ALU_Integrate_arc of  Dcode_ALU_Integrate is
  
   ----------------------------------------------------------------------------------  
  -----components
  ----Mux4x1
  component Mux4x1 is 
generic(n:integer:=16);
  port(a,b,c,d:in std_logic_vector(n-1 downto 0);
       selectin:in std_logic_vector(1 downto 0);
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
--1 bit Register Component
Component Reg is
	port( 
		clk,rst, d: in std_logic;
       		q:out std_logic;
		enable : in std_logic
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

   ----------------------------------------------------------------------------------
  ---Decode stage signals
  signal dec_spout:std_logic_vector(15 downto 0);
  
  
  --Exceute stage signals
 signal ex_Imediate_Valueout,exec_spout: std_logic_vector(15 downto 0);
 
 signal exec_CCR_Select2out: std_logic_vector(1 downto 0);
 signal exec_CCR_Select1out:std_logic;
 
 
signal   Port1data,Port2data, Port1dataout,Port2dataout ,Alu_input1,ALU_input2,EX_MEM_ALUResult,EX_MEM_ALUResultout,Imediate_Valueout
          : std_logic_vector(15 downto 0);
signal   ccr_regin,ccr_regout,selectedfunction:std_logic_vector(3 downto 0);
signal   ccr_mux1_in : std_logic_vector(2 downto 0);
signal  carryFlag,ZeroFlag,overflowFlag,negativeFlag: std_logic;
signal  W_selector:std_logic_vector(2 downto 0);

begin



--Mux select between mem_wb_Rs& mem_wb_Rd  between r-type  and load use Rs instead of Rd
  mux0:Mux2x1 generic map(n=>3) port map(mem_wb_Rs,mem_wb_Rd,destination_select ,W_selector);
  
  
  --Decode stage
  decode0: Registerfile port map(port1_selec,port2_selec,W_selector,
                                  W_Enable,clk,Reset,dEnable,Read_Enable, 
                                   W_Value , Port1data,Port2data);
   ----------------------------------------------------------------------------------                                   
                                   
      --Pipeline registers(id_exec buffer)                 
  Rs_buff: registern generic map(n=>16)  port map(clk,reset, Port1data,Port1dataout,'1');
  Rd_buff: registern generic map(n=>16)  port map(clk,reset,Port2data,Port2dataout,'1');
  imm_buff: registern generic map(n=>16)  port map(clk,reset,Imediate_Value,Imediate_Valueout,'1');
  dec_sp_buff:registern generic map(n=>16)  port map(clk,reset,sp,dec_spout,'1');
  ----------------------------------------------------------------------------------

  ccr_mux1_in<=ZeroFlag&negativeFlag&overflowFlag;
--Mux to select the inputs to the CCR 
  mux1:Mux2x1 generic map(n=>3) port map(ccr_mux1_in,WB_Result(2 downto 1),CCR_SELECT1,ccr_regin(2 downto 0));
  mux2:Mux4x1_1bit  port map('0','1',carryFlag,WB_Result(0),CCR_Select2,ccr_regin(3));
  
  --ccr register
  
  ccr0:registern generic map(n=>4)  port map(clk,reset,ccr_regin,ccr_regout,'1');
  
  ccr<=ccr_regout;
  
   ----------------------------------------------------------------------------------
  

  
 
    
  
  
  
  
  
  
  ----------------------------------------------------------------------------------
  --ALU stage
  mux3:Mux4x1  port map(Port1dataout,EX_MEM_ALUResult,MEM_WB_ALUResult,"0000000000000000",A_SELECT,Alu_input1);
  mux4:Mux4x1  port map(Port2dataout,EX_MEM_ALUResultout,MEM_WB_ALUResult,Imediate_Valueout,B_SELECT,Alu_input2);
  mux5:Mux4x1  port map("1100","1101",aluOperation,aluOperation,AlU_OP_select,selectedfunction);  
  alu0:ALU port map(selectedfunction,Alu_input1,Alu_input2,ccr_regout(0),aenable,result,
                         carryFlag,ZeroFlag,overflowFlag,negativeFlag);
   
  ----------------------------------------------------------------------------------
  ---exec_mem buffers
 aluresult_buff: registern generic map(n=>16)  port map(clk,reset,EX_MEM_ALUResult,EX_MEM_ALUResultout,'1'); 
 ex_imm_buff: registern generic map(n=>16)  port map(clk,reset,Imediate_Valueout,ex_Imediate_Valueout,'1');
 exec_sp_buff:registern generic map(n=>16)  port map(clk,reset,dec_spout,exec_spout,'1');
 exec_ccrs2_buff:registern generic map(n=>2)  port map(clk,reset,CCR_Select2,exec_CCR_Select2out,'1');
 exec_ccrs1_buff:reg port map(clk,reset,CCR_Select1,exec_CCR_Select1out,'1');
  
  
  
end  Dcode_ALU_Integrate_arc;





