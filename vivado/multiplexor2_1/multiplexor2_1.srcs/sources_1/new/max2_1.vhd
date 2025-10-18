----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.08.2025 07:58:59
-- Design Name: 
-- Module Name: max2_1 - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;

entity mux2_1 is
    port (
        A : in std_logic;
        B : in std_logic;
        Sel : in std_logic;
        Salida : out std_logic
    );
end entity mux2_1;

architecture behavioral of mux2_1 is
begin
    process(A, B, Sel)
    begin
        if Sel = '0' then
            Salida <= A;
        else
            Salida <= B;
        end if;
    end process;
end architecture behavioral;
