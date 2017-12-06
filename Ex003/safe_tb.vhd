library IEEE; 
use IEEE.std_logic_1164.ALL; 
use IEEE.NUMERIC_STD.ALL; 

entity safe_tb is
--  Port ( );
end safe_tb;

architecture Behavioral of safe_tb is
    
    constant WIDTH_c : integer := 5; 
    constant clk_half_period_c : time := 5 ns;
    constant PSW_c : std_logic_vector(WIDTH_c-1 downto 0) :="01000"; --01000
    
    signal result_s : STD_logic;
    signal reset_s : STD_logic := '0'; 
    signal clk_s : STD_logic := '0';
    signal en_s : std_logic := '0';
    signal psw_s : STD_LOGIC := '0'; 
    
    -- define components
    component safe is 
        generic(
            LENGTH : natural; 
            PSW : std_logic_vector);
        port(
            clk_i : in std_logic; 
            reset_i : in std_logic; 
            psw_i : in std_logic;
            en_i : in std_logic; 
            unlock_o : out std_logic);
    end component safe;
    
begin
    -- instantiate gray counter !
    UUT: safe
        generic map(
            LENGTH => WIDTH_c,
            PSW => PSW_c)
        port map(
            clk_i => clk_s,
            reset_i => reset_s,
            psw_i => psw_s,
            en_i => en_s,
            unlock_o => result_s);
 
     -- clock
     CLK_process: process 
     begin 
        clk_s <= not clk_s;
        wait for clk_half_period_c; 
     end process; 
     
     -- test 
     TEST_PROCESS: process
     begin
        wait for 10 ns; 
        en_s <= '1'; 
                psw_s <= '1'; 
        wait for 10 ns;
                psw_s <= '1'; 
        wait for 10 ns; 
                psw_s <= '0'; 
        wait for 10 ns;
                psw_s <= '1'; 
        wait for 10 ns;
                psw_s <= '0';
        wait for 10 ns; 
                psw_s <= '1'; 
        wait for 10 ns; 
                psw_s <= '0'; 
        wait for 10 ns;
                psw_s <= '0'; 
        wait for 10 ns; 
                psw_s <= '0'; 
        wait for 10 ns;
                psw_s <= '1'; 
        wait for 10 ns;
                psw_s <= '1';
        wait for 10 ns; 
                psw_s <= '0'; 
        wait;
     end process;
end Behavioral;