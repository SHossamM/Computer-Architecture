Library ieee;
Use ieee.std_logic_1164.all;
Entity ControlUnit is
  port(Opcode:in std_logic_vector(5 downto 0);
      port1_selec,port2_selec,Mem_Read_Address_Select,wb_signal_select : out std_logic_vector(2 downto 0);
      alu_op_select,CCR_Select2, WB_Dest_Select, 
      Mem_Write_Address_Select,PC_Select : out Std_logic_vector(1 downto 0);
      CCR_Select1,clk,Reset,Aenable,DEnable,Read_Enable,destination_select, MR,MW,WB_signal ,
      PC_ADDER_MUX_SELECT,Rdst_signal,JUMP_CALL: out std_logic ;
      control_a_select,control_b_select:out std_logic_vector(1 downto 0) 
    );
end ControlUnit;


--not complete just to start
architecture ControlUnit_Arc of ControlUnit is
 begin
  MR<='0' when (Opcode="000000") else
      '1';
  MW  <='0' when (Opcode="000000") or (Opcode="010111") else
      '1';
   
   
   
 end ControlUnit_arc;
