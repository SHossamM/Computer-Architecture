Library ieee;
Use ieee.std_logic_1164.all;

entity FullAdder is
   port (A,B : in std_logic;
         Cin: in std_logic;
         S,Cout: out std_logic    
        );
 end   entity FullAdder;
 
 
 architecture  arch_FullAdder  of FullAdder is
  begin
    S<=(A xor B xor Cin);
    Cout<=(A and B) or (Cin and (A xor B));
    
end      architecture  arch_FullAdder;