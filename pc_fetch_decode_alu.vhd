Library ieee;
Use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
Entity pc_fetch_decode_alu is
  port(clk ,reset:in std_logic;
       PC_ADDER_MUX_SELECT,Rdst_signal,JUMP_CALL,
       pc_enable:in std_logic;   --ismail's part from control unit
       Mem0,Mem1,WB_Value,
    
    
   );
 end pc_fetch_decode_alu;
 
 
 architecture arc of pc_fetch_decode_alu is
 begin
   ----pc and fetch
   Component pc_fetch is
  port(
    clk ,reset:in std_logic;
    PC_ADDER_MUX_SELECT,Rdst_signal,JUMP_CALL,
      pc_enable:in std_logic;   --ismail's part from control unit
    Mem0,Mem1,WB_Value,
    exe_Rd_out,Port2dataout :in std_logic_vector(15 downto 0); --inputs to last pc mux for jump
    PC_Select:in std_logic_vector(1 downto 0);
    Imediate_Value :out std_logic_vector(15 downto 0)
  );
end Component;


---decode and alu-----
Component Dcode_ALU_Integrate is
 port(--inputs
        port1_selec,port2_selec,mem_wb_Rs,mem_wb_Rd : in std_logic_vector(2 downto 0);
        CCR_Select2,A_Select,B_Select : in Std_logic_vector(1 downto 0);
        CCR_Select1,W_Enable,clk,Reset,Aenable,DEnable,Read_Enable,destination_select : in std_logic ;
        W_Value,WB_Result,Imediate_Value,MEM_WB_ALUResult,sp : in std_logic_vector(15 downto 0);
        aluOperation:in std_logic_vector(3 downto 0);
         --outputs
        result: out  std_logic_vector(15 downto 0);
        ccr:out std_logic_vector(3 downto 0)
    
       );
  
end  Component;



pc_fetch0: pc_fetch port map(   
   
   
   
   clk ,reset:in std_logic;
    PC_ADDER_MUX_SELECT,Rdst_signal,JUMP_CALL,
      pc_enable:in std_logic;   --ismail's part from control unit
    Mem0,Mem1,WB_Value,
    exe_Rd_out,Port2dataout :in std_logic_vector(15 downto 0); --inputs to last pc mux for jump
    PC_Select:in std_logic_vector(1 downto 0);
    Imediate_Value :out std_logic_vector(15 downto 0)
   
   
   
   
 end architecture;
