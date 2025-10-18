----------------------------------------------------------------------------------

-- Company: 

-- Engineer:

-- 

-- Create Date: 13.09.2025 07:13:12

-- Design Name: 

-- Module Name: div_f1 - Behavioral

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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CLK is
    Port (
        clk   : in  STD_LOGIC;
        Reset : in  STD_LOGIC;
        Frec  : in  STD_LOGIC_VECTOR(31 downto 0);
        CLKOut: out STD_LOGIC
    );
end CLK;

architecture Behavioral of CLK is
    signal data_out : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
begin
    process(clk, Reset)
    begin
        if Reset = '1' then
            data_out <= (others => '0');
            CLKOut <= '0';
        elsif clk'event and clk = '1' then
            if data_out = Frec then
                data_out <= (others => '0');
                CLKOut <= '1';
            else
                data_out <= data_out + 1;
                CLKOut <= '0';
            end if;
        end if;
    end process;
end Behavioral;
