-- Entity: xor2
-- Author: Hazael Magino
-- Created: 09/01/2026
-- Architectural: structural 

library STD;
library IEEE;
use IEEE.std_logic_1164.all; 

entity xor2 is

    -- port definitions
    port(input1 : in std_logic;
        input2: in std_logic;
        output: out std_logic);
end xor2;

architecture structural of xor2 is
    
    begin
        output <= input2 xor input1;
    end structural; 





