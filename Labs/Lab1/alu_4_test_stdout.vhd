-- Testbench: alu_4_test_stdout
-- Author: Hazael Magino
-- Structure: Behavioral 
-- Date: 9/5/2026

library IEEE;
library STD;
use ieee.std_logic_1164.all;
use STD.textio.all; 
use ieee.std_logic_textio.all; -- library for textio to be used in the testbench to support the write operations and print_result procedure and to print the results of the ALU operation to the console.

--References for file io: https://nandland.com/file-input-output/
--References for testbench basics: https://www.fpgatutorial.com/how-to-write-a-basic-testbench-using-vhdl/

-- Testbench for the 4 bit ALU to test the operations specified in the assignment document.
entity alu_4_test_stdout is
end alu_4_test_stdout;

architecture behavioral  of alu_4_test_stdout is

    -- Component declaration for the ALU to be tested in this testbench.
    component alu_4
        port(
            A: in std_logic_vector(3 downto 0);
            B: in std_logic_vector(3 downto 0);
            Cin: in std_logic;
            S0: in std_logic;
            S1: in std_logic;
            G: out std_logic_vector(3 downto 0);
            Cout: out std_logic
        );
    end component; 

    for DUT : alu_4 use entity work.alu_4(Structural); -- -- bind DUT to the compiled alu_4 

    signal r_A: std_logic_vector(3 downto 0); -- read signal for input A
    signal r_B: std_logic_vector(3 downto 0); -- read signal for input B
    signal w_G: std_logic_vector(3 downto 0); -- read signal for output G
    signal r_Cin: std_logic; -- read signal for input Cin
    signal r_S0: std_logic; -- read signal for input S0
    signal r_S1: std_logic; -- read signal for input S1
    signal w_Cout: std_logic; -- read signal for output Cout

    begin

        DUT: alu_4 
        port map(
            A => r_A, -- map the input A to the read signal r_A
            B => r_B, -- map the input B to the read signal r_B
            Cin => r_Cin, -- map the input Cin to the read signal r_Cin
            S0 => r_S0, -- map the input S0 to the read signal r_S0
            S1 => r_S1, -- map the input S1 to the read signal r_S1
            G => w_G, -- map the output G to the read signal w_G
            Cout => w_Cout); -- map the output Cout to the read signal w_Cout
        
        process 
            variable v_OLINE: line; -- variable for output line to be used in the print_result procedure
                procedure print_result(msg: string) is -- procedure to print the results of the ALU operation to the console

                    begin
                        write(v_OLINE, msg);
                        write(v_OLINE, string'(" A=")); write(v_OLINE, r_A);
                        write(v_OLINE, string'(" B=")); write(v_OLINE, r_B);
                        write(v_OLINE, string'(" Cin=")); write(v_OLINE, r_Cin);
                        write(v_OLINE, string'(" G=")); write(v_OLINE, w_G);
                        write(v_OLINE, string'(" Cout="));  write(v_OLINE, w_Cout);
                        writeline(output, v_OLINE);
                end;

            begin

                r_A <= "0011"; -- A = 3
                r_B <= "0101"; -- B = 5
                
                -- Transfer operation inputs and outputs to the ALU
                r_S0 <= '0';
                r_S1 <= '0';
                r_Cin <='0';
                wait for 10 ns;
                print_result("S1S0= 00 (transfer)");
                
                -- Increment operation inputs and outputs to the ALU
                r_S0 <= '0';
                r_S1 <= '0';
                r_Cin <='1';
                wait for 10 ns;
                print_result("S1S0= 00 (increment)");

                -- Add operation inputs and outputs to the ALU
                r_S0 <= '1';
                r_S1 <= '0';
                r_Cin <='0';
                wait for 10 ns;
                print_result("S1S0= 01 (add)");

                -- Add + 1 operation inputs and outputs to the ALU
                r_S0 <= '1';
                r_S1 <= '0';
                r_Cin <='1';
                wait for 10 ns;
                print_result("S1S0= 01 (add+1)");

                -- Add + ~B operation inputs and outputs to the ALU
                r_S0 <= '0';
                r_S1 <= '1';
                r_Cin <='0';
                wait for 10 ns;
                print_result("S1S0= 10 (add+~B)");

                -- Subtract operation inputs and outputs to the ALU
                r_S0 <= '0';
                r_S1 <= '1';
                r_Cin <='1';
                wait for 10 ns;
                print_result("S1S0= 10 (subtract)");
                
                -- Decrement operation inputs and outputs to the ALU
                r_S0 <= '1';
                r_S1 <= '1';
                r_Cin <='0';
                wait for 10 ns;
                print_result("S1S0= 11 (decrement)");

                -- Transfer operation inputs and outputs to the ALU
                r_S0 <= '1';
                r_S1 <= '1';
                r_Cin <='1';
                wait for 10 ns;
                print_result("S1S0= 11 (transfer)");

        wait;               
        end process;
                
end behavioral;