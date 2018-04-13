library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add is
  port(
     a,b: in std_logic_vector(3 downto 0);
     s: out std_logic_vector(3 downto 0)
      );
      
    end add;
    
     Architecture sum of add is
       signal si,sii,siii: signed(3 downto 0) ;
     begin
  si<=signed(a) + signed(b);
  sii<=signed(a) - signed(b);
  siii<=signed(a) sll 4;
  
   end  architecture sum;

