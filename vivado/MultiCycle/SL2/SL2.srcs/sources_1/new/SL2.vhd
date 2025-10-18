----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/18/2025 02:18:17 AM
-- Design Name: 
-- Module Name: SL2 - Behavioral
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

entity SL2 is
    Port (
        DataIn  : in  std_logic_vector(31 downto 0);
        DataOut : out std_logic_vector(31 downto 0)
    );
end SL2;

architecture Behavioral of SL2 is
begin
    DataOut <= std_logic_vector(shift_left(unsigned(DataIn), 2));
end Behavioral;
