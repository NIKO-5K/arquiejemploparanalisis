----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/18/2025 08:03:49 AM
-- Design Name: 
-- Module Name: Arquitectura - Behavioral
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

entity Arquitectura is
   Port ( clkp : std_logic);
end Arquitectura;

architecture Behavioral of Arquitectura is
component CLK is
    Port (
        clk   : in  STD_LOGIC;
        Reset : in  STD_LOGIC;
        Frec  : in  STD_LOGIC_VECTOR(31 downto 0);
        CLKOut: out STD_LOGIC
    );
end component;

component PC is
    Port (
        clk       : in  STD_LOGIC;
        PCWrite   : in  STD_LOGIC;
        Branch    : in  STD_LOGIC;
        Zero      : in  STD_LOGIC;
        Esp_JR    : in  STD_LOGIC;
        PC_in     : in  STD_LOGIC_VECTOR(31 downto 0);
        PC_out    : out STD_LOGIC_VECTOR(31 downto 0)
    );
end component;

component MEMORY is
  Port (
    clk       : in  std_logic;
    Address   : in  std_logic_vector(11 downto 0);   -- índice directo (4096 palabras)
    WriteData : in  std_logic_vector(31 downto 0);
    MemRead   : in  std_logic;
    MemWrite  : in  std_logic;
    ReadData  : out std_logic_vector(31 downto 0)
  );
end component;

component InstReg is
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
end component;

component MemDatReg is
  Port (
    clk       : in  std_logic;
    MemData : in  std_logic_vector(31 downto 0);
    MDROut : out std_logic_vector(31 downto 0)
  );
end component;

component REGISTERS is
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
end component;

component A is
  Port (
    clk     : in  std_logic;
    DataIn  : in  std_logic_vector(31 downto 0);
    DataOut : out std_logic_vector(31 downto 0)
  );
end component;

component B is
  Port (
    clk     : in  std_logic;
    DataIn  : in  std_logic_vector(31 downto 0);
    DataOut : out std_logic_vector(31 downto 0)
  );
end component;

component ALU_Control is
    Port (
        ALUOp    : in  std_logic_vector(2 downto 0);
        Funct    : in  std_logic_vector(5 downto 0);
        Operation: out std_logic_vector(3 downto 0)
    );
end component;

component ALU is
    Port (
        A           : in  std_logic_vector(31 downto 0);
        B           : in  std_logic_vector(31 downto 0);
        Operation   : in  std_logic_vector(3 downto 0);
        ALUResult   : out std_logic_vector(31 downto 0);
        Zero        : out std_logic
    );
end component;

component ALUOut is
    Port (
        Clk       : in  std_logic;
        ALUResult : in  std_logic_vector(31 downto 0);
        DataOut    : out std_logic_vector(31 downto 0)
    );
end component;

component MUX2_1 is
    generic (
        N : integer := 8  -- Ancho por defecto (8 bits)
    );
    port (
        DataIn0   : in  std_logic_vector(N-1 downto 0);
        DataIn1   : in  std_logic_vector(N-1 downto 0);
        Sel       : in  std_logic;
        DataOut21 : out std_logic_vector(N-1 downto 0)
    );
end component;

component MUX4_1 is
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
end component;

component Esp_JR is
   Port ( 
      Opcode : in  std_logic_vector (5 downto 0);
      Funct  : in  std_logic_vector (5 downto 0);
      JROut  : out std_logic
   );
end component;

component ExtSig is
    Port (
        DataIn  : in  std_logic_vector(15 downto 0);
        DataOut : out std_logic_vector(31 downto 0)
    );
end component;

component CONTROL is
  Port (
    clk        : in  std_logic;
    opcode     : in  std_logic_vector(5 downto 0);
    ALUOp      : out std_logic_vector(2 downto 0);
    ALUSrcA    : out std_logic;
    ALUSrcB    : out std_logic_vector(1 downto 0);
    MemRead    : out std_logic;
    MemWrite   : out std_logic;
    IorD       : out std_logic;
    IRWrite    : out std_logic;
    PCWrite    : out std_logic;
    PCSrc      : out std_logic_vector(1 downto 0);
    RegDst     : out std_logic_vector(1 downto 0);
    MemtoReg   : out std_logic_vector(1 downto 0);
    RegWrite   : out std_logic;
    Branch     : out std_logic
  );
end component;

begin


end Behavioral;
