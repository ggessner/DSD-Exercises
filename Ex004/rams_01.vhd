library  ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
	
	entity  rams_01 is 
		generic ( 
			RAM_WIDTH : natural range 1 to 96 := 8;
			RAM_DEPTH : natural range 5 to 20 := 5);
		port ( 
			clk  : in   std_logic ;
			we	 : in   std_logic ;
			en	 : in   std_logic ;
			addr : in   std_logic_vector (RAM_DEPTH - 1  downto 0);
			di   : in   std_logic_vector (RAM_WIDTH - 1  downto 0);
			do   : out  std_logic_vector (RAM_WIDTH - 1  downto 0));
	end rams_01;

	architecture syn of rams_01 is 
		type ram_type is array(2**RAM_DEPTH-1 downto 0) of std_logic_vector(RAM_WIDTH-1 downto 0);
		signal RAM : ram_type;
	begin 
		process(clk)
		begin
			if clk'event and clk = '1' then 
				if en = '1' then 
					if we = '1' then 
						RAM(conv_integer(addr)) <= di;
					end if;
					do <= RAM(conv_integer(addr));
				end if;
			end if;
		end process;
	end syn;
