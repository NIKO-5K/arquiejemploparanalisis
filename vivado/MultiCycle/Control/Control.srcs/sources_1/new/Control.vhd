----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.10.2025 10:09:59
-- Design Name: 
-- Module Name: Control - Behavioral
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

entity CONTROL is
  Port (
    clk        : in  std_logic;
    Reset      : in  std_logic;
    Opcode     : in  std_logic_vector(5 downto 0);
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
end CONTROL;

architecture Behavioral of CONTROL is
  signal state         : std_logic_vector(2 downto 0) := (others => '0');
  signal next_state    : std_logic_vector(2 downto 0) := (others => '0');
  signal s_ALUOp       : std_logic_vector(2 downto 0) := (others => '0');
  signal s_ALUSrcA     : std_logic := '0';
  signal s_ALUSrcB     : std_logic_vector(1 downto 0) := (others => '0');
  signal s_MemRead     : std_logic := '0';
  signal s_MemWrite    : std_logic := '0';
  signal s_IorD        : std_logic := '0';
  signal s_IRWrite     : std_logic := '0';
  signal s_PCWrite     : std_logic := '0';
  signal s_PCSrc       : std_logic_vector(1 downto 0) := (others => '0');
  signal s_RegDst      : std_logic_vector(1 downto 0) := (others => '0');
  signal s_MemtoReg    : std_logic_vector(1 downto 0) := (others => '0');
  signal s_RegWrite    : std_logic := '0';
  signal s_Branch      : std_logic := '0';

begin
  ALUOp     <= s_ALUOp;
  ALUSrcA   <= s_ALUSrcA;
  ALUSrcB   <= s_ALUSrcB;
  MemRead   <= s_MemRead;
  MemWrite  <= s_MemWrite;
  IorD      <= s_IorD;
  IRWrite   <= s_IRWrite;
  PCWrite   <= s_PCWrite;
  PCSrc     <= s_PCSrc;
  RegDst    <= s_RegDst;
  MemtoReg  <= s_MemtoReg;
  RegWrite  <= s_RegWrite;
  Branch    <= s_Branch;

  
  process(clk)
  begin
     if (clk'event and clk = '1') then
        if reset = '1' then
           state <= "000";
        else
           state <= next_state;
        end if;
     end if;
  end process;


  -- LÓGICA DE PRÓXIMO ESTADO (FSM)
  process(state, Opcode)
  begin
    next_state <= state;

    case state is
      -- FETCH -> DECODE
      when "000" =>
        next_state <= "001";

      -- DECODE -> EXECUTE
      when "001" =>
        if Opcode = "000010" then
          next_state <= "000";
        else
          next_state <= "010";
        end if;

      -- EXECUTE -> MEMORY
      when "010" =>
        case Opcode is
          when "100011" | "101011" =>
            next_state <= "011";   
          when "000100" =>        
            next_state <= "000";   
          when others =>            
            next_state <= "100";    
        end case;

      -- MEM -> WB
      when "011" =>
        if Opcode = "100011" then   
          next_state <= "100";  
        else                   
          next_state <= "000";  
        end if;

      -- WB -> FETCH
      when "100" =>
        next_state <= "000";

      when others =>
        next_state <= "000";
    end case;
  end process;

  process(state, Opcode)
  begin
    s_ALUOp     <= (others => '0');
    s_ALUSrcA   <= '0';
    s_ALUSrcB   <= "00";
    s_MemRead   <= '0';
    s_MemWrite  <= '0';
    s_IorD      <= '0';
    s_IRWrite   <= '0';
    s_PCWrite   <= '0';
    s_PCSrc     <= "00";
    s_RegDst    <= "00";
    s_MemtoReg  <= "00";
    s_RegWrite  <= '0';
    s_Branch    <= '0';

    case state is
      -- FETCH:
      when "000" =>
        s_MemRead <= '1';
        s_IorD    <= '0'; 
        s_IRWrite <= '1';
        s_ALUSrcA <= '0'; 
        s_ALUSrcB <= "01";
        s_ALUOp   <= "000"; 
        s_PCWrite <= '1';
        s_PCSrc   <= "00";

      -- DECODE:
      when "001" =>
        s_ALUSrcA <= '0';     
        s_ALUSrcB <= "11";    
        s_ALUOp   <= "000";
        if Opcode = "000010" then
          s_PCWrite <= '1';
          s_PCSrc   <= "10";
        end if;

      -- EXECUTE:
      when "010" =>
        case Opcode is
          -- R-type
          when "000000" =>
            s_ALUSrcA <= '1';
            s_ALUSrcB <= "00";  
            s_ALUOp   <= "010"; 

          when "001000" | "001001" =>
            s_ALUSrcA <= '1'; 
            s_ALUSrcB <= "10"; 
            s_ALUOp   <= "000";

          when "001010" =>
            s_ALUSrcA <= '1';
            s_ALUSrcB <= "10";
            s_ALUOp   <= "101";

          when "100011" | "101011" =>
            s_ALUSrcA <= '1';
            s_ALUSrcB <= "10";
            s_ALUOp   <= "000"; 

          when "000100" =>
            s_ALUSrcA <= '1'; 
            s_ALUSrcB <= "00"; 
            s_ALUOp   <= "001";
            s_Branch  <= '1';
            s_PCSrc   <= "01"; 

          when "001101" =>
            s_ALUSrcA <= '1';
            s_ALUSrcB <= "10";
            s_ALUOp   <= "011";

          when "001100" =>
            s_ALUSrcA <= '1';
            s_ALUSrcB <= "10";
            s_ALUOp   <= "100";

          when others =>
            null;
        end case;

      -- MEM:
      when "011" =>
        case Opcode is
          when "100011" =>       
            s_IorD    <= '1';  
            s_MemRead <= '1';
          when "101011" =>    
            s_IorD     <= '1';
            s_MemWrite <= '1';
          when others =>
            null;
        end case;

      -- WB:
      when "100" =>
        case Opcode is
          when "000000" =>        
            s_RegDst   <= "01"; 
            s_MemtoReg <= "00"; 
            s_RegWrite <= '1';
          when "100011" =>       
            s_RegDst   <= "00"; 
            s_MemtoReg <= "01"; 
            s_RegWrite <= '1';
          when "001000" | "001001" | "001101" | "001100" | "001010" =>
            s_RegDst   <= "00"; 
            s_MemtoReg <= "00";  
            s_RegWrite <= '1';
          when others =>
            null;
        end case;

      when others =>
        null;
    end case;
  end process;

end Behavioral;