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

entity MUX4_1 is
    generic (
        N : integer := 32
    );
    port (
        DataIn0   : in  std_logic_vector(N-1 downto 0);
        DataIn1   : in  std_logic_vector(N-1 downto 0);
        DataIn2   : in  std_logic_vector(N-1 downto 0);
        DataIn3   : in  std_logic_vector(N-1 downto 0);
        Sel       : in  std_logic_vector(1 downto 0);
        DataOut41 : out std_logic_vector(N-1 downto 0)
    );
end MUX4_1;

architecture Behavioral of MUX4_1 is
begin
    process(DataIn0, DataIn1, DataIn2, DataIn3, Sel)
    begin
        case Sel is
            when "00" => DataOut41 <= DataIn0;
            when "01" => DataOut41 <= DataIn1;
            when "10" => DataOut41 <= DataIn2;
            when "11" => DataOut41 <= DataIn3;
            when others => DataOut41 <= (others => '0');
        end case;
    end process;
end Behavioral;