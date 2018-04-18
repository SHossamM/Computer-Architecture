Library ieee;
Use ieee.std_logic_1164.all;

entity Reg is 
  port(
	clk,rst, d: in std_logic;
       	q:out std_logic;
	enable : in std_logic
       );
     end Reg;

Architecture Reg_arch of Reg is
 begin
  process(clk,rst)
   begin
     if(rst='1') then
         q<='0';
      elsif (Clk='0') then
        if(enable='1') then
        q<=d;
         end if;
     end if;
    end process;
  end Reg_arch;
    
  

