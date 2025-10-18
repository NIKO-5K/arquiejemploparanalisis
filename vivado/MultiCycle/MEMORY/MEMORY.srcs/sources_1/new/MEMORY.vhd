----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/18/2025 12:33:12 AM
-- Design Name: 
-- Module Name: MEMORY - Behavioral
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

entity MEMORY is
  Port (
    clk       : in  std_logic;
    Address   : in  std_logic_vector(11 downto 0);   -- índice directo (4096 palabras)
    WriteData : in  std_logic_vector(31 downto 0);
    MemRead   : in  std_logic;
    MemWrite  : in  std_logic;
    ReadData  : out std_logic_vector(31 downto 0)
  );
end MEMORY;

architecture Behavioral of MEMORY is
  constant MEM_SIZE : integer := 4096;

  type memory_array is array(0 to MEM_SIZE-1) of std_logic_vector(31 downto 0);
  signal ROM : memory_array := (others => (others => '0'));

  signal idx : integer range 0 to MEM_SIZE-1;

  constant INSTR_START : integer := 0;
  constant INSTR_END   : integer := 1023;
  constant DATA_START  : integer := 1024;
  constant DATA_END    : integer := MEM_SIZE-1;
begin
  idx <= to_integer(unsigned(address));
  process(clk)
  begin
    if (clk'event and clk = '1') then
      if MemWrite = '1' and idx >= DATA_START and idx <= DATA_END then
          ROM(idx) <= WriteData;
      elsif MemRead = '1' and idx >= DATA_START and idx <= DATA_END then
          ReadData <= ROM(idx);
      end if;
    end if;
  end process;
end Behavioral;
