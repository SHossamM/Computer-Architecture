library ieee;
use ieee.std_logic_1164.all;

entity Mux8x1 is 
generic(n:integer:=16);
  port(a,b,c,d,e,f,g,h:in std_logic_vector(n-1 downto 0);
       selectin:in std_logic_vector(2 downto 0);
       dataout:out std_logic_vector(n-1 downto 0)
     );
     
end Mux8x1;



architecture Mux8x1_arch of Mux8x1 is
 begin
  
  
  dataout<=a when selectin="000" else
           b when selectin="001" else
           c when selectin="010" else
           d when selectin="011" else
           e when selectin="100" else
           f when selectin="101" else
           g when selectin="110" else
           h;
  
end Mux8x1_arch;
  


