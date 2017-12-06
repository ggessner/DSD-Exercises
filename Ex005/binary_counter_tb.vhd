library ieee;
use ieee.std_logic_1164.ALL; 
use ieee.numeric_std.All; 

entity binary_counter_tb is 
end binary_counter_tb; 

architecture rtl of binary_counter_tb is 

	component binary_counter is 
        port(
            clk : in std_logic;
            load : in std_logic;
            count : in std_logic;
            data_in : in std_logic_vector(3 downto 0);
            data_out : out std_logic_vector(3 downto 0);
            carry : out std_logic);
	end component binary_counter; 

	constant LENGTH : natural := 4;
	constant clk_half_period_c : time := 2 ns;
	
	signal data_in_s  	: std_logic_vector(3 downto 0) := (others => '0');
	signal data_out_s  	: std_logic_vector(3 downto 0) := (others => '0');
	signal carry_s 		: std_logic := '0';
	signal load_s		: std_logic := '0'; 
	signal count_s		: std_logic := '0'; 
	signal clk_s        : std_logic := '0';
begin

	UUT: binary_counter 
		port map(
			clk => clk_s,
			load => load_s,
			count => count_s,
			data_in => data_in_s,
			data_out => data_out_s,
			carry => carry_s);

	CLOCK: process
	begin 
		clk_s <= not clk_s; 
		wait for clk_half_period_c; 
	end process; 

	process
	begin
		data_in_s <= "0010";
		wait for 7 ns; 
		load_s <= '1'; 
		wait for 4 ns; 
		load_s <= '0'; 
		count_s <= '1'; 
		wait;
	end process; 
	
end rtl;
