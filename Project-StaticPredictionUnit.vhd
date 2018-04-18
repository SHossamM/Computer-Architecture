

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PStaticPredictionUnit is
port( 
	clk : in std_logic;
	CCR : in std_logic_vector(3 downto 0);	--ZeroFlag, NegativeFlag, CarryFlag, OverflowFlag   0000
	OPcode : in std_logic_vector(5 downto 0);

	Flush: out std_logic
);
end entity PStaticPredictionUnit;

architecture archPStaticPredictionUnit of PStaticPredictionUnit is
begin
	process(clk) is	
	--Variable counter: std_logic_vector(3 downto 0);
	begin
		if rising_edge(clk) then
			if OPcode = "100001" AND CCR(2) = '1' then	--Jump Carry 
				Flush <= '1';
			elsif OPcode = "100100" AND CCR(0) = '1' then	--Jump Zero 
				Flush <= '1';
			elsif OPcode = "100101" AND CCR(1) = '1' then	--Jump Negative 
				Flush <= '1';
			else
				Flush <= '0';
			end if;
		end if;
	end process;
end architecture;

