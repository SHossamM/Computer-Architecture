
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testunit is
port( 
	x, y: in std_logic_vector(3 downto 0);
	z : out std_logic_vector(3 downto 0)
);
end entity testunit;

architecture archtestunit of testunit is
begin
	z<= x OR y;

end architecture;
