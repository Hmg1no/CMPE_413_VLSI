-- Entity: or2 
-- Author: Hazael Magino
-- Created: 9/1/2026
-- Architectural: structural 

entity or2 is
    port(
        input1 : in std_logic;
        input2 : in std_logic;
        output : out std_logic
    );
    end or2;

architecture structural or2 is

    begin
        output <= input1 or input2
    end structural;  