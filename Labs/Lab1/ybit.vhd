-- Entity: Ybit
-- Architectural: structural 
-- Author: Hazael Magino
-- Created: 9/1/2026

library STD; 
library IEEE; 
use IEEE.std_logic_1164.all;

entity ybit is
    
    port(
        S1: in std_logic;
        S0: in std_logic;
        B: in std_logic;
        ySel: out std_logic 
    );

end ybit; 

architecture structural of ybit is

    component and3

        port(
            input1: in std_logic;
            input2: in std_logic;
            input3: in std_logic;
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

    component or3 

        port(
            input1: in std_logic; 
            input2: in std_logic;
            input3: in std_logic;
            output: out std_logic 
        );
    
    end component;

    component inverter
        port(
            input: in std_logic;
            output: out std_logic
        );
    
    end component;


-- Port Mappings

    signal nS1s0b, s1Ns0Nb, s0s1, nS0, nS1, nB : std_logic;

    -- nS1s0b: ~s1 & s0 and b
    -- s1Ns0Nb: s1 & ~s0 and ~b
    -- s0s1: s0 & s1
    -- nS0: ~s0
    -- nS1: ~s1
    -- nB: ~b

    begin

    inv_1: inverter port map (S0,nS0);
    inv_2: inverter port map (S1,nS1);
    inv_3: inverter port map (B,nB);

    and_1: and3 port map (nS1,S0,B,nS1s0b);
    and_2: and3 port map (S1,nS0,nB,s1Ns0Nb);
    and_3: and2 port map (S1, S0, s0s1); 

    or_1: or3 port map (nS1s0b,s1Ns0Nb,s0s1,ySel);

    end structural; 
