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

entity div_f1 is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           count : out STD_LOGIC);
end div_f1;
architecture Behavioral of div_f1 is
       signal data_in, data_out: std_logic_vector (31 downto 0);
begin
    process (clk, reset)
    begin
        if (reset = '1') then
            data_out <= X"00000000";
        elsif (clk'event and clk = '1') then
            if (data_out = X"05F5E100") then
                data_out <= X"00000000";
                count <= '1';
            else
                data_out <= data_in;
                count <= '0';
            end if;
        end if;
    end process;
    data_in <= data_out + 1;
end Behavioral;