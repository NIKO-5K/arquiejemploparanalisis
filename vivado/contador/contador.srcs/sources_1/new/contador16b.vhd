----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.09.2025 08:42:34
-- Design Name: 
-- Module Name: contador16b - Behavioral
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity contador16b is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           count : out STD_LOGIC_VECTOR (15 downto 0));
end contador16b;

architecture Behavioral of contador16b is
   signal data_in, data_out: std_logic_vector (31 downto 0);
begin
   process (clk, reset)
   begin 
       if (reset = '1') then
          data_out <= X"00000000";
       elsif (clk'event and clk = '1') then
          data_out <= data_in;
       end if;
   end process;
   data_in <= data_out + 1;
   count <= data_out(31 downto 16);
end Behavioral;
