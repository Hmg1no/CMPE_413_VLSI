-- Testbench: alu_4_test
-- Author: Hazael Magino
-- Structure: Behavioral
-- Date: 9/5/2026

library IEEE;
library STD;
use IEEE.std_logic_1164.all;
use STD.textio.all;
use IEEE.std_logic_textio.all; -- library for textio to be used in the testbench to support the write operations and print_result procedure and to print the results of the ALU operation to the console.

--References for file io: https://nandland.com/file-input-output/
--References for testbench basics: https://www.fpgatutorial.com/how-to-write-a-basic-testbench-using-vhdl/

entity alu_4_test_fileIO is
end alu_4_test_fileIO;

architecture behavioral of alu_4_test_fileIO is

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

    for DUT : alu_4 use entity work.alu_4(Structural); -- bind DUT to the compiled alu_4 
    
    file file_VECTORS: text is in "alu_4_in.txt"; -- input file for the ALU testbench (VHDL-87 standard)
    file file_RESULTS: text is in "alu_4_out.txt"; -- output file for the ALU testbench (VHDL-87 standard)

    signal r_A: std_logic_vector(3 downto 0); -- read signal for input A
    signal r_B: std_logic_vector(3 downto 0); -- read signal for input B
    signal w_G: std_logic_vector(3 downto 0); -- read signal for output G
    signal r_Cin: std_logic; -- read signal for input Cin
    signal r_S0: std_logic; -- read signal for input S0
    signal r_S1: std_logic; -- read signal for input S1
    signal w_Cout: std_logic; -- read signal for output Cout

begin

    DUT : alu_4
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
        variable v_ILINE: line; -- variable for input line to be used in the read_input procedure
        variable v_A: std_logic_vector(3 downto 0); -- variable for input A to be used in the read_input procedure
        variable v_B: std_logic_vector(3 downto 0); -- variable for
        variable v_Cin: std_logic; -- variable for input Cin to be used in the read_input procedure
        variable v_S0: std_logic; -- variable for input S0 to be used in the read_input procedure
        variable v_S1: std_logic; -- variable for input S1 to be used in
        variable V_space: character; -- variable for space to be used in the read_input procedure
    
        begin

            file_open(file_VECTORS, "alu_4_in.txt", read_mode); -- open the input file for reading
            file_open(file_RESULTS, "alu_4_out.txt", write_mode); -- open the output file for writing

            while not endfile(file_VECTORS) loop 
            
                -- Read the input file and assign the values to the variables to be used in the ALU operation.
                readline(file_VECTORS, v_ILINE); 
                read(v_ILINE, v_A); 
                read(v_ILINE, V_space); 
                read(v_ILINE, v_B);
                read(v_ILINE, V_space); 
                read(v_ILINE, v_Cin); 
                read(v_ILINE, V_space); 
                read(v_ILINE, v_S0); 
                read(v_ILINE, V_space); 
                read(v_ILINE, v_S1); 

                -- Pass the variables to the following signals so the ALU can perform the operation specified in the input file.(stimulus)
                r_A <= v_A;
                r_B <= v_B; 
                r_Cin <= v_Cin; 
                r_S0 <= v_S0; 
                r_S1 <= v_S1; 

                wait for 10 ns; -- wait for 10 ns to allow the ALU to perform the operation

                -- Write the results of the ALU operation to the output file
                write(v_OLINE, w_G); -- write the output G to the output line
                write(v_OLINE, string'(" ")); -- space for formatting 
                write(v_OLINE, w_COUT); -- write the output Cout to the output line
                write(v_OLINE, string'(" ")); 
                writeline(file_RESULTS, v_OLINE); -- write the output line to the output file
            end loop;
        -- Close the input and output files after the simulation is done
        file_close(file_VECTORS); 
        file_close(file_RESULTS); 
        
    wait;               
    end process;

end behavioral; 