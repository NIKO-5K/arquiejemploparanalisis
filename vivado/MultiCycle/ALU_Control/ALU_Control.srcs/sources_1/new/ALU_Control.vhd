----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.10.2025 19:01:22
-- Design Name: 
-- Module Name: ALU_Control - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU_Control is
    Port (
        ALUOp    : in  std_logic_vector(2 downto 0);
        Funct    : in  std_logic_vector(5 downto 0);
        Operation: out std_logic_vector(3 downto 0)
    );
end ALU_Control;

architecture Behavioral of ALU_Control is
begin
    process(ALUOp, Funct)
    begin
        case ALUOp is
            when "010" =>
                case Funct is
                    when "100000" => Operation  <= "0010";
                    when "100001" => Operation  <= "0010";
                    when "100010" => Operation  <= "0110";
                    when "100011" => Operation  <= "0110";
                    when "100100" => Operation  <= "0000";
                    when "100101" => Operation  <= "0001";
                    when "100111" => Operation  <= "0011";
                    when "101010" => Operation  <= "0111";
                    when "000000" => Operation  <= "0100";
                    when "000010" => Operation  <= "0101";
                    when "011000" => Operation  <= "1000";
                    when "011010" => Operation  <= "1000";
                    when others   => Operation  <= "1111";
                end case;
            when "000"  => Operation <= "0010"; 
            when "001"  => Operation <= "0110";
            when "011"  => Operation <= "0001"; 
            when "100"  => Operation <= "0000"; 
            when "101"  => Operation <= "0111";  
            when others => Operation <= "1111";         
        end case;
    end process;
end Behavioral;

