----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.10.2025 10:12:19
-- Design Name: 
-- Module Name: ALUOut - Behavioral
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

entity ALUOut is
    Port (
        Clk       : in  std_logic;
        ALUResult : in  std_logic_vector(31 downto 0);
        DataOut    : out std_logic_vector(31 downto 0)
    );
end ALUOut;

architecture Behavioral of ALUOut is
    signal temp : std_logic_vector(31 downto 0);
begin
    process(Clk)
    begin
        if (clk'event and clk = '1') then
            temp <= ALUResult;
        end if;
    end process;
    DataOut <= temp;
end Behavioral;
