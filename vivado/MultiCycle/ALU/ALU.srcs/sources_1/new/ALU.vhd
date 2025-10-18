----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.10.2025 10:08:54
-- Design Name: 
-- Module Name: ALU - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    Port (
        A           : in  std_logic_vector(31 downto 0);
        B           : in  std_logic_vector(31 downto 0);
        Operation   : in  std_logic_vector(3 downto 0);
        ALUResult   : out std_logic_vector(31 downto 0);
        Zero        : out std_logic
    );
end ALU;

architecture Behavioral of ALU is
    signal result : std_logic_vector(31 downto 0);
begin
    process(A, B, Operation)
        variable temp_signedA, temp_signedB : signed(31 downto 0);
        variable temp_unsignedA, temp_unsignedB : unsigned(31 downto 0);
        variable temp_mult, temp_div : signed(63 downto 0);
    begin
        temp_signedA   := signed(A);
        temp_signedB   := signed(B);
        temp_unsignedA := unsigned(A);
        temp_unsignedB := unsigned(B);

        case Operation is
            when "0000" => result <= A and B;        
            when "0001" => result <= A or B;         
            when "0011" => result <= not (A or B);  
            when "0010" => result <= std_logic_vector(temp_signedA + temp_signedB);
            when "0110" => result <= std_logic_vector(temp_signedA - temp_signedB);
            when "0111" =>
                if temp_signedA < temp_signedB then
                    result <= (31 downto 1 => '0') & '1';
                else
                    result <= (others => '0');
                end if;
            when "0100" => -- SLL
                result <= std_logic_vector(shift_left(unsigned(B), to_integer(unsigned(A(4 downto 0)))));
            when "0101" => -- SRL
                result <= std_logic_vector(shift_right(unsigned(B), to_integer(unsigned(A(4 downto 0)))));
            when "1000" => -- MULT
                temp_mult := temp_signedA * temp_signedB;
                result <= std_logic_vector(temp_mult(31 downto 0));
            when "1001" => -- DIV
                if temp_signedB /= 0 then
                    result <= std_logic_vector(temp_signedA / temp_signedB);
                else
                    result <= (others => '0');
                end if;
            when others =>
                result <= (others => '0');

        end case;
    end process;
    ALUResult <= result;
    Zero <= '1' when result = x"00000000" else '0';
end Behavioral;
