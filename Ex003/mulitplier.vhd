
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity mulitplier is
 port(
    rst : in std_logic;
    clk : in std_logic;
    start : in std_logic;
    a_in : in std_logic_vector(7 downto 0);
    b_in : in std_logic_vector(7 downto 0);
    r_out : out std_logic_vector(15 downto 0);
    r_valid : out std_logic;
    ready : out std_logic; 
    state : out std_logic_vector(2 downto 0));
end mulitplier;

-- state machine for which we have several states
architecture Behavioral of mulitplier is
    type state_type is (IDLE, AB0, LOAD, OP, FIN, HELLO);
    signal current_s : state_type := IDLE; 
    signal next_s : state_type := IDLE;
    
    signal counter_s : std_logic_vector(7 downto 0) := (others => '0');
    signal n_s, a_s : unsigned(7 downto 0) := (others => '0'); 
    signal r_s : unsigned(15 downto 0) := (others => '0');
begin

  -- tasksynchron 
  MEM_LOGIC: process (clk)
  begin
    if rising_edge(clk) then
        if rst = '1' then 
            current_s <= IDLE;
        else 
            if start = '1' then 
                current_s <= HELLO;   
            end if;
            
--            case current_s is
--                when IDLE => 
--                    --if start = '1' then 
--                        if a_in = "00000000" OR b_in = "00000000" then 
--                            current_s <= AB0;
--                        else
--                            current_s <= LOAD; 
--                        end if;
--                     --end if;
                     
--                when AB0 => 
--                     --n_s <= b_in;
--                     --a_s <= a_in; 
--                     r_s <= (others => '0'); 
--                     current_s <= FIN; 
                     
--                when LOAD => 
--                    n_s <= unsigned(b_in);
--                    a_s <= unsigned(a_in); 
--                    r_s <= (others => '0'); 
--                    current_s <= OP; 
                    
--                WHEN OP => 
--                    r_s <= r_s + a_s;
--                    n_s <= n_s - 1;
--                    if n_s = 1 then 
--                        current_s <= FIN; 
--                    end if;
         
--                WHEN FIN => 
--                    current_s <= IDLE;   
--            end case;
        end if;
     end if;
  end process;
   
    OUTPUT_LOGIC: process(current_s)
    begin 
        case current_s is
            when IDLE => 
                r_out   <= (others => '0');
                r_valid <= '0';
                ready   <= '1'; 
                state   <= "101";     
            when AB0 => 
                r_out   <= std_logic_vector(r_s);
                r_valid <= '0';
                ready   <= '0';
                state   <= "001";  
            when LOAD => 
                r_out   <= (others => '0');
                r_valid <= '0';
                ready   <= '0'; 
                state   <= "010"; 
            WHEN OP => 
                r_out   <= std_logic_vector(r_s);
                r_valid <= '0';
                ready   <= '0';
                state   <= "011"; 
            WHEN FIN => 
                r_out   <= std_logic_vector(r_s);
                r_valid <= '1';
                ready   <= '0';
                state   <= "100"; 
            WHEN HELLO =>
                r_out <= "0000000000000010";                 
            end case;       
    end process; 
    
--  CALC: process(clk_i)
--  begin
--    if state = "00" then
--      -- idle wait procedure
--    elsif state = "01" then
--      -- load procedure
--      a_s <= a_i;
--      n_s <= b_i;
--      r_s <= '0';
--    elsif state = "11" then
--      -- calc procedure
--      r_s <= std_logic_vector(unsigned(r_s) + unsigned(a_s));
--      n_s <= std_logic_vector(unsigned(n_s) + unsigned('1'));
--    end if;   
--  end process;

--    ready_o <= state = "00";
  
--  TRANSITION_LOGIC: process(current_s)
--  begin
--    next_s <= current_s;
    
--    -- idle
--    if current_s = "00" then 
--        if start_i = '1' then 
--            next_s <= "01";
--        else 
--            next_s <= "00";
--        end if; 
        
--    -- load      
--    elsif current_s = "01" then 
--        if n_s = '0' or a_s = '0' then
--            next_s <= "00";
--        else
--            next_s <= "11";
--        end if;
        
--    -- calc 
--    elsif current_s = "11" then
--        if n_s = '0' then 
--            next_s <= "00";
--        end if;
        
--    end if;
    
--  end process;
  
end Behavioral;

--entity mulitplier is
-- port(
--    rst_i : in std_logic;
--    clk_i : in std_logic;
--    start_i : in std_logic;
--    a_i : in std_logic_vector(7 downto 0);
--    b_i : in std_logic_vector(7 downto 0);
--    r_o : out std_logic_vector(15 downto 0);
--    r_valid_o : out std_logic;
--    ready_o : out std_logic);
--end mulitplier;

---- state machine for which we have several states
--architecture Behavioral of mulitplier is
--  signal current_s, next_s : std_logic_vector(1 downto 0);
--  signal a_s,n_s : std_logic_vector(7 downto 0);
--  signal r_s : std_logic_vector(15 downto 0);
--begin

--  -- tasksynchron 
--  process (clk_i,rst_i)
--  begin
--    if rst_i = '1' then
--      current_s <= "00";
--    elsif rising_edge(clk_i) then
--      current_s <= next_s;
--    end if;
--  end process;

--  CALC: process(clk_i)
--  begin
--    if state = "00" then
--      -- idle wait procedure
--    elsif state = "01" then
--      -- load procedure
--      a_s <= a_i;
--      n_s <= b_i;
--      r_s <= '0';
--    elsif state = "11" then
--      -- calc procedure
--      r_s <= std_logic_vector(unsigned(r_s) + unsigned(a_s));
--      n_s <= std_logic_vector(unsigned(n_s) + unsigned('1'));
--    end if;   
--  end process;

--    ready_o <= state = "00";
  
--  TRANSITION_LOGIC: process(current_s)
--  begin
--    next_s <= current_s;
    
--    -- idle
--    if current_s = "00" then 
--        if start_i = '1' then 
--            next_s <= "01";
--        else 
--            next_s <= "00";
--        end if; 
        
--    -- load      
--    elsif current_s = "01" then 
--        if n_s = '0' or a_s = '0' then
--            next_s <= "00";
--        else
--            next_s <= "11";
--        end if;
        
--    -- calc 
--    elsif current_s = "11" then
--        if n_s = '0' then 
--            next_s <= "00";
--        end if;
        
--    end if;
    
--  end process;
  
--end Behavioral;
