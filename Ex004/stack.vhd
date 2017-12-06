library  ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity stack is 
	generic(
		RAM_WIDTH	:	natural range 1 to 96 := 8; 
		RAM_DEPTH	:	natural range 5 to 20 := 5);
	port(
		clk : in std_logic; 
		rst : in std_logic; 
		D_in : in std_logic_vector(RAM_WIDTH-1 downto 0);
		D_out : out std_logic_vector(RAM_WIDTH-1 downto 0);
		push : in std_logic;
		pop : in std_logic;
		empty : out std_logic;
		full : out std_logic);
		
end entity stack; 


architecture syn of stack is 
	
	component rams_01 is 
		generic ( 
			RAM_WIDTH : natural range 1 to 96;
			RAM_DEPTH : natural range 5 to 20);
		port ( 
			clk  : in   std_logic ;
			we	 : in   std_logic ;
			en	 : in   std_logic ;
			addr : in   std_logic_vector (RAM_DEPTH - 1  downto 0);
			di   : in   std_logic_vector (RAM_WIDTH - 1  downto 0);
			do   : out  std_logic_vector (RAM_WIDTH - 1  downto 0));
	end component rams_01;
	
	signal we_s, en_s : std_logic; 
	signal addr_s,SP : std_logic_vector(RAM_DEPTH downto 0); 

begin 
	
	UUT: rams_01 
		generic map(
			RAM_WIDTH => RAM_WIDTH,
			RAM_DEPTH => RAM_DEPTH)
		port map(
			clk => clk,
			we => we_s,
			en => en_s,
			--addr => addr_s(RAM_DEPTH-1 downto 0),
			addr => SP(RAM_DEPTH-1 downto 0), -- ????
			di => D_in,
			do => D_out);
	
		process(clk,rst)
		begin 
			if rst = '1' then 
				SP <= (others => '0');
			elsif rising_edge(clk) then 	
				if pop = '1' and push = '1' then 
					-- do nothing !!
				elsif pop = '1' and SP /= (SP'range => '0') then  -- pop operation
					SP <= SP - '1';
					addr_s <= SP; 
				elsif push = '1' and SP(RAM_DEPTH) /= '1' then -- push operation
					addr_s <= SP + 1;
				end if; 
			end if; 
		end process; 
		en_s  <= '1' when (push = '1' and SP(RAM_DEPTH) /= '1') OR (pop = '1' and SP /= (SP'range => '0')) else '0'; 
		we_s  <= '1' when (push = '1' and SP(RAM_DEPTH) /= '1') else '0';
		full  <= '1' when SP(RAM_DEPTH) = '1' else '0'; 
		empty <= '1' when SP = (SP'range => '0') else '0';
end syn; 
