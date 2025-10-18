----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.09.2025 07:41:14
-- Design Name: 
-- Module Name: mux4_1_32b - Behavioral
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

entity mux4_1_32b is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           C : in STD_LOGIC_VECTOR (3 downto 0);
           D : in STD_LOGIC_VECTOR (3 downto 0);
           sel : in STD_LOGIC_VECTOR (1 downto 0);
           muxOut : out STD_LOGIC_VECTOR (3 downto 0));
end mux4_1_32b;

architecture Behavioral of mux4_1_32b is

begin
   process (A, B, C, D, sel)
   begin
--      if (sel ="00") then
--         muxOut <= A;
--      elsif (sel = "01") then
--         muxOut <= B;
--      elsif (sel = "10") then
--         muxOut <= C;
--      else   
--         muxOut <= D;
--      end if;
        case(sel) is
           when "00" =>
              muxOut <= A;
           when "01" =>
              muxOut <= B;
           when "10" =>
              muxOut <= C;
           when others =>
              muxOut <= D;
         end case;
   end process;

end Behavioral;
