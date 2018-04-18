library ieee;
use ieee.std_logic_1164.all;

entity forwardingUnit is 
  port(--inputs
       exec_mem_regwrite,
       mem_wb_regwrite: in std_logic;
       id_exec_Rs,
       id_exec_Rd,
       exec_mem_Rs,
       exec_mem_Rd,
       mem_wb_Rd:in std_logic_vector(2 downto 0);
       control_a_select,
       control_b_select:in std_logic_vector(1 downto 0) ;
       
       --outputs
       a_select,
       b_select:out std_logic_vector(1 downto 0)    
       );
   end forwardingUnit;
   
   
   
architecture forwardingUnit_arch of forwardingUnit is
    begin
    
    
     a_select<="01"  when((exec_mem_regwrite='1') and (exec_mem_Rd = id_exec_Rs )) else --alu-alu forwarding --current stage in exec will write back in same register to beread in exec-->do i need regread siganl here?
              "10"  when (mem_wb_regwrite='1' and mem_wb_Rd=exec_mem_Rs) else  --full forwarding --alu result in exec_mem_buffer 
              control_a_select ; --normal operation no hazards
    
     b_select<="01" when(exec_mem_regwrite='1' and exec_mem_Rd=id_exec_Rd) else  --current stage in exec will write back in same register to beread in exec
               "10" when(mem_wb_regwrite='1' and mem_wb_Rd=exec_mem_Rd) else --alu result in exec_mem_buffer  
               control_b_select ;


    
  end forwardingUnit_arch;
