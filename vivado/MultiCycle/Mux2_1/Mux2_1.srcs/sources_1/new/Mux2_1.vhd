----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.10.2025 09:51:35
-- Design Name: 
-- Module Name: Mux2_1 - Behavioral
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

entity MUX2_1 is
    generic (
        N : integer := 8  -- Ancho por defecto (8 bits)
    );
    port (
        DataIn0   : in  std_logic_vector(N-1 downto 0);
        DataIn1   : in  std_logic_vector(N-1 downto 0);
        Sel       : in  std_logic;
        DataOut21 : out std_logic_vector(N-1 downto 0)
    );
end MUX2_1;

architecture Behavioral of MUX2_1 is
begin
    process(DataIn0, DataIn1, Sel)
    begin
        if Sel = '0' then
            DataOut21 <= DataIn0;
        else
            DataOut21 <= DataIn1;
        end if;
    end process;
end Behavioral;

