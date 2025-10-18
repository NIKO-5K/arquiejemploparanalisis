----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/18/2025 01:35:23 AM
-- Design Name: 
-- Module Name: A - Behavioral
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

----------------------------------------------------------------------------------
-- Registro A: Guarda temporalmente ReadData1
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity B is
  Port (
    clk     : in  std_logic;
    DataIn  : in  std_logic_vector(31 downto 0);
    DataOut : out std_logic_vector(31 downto 0)
  );
end B;

architecture Behavioral of B is
  signal B_reg : std_logic_vector(31 downto 0) := (others => '0');
begin
  process(clk)
  begin
    if (clk'event and clk = '1') then
      B_reg <= DataIn;
    end if;
  end process;
  DataOut <= B_reg;
end Behavioral;
