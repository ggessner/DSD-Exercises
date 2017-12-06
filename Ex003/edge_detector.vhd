----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.11.2017 03:56:39
-- Design Name: 
-- Module Name: edge_detector - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity edge_detector is
    port(
        clk_i : in std_logic;
        reset_i : in std_logic;
        strobe_i : in std_logic;
        p_o : out std_logic;
        state_o : out std_logic_vector(1 downto 0)
    );
end edge_detector;

architecture Behavioral of edge_detector is
    type state_type is (ONE, EDGE, ZERO);
    signal state_s : state_type;
begin
    
      -- one process solution 
--    process(clk_i)
--        begin
--            -- why sync reset over async in state machine ?
--            if rising_edge(clk_i) then 
--                if reset_i = '1' then 
--                    state_s <= ZERO;
--                    p_o <= '0';
--                else
--                    case state_s is
--                                when ZERO => 
--                                    p_o <= '0';
--                                    if strobe_i = '1' then 
--                                        state_s <= EDGE;  
--                                    end if;
                                    
--                                when EDGE =>
--                                    p_o <= '1'; 
--                                    if strobe_i = '1' then 
--                                        state_s <= ONE;
--                                    else 
--                                        state_s <= ZERO;
--                                    end if;
                                    
--                                 when ONE => 
--                                    p_o <= '0';
--                                    if strobe_i = '0' then 
--                                        state_s <= ZERO;
--                                    end if;
--                            end case;            
--                end if; 
--            end if;    
--        end process;
    
    -- TRANSITION LOGIC
    process(clk_i)
    begin
        -- why sync reset over async in state machine ?
        if rising_edge(clk_i) then 
            if reset_i = '1' then 
                state_s <= ZERO;
            else
                case state_s is
                            when ZERO => 
                                if strobe_i = '1' then 
                                    state_s <= EDGE;
                                else
                                    state_s <= ZERO;
                                end if;
                                
                            when EDGE => 
                                if strobe_i = '1' then 
                                    state_s <= ONE;
                                else 
                                    state_s <= ZERO;
                                end if;
                                
                             when ONE => 
                                if strobe_i = '1' then 
                                    state_s <= ONE;
                                else 
                                    state_s <= ZERO;
                                end if;
                        end case;            
            end if; 
        end if;    
    end process;

    -- OUTPUT LOGIC
    OUTPUT_LOGIC: process(state_s)
    begin
        case state_s is 
        when ZERO =>    p_o <= '0';
                        state_o <= "00";
        when EDGE =>    p_o <= '1';
                        state_o <= "01";
        when ONE  =>    p_o <= '0';
                        state_o <= "10";
        end case;
    end process;
 
end Behavioral;
