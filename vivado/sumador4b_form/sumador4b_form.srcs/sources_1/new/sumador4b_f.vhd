----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.08.2025 19:21:38
-- Design Name: 
-- Module Name: sumador4b_f - Behavioral
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

entity sumador4b_f is
    Port (
        A     : in  STD_LOGIC_VECTOR(3 downto 0);
        B     : in  STD_LOGIC_VECTOR(3 downto 0);
        Cin   : in  STD_LOGIC;
        S     : out STD_LOGIC_VECTOR(3 downto 0);
        Cout  : out STD_LOGIC
    );
end sumador4b_f;

architecture Behavioral of sumador4b_f is
    signal C : STD_LOGIC_VECTOR(2 downto 0);
begin
    S(0) <= A(0) XOR B(0) XOR Cin;
    C(0) <= (A(0) AND B(0)) OR ((A(0) XOR B(0)) AND Cin);

    S(1) <= A(1) XOR B(1) XOR C(0);
    C(1) <= (A(1) AND B(1)) OR ((A(1) XOR B(1)) AND C(0));
    
    S(2) <= A(2) XOR B(2) XOR C(1);
    C(2) <= (A(2) AND B(2)) OR ((A(2) XOR B(2)) AND C(1));

    S(3) <= A(3) XOR B(3) XOR C(2);
    Cout <= (A(3) AND B(3)) OR ((A(3) XOR B(3)) AND C(2));

end Behavioral;
