----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.08.2025 19:53:17
-- Design Name: 
-- Module Name: dec7seg - Behavioral
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

entity dec7seg is
    Port (
        Binario: in  STD_LOGIC_VECTOR(3 downto 0);
        Entrada: out  STD_LOGIC_VECTOR(3 downto 0);
        Segmentos: out  STD_LOGIC_VECTOR(6 downto 0)
    );
end dec7seg;

architecture Behavioral of dec7seg is

begin
    Entrada<=Binario;
    with Binario select
        Segmentos <= "0000001" when "0000",
                     "1001111" when "0001",
                     "0010010" when "0010",
                     "0000110" when "0011",
                     "1001100" when "0100",
                     "0100100" when "0101",
                     "0100000" when "0110",
                     "0001111" when "0111",
                     "0000000" when "1000",
                     "0000100" when "1001",
                     "1111111" when others;
end Behavioral;
