Library ieee;
Use ieee.std_logic_1164.all;

Entity Registern is
Generic ( n : integer := 16);
port( Clk,Rst : in std_logic;
d : in std_logic_vector(n-1 downto 0);
q : out std_logic_vector(n-1 downto 0);
enable : in std_logic );
end Registern;

Architecture Registerarch of Registern is
begin
Process (Clk,Rst,enable)
begin
if Rst = '1' then
q <= (others=>'0');
elsif (Clk='1' ) then
if enable = '1' then 
q <= d;
end if;
else 
if enable = '1' then 
q <= d;
end if;
end if;
end process;
end Registerarch;
