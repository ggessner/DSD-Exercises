library ieee;
use ieee.std_logic_1164.ALL; 
use ieee.numeric_std.All; 

entity binary_counter is 
	port(
		clk : in std_logic;
		load : in std_logic;
		count : in std_logic;
		data_in : in std_logic_vector(3 downto 0);
		data_out : out std_logic_vector(3 downto 0);
		carry : out std_logic);
end binary_counter; 


architecture rtl of binary_counter is 
	signal data_s : std_logic_vector(3 downto 0); 
	signal data_in_s : std_logic_vector(3 downto 0); 
	signal a1 : std_logic; 
	signal a2 : std_logic; 
	signal a3 : std_logic; 
	signal a4 : std_logic;
	signal a5 : std_logic; 
begin

	process(clk)
	begin
		-- no reset necessary
		if clk'event and clk = '1' then 
			data_s <= data_in_s;
		end if;
	end process; 
	
	-- combinational logic 
	a1 <= count AND NOT load; 
	data_in_s(0) <= (load AND data_in(0)) OR ((a1 XOR data_s(0)) AND NOT load);
	
	a2 <= a1 AND data_s(0);
	data_in_s(1) <= (load AND data_in(1)) OR ((a2 XOR data_s(1)) AND NOT load);
	
	a3 <= a2 AND data_s(1);
	data_in_s(2) <= (load AND data_in(2)) OR ((a3 XOR data_s(2)) AND NOT load);
	
	a4 <= a3 AND data_s(2);
	data_in_s(3) <= (load AND data_in(3)) OR ((a4 XOR data_s(3)) AND NOT load);
	
	a5 <= a4 AND data_s(3);

	data_out 	<= data_s;
	carry 		<= a5;
	--carry 		<= '1' when load = '0' and count = '1' and data_s = (data_s'range => '1') else '0';
end rtl;
