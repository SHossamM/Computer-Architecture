Library ieee;
Use ieee.std_logic_1164.all;
Entity Registerfile is
port(
port1_selec,port2_selec,W_selector : in std_logic_vector(2 downto 0);
W_Enable,clk,Reset,Enable,Read_Enable : in std_logic ;
W_Value : in std_logic_vector(15 downto 0);
Port1data,Port2data : out std_logic_vector(15 downto 0));
end Registerfile;

Architecture Registerfilearch of Registerfile is
signal Regdatain1 : std_logic_vector(15 downto 0);
signal Regdataout1 : std_logic_vector(15 downto 0);
signal Regdatain2 : std_logic_vector(15 downto 0);
signal Regdataout2 : std_logic_vector(15 downto 0);
signal Regdatain3 : std_logic_vector(15 downto  0);
signal Regdataout3 : std_logic_vector(15 downto  0);
signal Regdatain4 : std_logic_vector(15 downto  0);
signal Regdataout4 : std_logic_vector(15 downto 0);
signal Regdatain5 : std_logic_vector(15 downto  0);
signal Regdataout5 : std_logic_vector(15 downto 0);
signal Regdatain6 : std_logic_vector(15 downto  0);
signal Regdataout6 : std_logic_vector(15 downto 0);

Component Registern is
port( Clk,Rst : in std_logic;
d : in std_logic_vector(15 downto 0);
q : out std_logic_vector(15 downto 0);
enable : std_logic );
end component;
begin

process(clk,Reset,Regdataout1,Regdataout2,Regdataout3,Regdataout4,Regdataout5,Regdataout6,W_value)
begin 
if(Reset = '1')
then 
Port1data <= "0000000000000000";
Port2data <= "0000000000000000";
else 
	if (clk='1') then
	if(W_Enable='1') then
		if(W_selector="000")then 
		Regdatain1 <= W_Value;
		elsif (W_selector="001")then
			Regdatain2 <= W_Value;
		elsif (W_selector="010")then
			Regdatain3 <= W_Value;
		elsif (W_selector="011") then
			Regdatain4 <= W_Value;
		elsif (W_selector ="100") then
			Regdatain5 <= W_Value;
		elsif (W_selector = "101") then
			Regdatain6 <= W_Value; 
		else
			null ;
		end if;
	else
	null;	     
	end if;
end if;
end if;
 if(clk='0') then
	if(Read_Enable ='1') then 
	
if(port1_selec="000") then
		Port1data<=Regdataout1;
	     elsif(port1_selec="001") then
		Port1data <= Regdataout2;
	     elsif(port1_selec="010") then
		Port1data <= Regdataout3;
     	     elsif(port1_selec="011") then
		Port1data <= Regdataout4;
    	     elsif(port1_selec="100") then
		Port1data <= Regdataout5;
     	     elsif(port1_selec="101") then
		Port1data <= Regdataout6;
	     else
		 null;
		end if ;

	     if(port2_selec="000") then
		Port2data<=Regdataout1;
	     elsif(port2_selec="001") then
		Port2data <= Regdataout2;
	     elsif(port2_selec="010") then
		Port2data <= Regdataout3;
     	     elsif(port2_selec="011") then
		Port2data <= Regdataout4;
    	     elsif(port2_selec="100") then
		Port2data <= Regdataout5;
     	     elsif(port2_selec="101") then
		Port2data <= Regdataout6;
	     else
		 null;
		end if ;
	   else null;
	end if;
	else null;
	end if;
	end process;
Reg1 : Registern generic map(n=>16) port map(clk,Reset,Regdatain1,Regdataout1,Enable);
Reg2 : Registern generic map(n=>16) port map(clk,Reset,Regdatain2,Regdataout2,Enable);
Reg3 : Registern generic map(n=>16) port map(clk,Reset,Regdatain3,Regdataout3,Enable);
Reg4 : Registern generic map(n=>16) port map(clk,Reset,Regdatain4,Regdataout4,Enable);
Reg5 : Registern generic map(n=>16) port map(clk,Reset,Regdatain5,Regdataout5,Enable);
Reg6 : Registern generic map(n=>16) port map(clk,Reset,Regdatain6,Regdataout6,Enable);
end Registerfilearch ;