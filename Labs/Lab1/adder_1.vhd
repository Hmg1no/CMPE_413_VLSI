-- Entity: adder_1
-- Author: Hazael Magino
-- Created: 09/01/2026
-- Architectural: structural 

library STD;
library IEEE;
use IEEE.std_logic_1164.all; 

entity adder_1 is
    port(
        input1: in std_logic;
        input2: in std_logic;
        carryI: in std_logic;
        sum: out std_logic;
        carryO: out std_logic
        );

end adder_1;
    

architecture structural of adder_1 is

    component xor2
        port(
            input1: in std_logic;
            input2: in std_logic;
            output: out std_logic
        );

    end component;

    component and2 
        port(
            input1: in std_logic; 
            input2: in std_logic; 
            output: out std_logic
        ); 

    end component;

    component or2
        port(
            input1: in std_logic;
            input2: in std_logic;
            output: out std_logic
        );
    
    end component;

    -- Port Mappings    
        signal AXB, AandB, AXB_Cin : std_logic;

        -- AXB A xor B output
        -- AandB AandB output 
        -- AXB_Cin AXB and Cinput output 


    begin
        xor2_1: xor2 port map (input1, input2, AXB);
        xor2_2: xor2 port map (AXB, carryI, Sum);
        and2_1: and2 port map (input1, input2, AandB);
        and2_2: and2 port map (AXB, carryI, AXB_Cin); 
        or2_1: or2 port map (AXB_Cin, AandB, carryO);

    end structural; 
