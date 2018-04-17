library ieee;
use ieee.std_logic_1164.all;

entity Mux2x1 is 
generic(n:integer:=16);
  port(a,b:in std_logic_vector(n-1 downto 0);
       selectin:in std_logic;
       dataout:out std_logic_vector(n-1 downto 0)
     );
     
end Mux2x1;



architecture Mux2x1_arch of Mux2x1 is
 begin
  
  
  dataout<=a when selectin='0' else
           b;
  
end Mux2x1_arch;
  