----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.10.2025 10:13:37
-- Design Name: 
-- Module Name: PC - Behavioral
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


----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.10.2025
-- Design Name: Multicycle Processor - PC (Versión didáctica)
-- Module Name: PC - Behavioral
-- Description:
--  Implementa el contador de programa (PC) del procesador multiciclo de Patterson.
--  Usa lógica combinacional simple, tal como en clase: 
--  Actualiza el PC según PCWrite, Branch, Zero, y condiciones especiales (0x00, 0x08).
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PC is
    Port (
        clk       : in  STD_LOGIC;
        PCWrite   : in  STD_LOGIC;
        Branch    : in  STD_LOGIC;
        Zero      : in  STD_LOGIC;
        Esp_JR    : in  STD_LOGIC;
        PC_in     : in  STD_LOGIC_VECTOR(31 downto 0);
        PC_out    : out STD_LOGIC_VECTOR(31 downto 0)
    );
end PC;
architecture Behavioral of PC is
    signal PC_reg   : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal enable   : STD_LOGIC;
begin
    process(clk)
    begin
        if (clk'event and clk = '1') then
            if (PCWrite = '1') or ((Branch = '1') and (Zero = '1')) or (Esp_JR ='1') then
                PC_reg <= PC_in;
            end if;
        end if;
    end process;
    PC_out <= PC_reg;
end Behavioral;