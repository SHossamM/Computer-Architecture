Library ieee;
Use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
Entity spreg is
  port(--inputs 
        clk,reset,popsig,pushsig,sp_enable: in std_logic;
         sp: out std_logic_vector(15 downto 0)
      );
    end spreg;
architecture sp_arc of spreg is
  
  signal sp_temp:unsigned(15 downto 0);
begin
  process(reset,clk) is
    begin
      if reset='1' then
        sp_temp<=(others=>'1'); --1023
      elsif( clk='1' and popsig='1' and sp_enable='1') then
        sp_temp<=sp_temp+1;
      elsif( clk='1' and pushsig='1' and sp_enable='1') then
       sp_temp<=sp_temp-1;
     end if;  
    end process;
    sp<=std_logic_vector(sp_temp);
end sp_arc;
       


