----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.10.2025 09:32:29
-- Design Name: 
-- Module Name: ExtSig - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ExtSig is
    Port (
        DataIn  : in  std_logic_vector(15 downto 0);
        DataOut : out std_logic_vector(31 downto 0)
    );
end ExtSig;

architecture Behavioral of ExtSig is
begin
    DataOut <= std_logic_vector(resize(signed(DataIn), 32));
end Behavioral;


