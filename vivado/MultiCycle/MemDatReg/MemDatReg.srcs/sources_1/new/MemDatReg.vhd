----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.10.2025 10:07:57
-- Design Name: 
-- Module Name: MemDatReg - Behavioral
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

entity MemDatReg is
  Port (
    clk       : in  std_logic;
    MemData : in  std_logic_vector(31 downto 0);
    MDROut : out std_logic_vector(31 downto 0)
  );
end MemDatReg;

architecture Behavioral of MemDatReg is
  signal MDR_reg : std_logic_vector(31 downto 0) := (others => '0');
begin
  process(clk)
  begin
    if (clk'event and clk = '1') then
      MDR_reg <= MemData;  -- se actualiza cada ciclo
    end if;
  end process;
  MDROut <= MDR_reg;
end Behavioral;