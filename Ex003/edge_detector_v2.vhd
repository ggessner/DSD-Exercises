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

entity edge_detector_v2 is
    port(
        clk_i : in std_logic;
        reset_i : in std_logic;
        strobe_i : in std_logic;
        p_o : out std_logic;
        state_o : out std_logic_vector(1 downto 0)
    );
end edge_detector_v2;

architecture Behavioral of edge_detector_v2 is
    type state_type is (ONE, ZERO);
    signal state_s : state_type;
begin
    
    -- TRANSITION LOGIC
    process(clk_i)
    begin    
        if rising_edge(clk_i) then 
            if reset_i = '1' then 
                state_s <= ZERO;
            else
                case state_s is
                when ZERO => 
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
    p_o <= strobe_i when state_s = ZERO else '0';
    state_o <= "01" when state_s = ONE else "00"; 
end Behavioral;
