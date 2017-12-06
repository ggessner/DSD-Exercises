library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 

entity multiplier_tb is

end multiplier_tb;

architecture Behavioral of multiplier_tb is
    
   --constant WIDTH_c : integer := 4; 
   constant clk_half_period_c : time := 2 ns;
   
   signal clk_s : STD_logic := '0';
    
   signal rst_s :  std_logic:= '0';
   signal start_s:  std_logic := '0';
   signal a_in_s :  std_logic_vector(7 downto 0) := (others => '0');
   signal b_in_s :  std_logic_vector(7 downto 0) := (others => '0');
   signal r_out_s :  std_logic_vector(15 downto 0) := (others => '0');
   signal r_valid_s :  std_logic := '0';
   signal ready_s :  std_logic := '0';
   signal state_s : std_logic_vector(2 downto 0) := (others => '0');
              
   -- define component
   component multiplier is
       port(
           rst : in std_logic;
           clk : in std_logic;
           start : in std_logic;
           a_in : in std_logic_vector(7 downto 0);
           b_in : in std_logic_vector(7 downto 0);
           r_out : out std_logic_vector(15 downto 0);
           r_valid : out std_logic;
           ready : out std_logic;
           state : std_logic_vector(2 downto 0));
   end component multiplier;

begin
   -- instantiate gray counter !
    UUT: multiplier
           port map(
               rst     => rst_s,
               clk     => clk_s,
               start   => start_s,
               a_in    => a_in_s,
               b_in    => b_in_s,
               r_out   => r_out_s,
               r_valid => r_valid_s,
               ready   => ready_s,
               state    => state_s
          );     
   
    -- clock
    --  finished_s <= '1' after 100 ns; 
    --  clk_s <= not clk_s after clk_half_period_c when finished_s /= '1' else '0';
    CLK_process: process 
    begin 
       clk_s <= not clk_s;
       wait for clk_half_period_c; 
    end process; 
    
    CALC_process: process
    begin
        
        rst_s <= '1'; 
        wait for 10 ns; 
        rst_s <= '0';
        wait for 20 ns; 
       --a_in_s <= "00000100"; -- 4
       --b_in_s <= "00000101"; -- 5
       a_in_s <= (others => '0');
       b_in_s <= (others => '0');
       wait for 10 ns; 
       start_s <= '1'; 
       wait for 20 ns; 
       start_s <= '0';
       --wait for 20 ns; 
       wait; 
    end process;
   
  
  
end Behavioral;

 
   