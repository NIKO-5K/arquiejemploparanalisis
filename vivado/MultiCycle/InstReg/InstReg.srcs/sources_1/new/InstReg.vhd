----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.10.2025 10:06:18
-- Design Name: 
-- Module Name: InstReg - Behavioral
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

entity InstReg is
  Port (
    clk        : in  std_logic;
    IRWrite    : in  std_logic;
    MemData    : in  std_logic_vector(31 downto 0);
    Instruction: out std_logic_vector(31 downto 0);
    Opcode     : out std_logic_vector(5 downto 0);
    Rs         : out std_logic_vector(4 downto 0);
    Rt         : out std_logic_vector(4 downto 0);
    Rd         : out std_logic_vector(4 downto 0);
    Funct      : out std_logic_vector(5 downto 0);
    Immediate  : out std_logic_vector(15 downto 0)
  );
end InstReg;

architecture Behavioral of InstReg is
  signal reg_instr : std_logic_vector(31 downto 0) := (others => '0');
begin
  process(clk)
  begin
    if (clk'event and clk = '1') then
      if (IRWrite = '1') then
        reg_instr <= MemData;
      end if;
    end if;
  end process;

  -- Salida completa de la instrucción
  Instruction <= reg_instr;

  -- Separación de campos MIPS
  Opcode    <= reg_instr(31 downto 26);
  Rs        <= reg_instr(25 downto 21);
  Rt        <= reg_instr(20 downto 16);
  Rd        <= reg_instr(15 downto 11);
  Immediate <= reg_instr(15 downto 0);
  Funct     <= reg_instr(5 downto 0);
end Behavioral;
