----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/18/2025 01:18:04 AM
-- Design Name: 
-- Module Name: REGISTERS - Behavioral
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

entity REGISTERS is
  Port (
    clk         : in  std_logic;
    RegWrite    : in  std_logic;
    ReadReg1    : in  std_logic_vector(4 downto 0);
    ReadReg2    : in  std_logic_vector(4 downto 0);
    WriteReg    : in  std_logic_vector(4 downto 0);
    WriteData   : in  std_logic_vector(31 downto 0);
    ReadData1   : out std_logic_vector(31 downto 0);
    ReadData2   : out std_logic_vector(31 downto 0)
  );
end REGISTERS;

architecture Behavioral of REGISTERS is
  type reg_array is array (0 to 31) of std_logic_vector(31 downto 0);
  signal RF : reg_array := (others => (others => '0'));
begin
  ReadData1 <= RF(to_integer(unsigned(ReadReg1)));
  ReadData2 <= RF(to_integer(unsigned(ReadReg2)));
  process(clk)
  begin
    if (clk'event and clk = '1') then
      if (RegWrite = '1') then
        if (WriteReg /= "00000") then  -- R0 siempre es 0
          RF(to_integer(unsigned(WriteReg))) <= WriteData;
        end if;
      end if;
    end if;
  end process;

end Behavioral;
