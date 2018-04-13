Library ieee;
Use ieee.std_logic_1164.all;
entity n_bitAdder is 
  Generic (n: integer :=16); --n has default of 16 bit
  port(A,B: in std_logic_vector(n-1 downto 0);
       Cin: in std_logic;
       Cout: out std_logic;
       S: out std_logic_vector(n-1 downto 0)
      );
      
    end entity n_bitAdder;
    Architecture arch_n_bitadder of  n_bitAdder is
      Component FullAdder is
         port (A,B : in std_logic;
         Cin: in std_logic;
         S,Cout: out std_logic    
        );
        end component;
        signal cout_temp: std_logic_vector(n-1 downto 0);
         begin
           U0: FullAdder port map(A(0),B(0),Cin,S(0),cout_temp(0));
             loop1: for i in 1 to n-1 generate
               U1: FullAdder port map(A(i),B(i),cout_temp(i-1),S(i),cout_temp(i));
               end generate;
               cout <=cout_temp(n-1);
             end arch_n_bitadder;
        


