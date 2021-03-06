Library ieee;
Use ieee.std_logic_1164.all;
use ieee.numeric_std.all ;
entity HazardDetection is 
port(
ID_Ex_MemREAD : in std_logic;
ID_Ex_Rdestination ,IF_ID_Rdestination,IF_ID_RSource      : in std_logic_vector(2 downto 0);
ControlSelect , PcEnable ,FWDWEnable : out std_logic
);
end HazardDetection ;

Architecture HazardDetectionarch of HazardDetection is 
begin

ControlSelect <= '1' when (ID_EX_MemRead ='1') and ((ID_Ex_Rdestination = IF_ID_Rdestination ) or (ID_Ex_Rdestination = IF_ID_RSource)) else
'0';
PcEnable <= '0' when (ID_EX_MemRead ='1') and ((ID_Ex_Rdestination = IF_ID_Rdestination ) or (ID_Ex_Rdestination = IF_ID_RSource)) else
'0';
FWDWEnable <= '0' when (ID_EX_MemRead ='1') and ((ID_Ex_Rdestination = IF_ID_Rdestination ) or (ID_Ex_Rdestination = IF_ID_RSource)) else
'0';
end HazardDetectionarch;