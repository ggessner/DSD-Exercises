library IEEE; 
use IEEE.std_logic_1164.ALL; 
use IEEE.NUMERIC_STD.ALL; 
 
entity safe is 
	generic(
		LENGTH : natural := 5; 
		PSW : std_logic_vector := "11010"); -- unconstrained bc cant use Length in declaration
	port(
		clk_i : in std_logic; 
		reset_i : in std_logic; 
		psw_i : in std_logic;
		en_i : in std_logic; 
		unlock_o : out std_logic);
end safe;

architecture rtl of safe is 
	type state_type is (LOCK,CHECK,UNLOCK);
	signal state_s,next_s : state_type;
	signal count_s: integer range 0 to LENGTH-1;
begin 

	REG_LOGIC: process (clk_i, reset_i)
	begin
		if reset_i = '1' then 
			state_s <= LOCK;
			--count_s <= (others => '0');
		elsif rising_edge(clk_i) then
		    if en_i = '1' then
		      state_s <= next_s;
		    end if; 
		end if; 
	end process;
	
	TRANSITION_LOGIC: process(state_s, psw_i)
	begin 
	   case state_s is
	   
            when LOCK => 
                next_s <= CHECK;
                count_s <= 0; 
                
            when CHECK => 
               if psw_i = PSW(count_s) then  
                  if count_s = LENGTH-1 then
                     next_s <= UNLOCK;
                     count_s <= 0;
                  else 
                     next_s <= CHECK;
                     count_s <= count_s + 1;
                  end if;    
               else
                  next_s <= LOCK;
                  count_s <= 0;
               end if;
                    
            when UNLOCK => 
                next_s <= LOCK; 
                count_s <= 0;
                       
       end case;
	end process;
	
	-- output logic 
	unlock_o <= '1' when state_s = UNLOCK else '0'; 
	
end architecture rtl;
