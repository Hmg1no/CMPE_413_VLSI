-- Entity: alu_4
-- Author: Hazael Magino
-- Date: 9/4/2026
-- Structure: structural 

library STD;
library IEEE; 
use IEEE.std_logic_1164.all;

-- Port declartions per assignment instructions
entity alu_4 is
    port(
        A : in std_logic_vector(3 downto 0);
        B: in std_logic_vector(3 downto 0);
        Cin: in std_logic;
        S0: in std_logic; 
        S1: in std_logic;
        G: out std_logic_vector(3 downto 0);
        Cout: out std_logic
    );
end alu_4;

-- Port hieracrchy component declarations for the ALU to perform the operations specified in document
architecture structural of alu_4 is

    -- Components for ALU 
    component adder4
        port(
            A_in: in std_logic_vector(3 downto 0);
            B_in: in std_logic_vector(3 downto 0);
            carryI: in std_logic;
            sum_out: out std_logic_vector(3 downto 0);
            carryO: out std_logic
        );
    end component;

    --Y select component to select the correct bit of the 4 bit input to be sent to the adder4 component.
    component ybit_select
        port(
            Bin: in std_logic_vector(3 downto 0);
            s0_in: in std_logic;
            s1_in: in std_logic; 
            Y_out: out std_logic_vector(3 downto 0)
        );
    end component; 
    
    -- Y output internal signal to be sent to the adder4 component for the ALU operation.
    signal Y: std_logic_vector(3 downto 0); 

    begin
        --ALU signal inputs and outputs to the ybit_select and adder4 components to perform the ALU operations specified in the assignment document.
        Y_select: ybit_select port map(B, S0, S1, Y);
        alu_op: adder4 port map(A_in, Y, carryI, G, Cout);
    end structural; 

