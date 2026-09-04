-- Entity: adder4 
-- Author: Hazael Magino
-- Created: 9/3/2026
-- Architectural: structural 

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

-- Port definitions for the 4 bit adder to be used in the ALU.
entity adder4 is
    port(
        A_in: in std_logic_vector(3 downto 0);
        B_in: in std_logic_vector(3 downto 0);
        carryI: in std_logic;
        sum_out: out std_logic_vector(3 downto 0);
        carryO: out std_logic
    );
end adder4; 


architecture structural of adder4 is
    -- Componets for the 4 bit adder to be used in the ALU.
    -- adder_1 is a 1 bit adder that will be used to create the 4 bit adder.
    component adder_1
        port(
            input1: in std_logic;
            input2: in std_logic;
            carryI: in std_logic; 
            sum: out std_logic;
            carryO: out std_logic 
        );
    end component;

-- for the 4 bit adder to be used in the ALU, we will use 4 instances of the 1 bit adder to create the 4 bit adder.
for adder0, adder1, adder2, adder3: adder_1 use entity work.adder_1(structural);

-- Signal declarations for the 4 bit adder 
signal carry0, carry1, carry2: std_logic;

    -- The 4 bit adder will use the 1 bit adder to create the 4 bit adder.
    -- The carry out of each 1 bit adder connects to the carry in of the next 1 bit adder. 
    -- The sum out of each 1 bit adder conencts to the sum out of the 4 bit adder. 
    -- The carry out of the last 1 bit adder will be connected to the carry out of the 4 bit adder.
    begin
        adder0: adder_1 port map (A_in(0), B_in(0), carryI, sum_out(0), carry0);
        adder1: adder_1 port map (A_in(1), B_in(1), carry0, sum_out(1), carry1);
        adder2: adder_1 port map (A_in(2), B_in(2), carry1, sum_out(2), carry2);
        adder3: adder_1 port map (A_in(3), B_in(3), carry2, sum_out(3), carryO);

    end structural;