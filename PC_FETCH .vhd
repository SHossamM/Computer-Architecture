Library ieee;
Use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
Entity pc_fetch is
  port(
    clk ,reset:in std_logic;
    PC_ADDER_MUX_SELECT,Rdst_signal,JUMP_CALL,
      pc_enable:in std_logic;   --ismail's part from control unit
    Mem0,Mem1,WB_Value,
    exe_Rd_out,Port2dataout :in std_logic_vector(15 downto 0); --inputs to last pc mux for jump
    PC_Select:in std_logic_vector(1 downto 0);
    Imediate_Value,pc_out :out std_logic_vector(15 downto 0)
  );
end pc_fetch;


architecture   pc_fetch_arc of pc_fetch is
  
  
   ----MUX2X1-------------
component Mux2x1 is 
generic(n:integer:=16);
  port(a,b:in std_logic_vector(n-1 downto 0);
       selectin:in std_logic;
       dataout:out std_logic_vector(n-1 downto 0)
       );
     
end component;

 component Mux4x1 is 
generic(n:integer:=16);
  port(a,b,c,d:in std_logic_vector(n-1 downto 0);
       selectin:in std_logic_vector(1 downto 0);
       dataout:out std_logic_vector(n-1 downto 0)
     );
     
end component;

---Register
component pcreg is
Generic ( n : integer := 8);
port( Clk,Rst : in std_logic;
d : in std_logic_vector(n-1 downto 0);
q : out std_logic_vector(n-1 downto 0);
enable : in std_logic );
end component;

---N-ADDER------------
component n_bitAdder is 
  Generic (n: integer :=16); --n has default of 16 bit
  port(A,B: in std_logic_vector(n-1 downto 0);
       Cin: in std_logic;
       Cout: out std_logic;
       S: out std_logic_vector(n-1 downto 0)
      );
      
    end component;
  
    --fetch memory component
  component PFetchUnit is
port( 
	clk : in std_logic;
	PC:   in std_logic_vector(15 downto 0);
	
	Inst: out std_logic_vector(15 downto 0)
);
end  component;

---------------------------------PC SIGNAL-------------------------------
signal PC,PC_IN,PC_ADDER_MUX_OUT,PC_ADDER_OUT,PC_MUX3_OUt: std_logic_vector(15 downto 0); 
signal Rdst_MUX_OUT : std_logic_vector(15 downto 0);
signal PC_ADDER_COUT: std_logic;

  

begin

---------------------------------pc register-------------------------------
 PC_ADDER_MUX : Mux2x1 generic map(n=>16) port map("0000000000000001","0000000000000000",PC_ADDER_MUX_SELECT,PC_ADDER_MUx_OUT);
 PC_adder :n_bitAdder generic map(n=>16) port map(PC,PC_ADDER_MUx_OUT,'0',PC_ADDER_COUT,PC_ADDER_OUT);
 PC_SECOUND_MUX : mux2x1 generic map(n=>16 ) port map(exe_Rd_out,Port2dataout,Rdst_signal,Rdst_MUX_OUT);--bta3et ahmed w kamal check!
 PC_THRID_MUX : mux2x1 generic map(n=>16) port map(PC_ADDER_OUT,Rdst_MUX_OUT,JUMP_CALL,PC_MUX3_OUt);
 PCmux :Mux4x1 generic map(n=>16) port map(WB_Value,PC_MUX3_OUt,Mem0,Mem1,PC_Select,PC_IN);
   
   
 PC0: pcreg generic map(n=>16)  port map(clk,'0', PC_IN,PC,pc_enable); --reseted differently using mem[0] and control unit handles this 
                                                                    --ALSO pc always enabled and control unit chooses whether to write old value pc+0
                                                                    --or new pc value ??? wla pc_enable mn hazard detection unit?
  ----------------------------------------------------------------------------------
  
  pc_out<=pc;
  ---------------------------------fetch stage------------------------------- 
  INS_MEM : PFetchUnit port map (clk,PC,Imediate_Value);
  
  
end architecture;
