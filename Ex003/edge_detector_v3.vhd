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

entity edge_detector_v3 is
    port(
        clk_i : in std_logic;
        reset_i : in std_logic;
        strobe_i : in std_logic;
        p_o : out std_logic;
        state_o : out std_logic_vector(1 downto 0)
    );
end edge_detector_v3;

architecture Behavioral of edge_detector_v3 is
    type state_type is (ONE, DELAY, ZERO);
    signal state_s, next_s : state_type;
begin

    -- REG LOGIC
    REG_LOGIC: process(clk_i, reset_i)
    begin
        if reset_i = '1' then 
            state_s <= ZERO;
        elsif rising_edge(clk_i) then
            state_s <= next_s; 
        end if;
    end process;

    TRANSITION_LOGIC: process(state_s, strobe_i)
    begin 
                    case state_s is
                    when ZERO => 
                        if strobe_i = '1' then 
                            next_s <= DELAY;
                        else
                            next_s <= ZERO;
                        end if;
                        
                    when DELAY => 
                        if strobe_i = '1' then 
                            next_s <= ONE;
                        else 
                            next_s <= ZERO;
                        end if;
                        
                     when ONE => 
                        if strobe_i = '1' then 
                            next_s <= ONE;
                        else 
                            next_s <= ZERO;
                        end if;
                    end case;
    end process;
    
    -- OUTPUT LOGIC
    process(state_s)
    begin
         case state_s is
            when ZERO =>    p_o <= '0';
                            state_o <= "00"; 
            when DELAY =>   p_o <= strobe_i;
                            state_o <= "01";
            when ONE =>     p_o <= '1';
                            state_o <= "10";
         end case;   
    end process;
    
end Behavioral;
