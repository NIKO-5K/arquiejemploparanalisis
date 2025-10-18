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

entity sumador4b is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Cin : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (3 downto 0);
           Cout : out STD_LOGIC
           );
end sumador4b;

architecture Behavioral of sumador4b is
component sumador1b
  Port ( A : in STD_LOGIC;
         B : in STD_LOGIC;
         Cin : in STD_LOGIC;
         Cout : out STD_LOGIC;
         S : out STD_LOGIC
         );
end component;

signal carry1 : STD_LOGIC;
signal carry2 : STD_LOGIC;
signal carry3 : STD_LOGIC;

begin
   u0 : sumador1b
   port map (
      A => A(0),
      B => B(0),
      Cin => Cin,
      S => S(0),
      Cout => carry1
      );

   u1 : sumador1b
   port map (
      A => A(1),
      B => B(1),
      Cin => carry1,
      S => S(1),
      Cout => carry2
      );

   u2 : sumador1b
   port map (
      A => A(2),
      B => B(2),
      Cin => carry2,
      S => S(2),
      Cout => carry3
      );
    
   u3 : sumador1b
   port map (
      A => A(3),
      B => B(3),
      Cin => carry3,
      S => S(3),
      Cout => Cout
      );

end Behavioral;