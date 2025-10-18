----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/18/2025 07:17:35 AM
-- Design Name: 
-- Module Name: Esp_JR - Behavioral
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

entity Esp_JR is
   Port ( 
      Opcode : in  std_logic_vector (5 downto 0);
      Funct  : in  std_logic_vector (5 downto 0);
      JROut  : out std_logic
   );
end Esp_JR;

architecture Behavioral of Esp_JR is
begin
   process(Opcode, Funct)
   begin
      if (Opcode = "000000") and (Funct = "001000") then
         JROut <= '1';
      else
         JROut <= '0';
      end if;
   end process;
end Behavioral;
