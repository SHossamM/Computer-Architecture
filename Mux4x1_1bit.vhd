
library ieee;
use ieee.std_logic_1164.all;

entity Mux4x1_1bit is 
  port(a,b,c,d:in std_logic;
       selectin:in std_logic_vector(1 downto 0);
       dataout:out std_logic
     );
     
end Mux4x1_1bit;



architecture Mux4x1_1bit_arch of Mux4x1_1bit is
 begin
  
  
  dataout<=a when selectin="00" else
           b when selectin="01" else
           c when selectin="10" else
           d;
  
end Mux4x1_1bit_arch;
  


