----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.08.2025 08:16:39
-- Design Name: 
-- Module Name: mux4_1 - Behavioral
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

entity mux4_1 is
    Port ( 
        Entrada  : in  STD_LOGIC_VECTOR (3 downto 0);
        Sel      : in  STD_LOGIC_VECTOR (1 downto 0);
        Salida   : out STD_LOGIC
    );
end mux4_1;

architecture Behavioral of mux4_1 is
begin
    with Sel select
        Salida <= Entrada(0) when "00",
                  Entrada(1) when "01",
                  Entrada(2) when "10",
                  Entrada(3) when others;
end Behavioral;
