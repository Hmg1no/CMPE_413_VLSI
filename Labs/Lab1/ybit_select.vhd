-- Entity: ybit_select
-- Author: Hazael Magino
-- Created: 9/3/2026
-- Architectural: structural 

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

-- Port definitions for the ybit select to be used in the ALU.
entity ybit_select is
    port(
        Bin : in std_logic_vector(3 downto 0);
        s0_in: in std_logic;
        s1_in: in std_logic;
        Y_out: out std_logic_vector(3 downto 0)
        );
end ybit_select;

architecture structural of ybit_select is 

    -- Need ybit select as the base structure to send the inputs to the ybit select. 
    component ybit
    
        port(
            S1: in std_logic;
            S0: in std_logic;
            B: in std_logic;
            ySel: out std_logic 
        );  
    end component;

    -- For the 4 cases of the 4 bit input, we will need 4 ybit select components to select 
    -- which bit of the 4 bit input will be sent to the output.

    for yb0, yb1, yb2, yb3: ybit use entity work.ybit(structural);
    
    -- Port Mappings for each select bit option to be sent to the y-output.

    begin
        yb0: ybit port map(s1_in, s0_in, Bin(0), Y_out(0));
        yb1: ybit port map(s1_in, s0_in, Bin(1), Y_out(1));
        yb2: ybit port map(s1_in, s0_in, Bin(2), Y_out(2));
        yb3: ybit port map(s1_in, s0_in, Bin(3), Y_out(3));
        
    end structural;

