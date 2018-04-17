library ieee;
use ieee.std_logic_1164.all;

entity Mux4x1 is 
generic(n:integer:=16);
  port(a,b,c,d:in std_logic_vector(n-1 downto 0);
       selectin:in std_logic_vector(1 downto 0);
       dataout:out std_logic_vector(n-1 downto 0)
     );
     
end Mux4x1;



architecture Mux4x1_arch of Mux4x1 is
 begin
  
  
  dataout<=a when selectin="00" else
           b when selectin="01" else
           c when selectin="10" else
           d;
  
end Mux4x1_arch;
  

