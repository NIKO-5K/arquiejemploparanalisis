----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.08.2025 07:28:06
-- Design Name: 
-- Module Name: sumador1b - Behavioral
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


entity sumador1b is
  Port ( A : in STD_LOGIC;
         B : in STD_LOGIC;
         Cin : in STD_LOGIC;
         Cout : out STD_LOGIC;
         S : out STD_LOGIC
         );
end sumador1b;

architecture Behavioral of sumador1b is

begin
S <= A XOR B XOR Cin;
Cout <= (A AND B) OR ((A XOR B) AND Cin);

end Behavioral;

