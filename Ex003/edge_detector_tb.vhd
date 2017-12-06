library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity edge_detector_tb is
--  Port ( );
end edge_detector_tb;

architecture Behavioral of edge_detector_tb is
    
    constant WIDTH_c : integer := 4; 
    constant clk_half_period_c : time := 5 ns;
    
    
    signal reset_s : STD_logic := '0'; 
    signal clk_s : STD_logic := '0'; 
    signal strobe_s : STD_LOGIC := '0'; 
    
    signal p1_s : std_logic;
    signal p2_s : std_logic;
    signal p3_s : std_logic;
    
    signal state_1_s : std_logic_vector(1 downto 0) := (others => '0');
    signal state_2_s : std_logic_vector(1 downto 0) := (others => '0');
    signal state_3_s : std_logic_vector(1 downto 0) := (others => '0');
    
    -- define components
    component edge_detector is
        port(
            clk_i : in std_logic;
            reset_i : in std_logic;
            strobe_i : in std_logic;
            p_o : out std_logic;
            state_o : out std_logic_vector(1 downto 0)
        );
    end component edge_detector;
    
    component edge_detector_v2 is
        port(
            clk_i : in std_logic;
            reset_i : in std_logic;
            strobe_i : in std_logic;
            p_o : out std_logic; 
            state_o : out std_logic_vector(1 downto 0)
        );
    end component edge_detector_v2;

    component edge_detector_v3 is
        port(
            clk_i : in std_logic;
            reset_i : in std_logic;
            strobe_i : in std_logic;
            p_o : out std_logic;
            state_o : out std_logic_vector(1 downto 0)
        );
    end component edge_detector_v3;
    
begin
    -- instantiate gray counter !
    ED_v1: edge_detector
        port map(
            clk_i => clk_s,
            reset_i => reset_s,
            strobe_i => strobe_s,
            p_o => p1_s,
            state_o => state_1_s
        );
     
     ED_v2: edge_detector_v2
        port map(
            clk_i => clk_s,
            reset_i => reset_s,
            strobe_i => strobe_s,
            p_o => p2_s,
            state_o => state_2_s       
        );
        
     ED_v3: edge_detector_v3
        port map(
            clk_i => clk_s,
            reset_i => reset_s,
            strobe_i => strobe_s,
            p_o => p3_s,
            state_o => state_3_s
        );
        
     -- clock
     CLK_process: process 
     begin 
        clk_s <= not clk_s;
        wait for clk_half_period_c; 
     end process; 
     
     STROBE_process: process
     begin 
        strobe_s <= '0'; 
        wait for 11 ns; 
        strobe_s <= '1'; 
        wait for 1 ns; 
        strobe_s <= '0'; 
        wait for 1 ns;
        strobe_s <= '1';
        wait for 40 ns;
        strobe_s <= '0';
        wait;
     end process;
     
end Behavioral;
