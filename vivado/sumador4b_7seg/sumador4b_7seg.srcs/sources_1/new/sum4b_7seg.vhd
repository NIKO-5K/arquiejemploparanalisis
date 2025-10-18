----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.08.2025 07:27:50
-- Design Name: 
-- Module Name: sum4bdec - Behavioral
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

entity sum4b_7seg is
    Port ( clk    : in STD_LOGIC;
           reset  : in STD_LOGIC;
           A      : in  STD_LOGIC_VECTOR(3 downto 0);
           B      : in  STD_LOGIC_VECTOR(3 downto 0);
           Display: out  STD_LOGIC_VECTOR(6 downto 0);
           an     : out std_logic_vector (3 downto 0)
           );
end sum4b_7seg;
    
architecture Behavioral of sum4b_7seg is
      signal S  : STD_LOGIC_VECTOR(4 downto 0);
      signal C  : STD_LOGIC_VECTOR(2 downto 0);
      signal CC : STD_LOGIC_VECTOR(2 downto 0);
      signal U  : std_logic_vector (3 downto 0);
      signal D  : std_logic_vector (3 downto 0);
      
      signal data_in, data_out: std_logic_vector (31 downto 0);
      signal pulso: std_logic;
      signal selector : std_logic_vector (1 downto 0);
      
      signal numero      : std_logic_vector (3 downto 0);
begin
    S(0) <= A(0) XOR B(0);
    C(0) <= (A(0) AND B(0));
    
    S(1) <= A(1) XOR B(1) XOR C(0);
    C(1) <= (A(1) AND B(1)) OR ((A(1) XOR B(1)) AND C(0));
 
    S(2) <= A(2) XOR B(2) XOR C(1);
    C(2) <= (A(2) AND B(2)) OR ((A(2) XOR B(2)) AND C(1));

    S(3) <= A(3) XOR B(3) XOR C(2);
    S(4) <= (A(3) AND B(3)) OR ((A(3) XOR B(3)) AND C(2));
   
   
   process(S,CC)
   begin
       if S < "01010" then  -- Cuando la suma sea inferior a 10
           D <= "0000";

           U(0) <= S(0);
           U(1) <= S(1);
           U(2) <= S(2);
           U(3) <= S(3);

       elsif S > "01010" and S < "10100" then  -- Cuando la suma es superior a 9 e inferior a 20
           D <= "0001";

           U(0) <= S(0);
           U(1) <= S(1) xor '1';
           CC(1) <= S(1) and '1';
           U(2) <= S(2) xor '1' xor CC(1);
           CC(2) <= (S(2) and '1') or ((S(2) xor '1') and CC(1));
           U(3) <= S(3) xor CC(2);
       elsif S > "10011" and S < "11110" then  -- Cuando la suma es mayor a 19 e inferior a 30
           D <= "0010";

           U(0) <= S(0);
           U(1) <= S(1);
           U(2) <= S(2) xor '1';
           CC(2) <=(S(2) and '1');
           U(3) <= S(3) XOR '1' XOR CC(2);

       elsif S > "11101" then  -- Cuando la suma es superior a 29 
           D <= "0011";
           U(0) <= S(0);
           U(1) <= S(1) xor '1';
           CC(1) <= S(1) and B(1);
           U(2) <= S(2) xor CC(1);
           CC(2) <= S(2) and CC(1);
           U(3) <= S(3) xor CC(2);
       end if;
   end process;
    
    process (clk, reset)
    begin
        if (reset = '1') then
            data_out <= X"00000000";
            selector<="00";
        elsif (clk'event and clk = '1') then
            if (data_out = X"00065B9B") then    
--             X"000CB735"
                data_out <= X"00000000";
                selector <= selector + '1';
            else
                data_out <= data_in;
            end if;
        end if;
   end process;
   data_in <= data_out + 1;
    
       
    with selector select
           numero<= "0000" when "00",
                D when "01",
                U when "10",
                "0000" when others;
    
    with selector select
           an<= "1111" when "00",
                "1011" when "01",
                "1101" when "10",
                "1111" when others;
                
    with numero select   
           Display <="0000001" when "0000",
                     "1001111" when "0001",
                     "0010010" when "0010",
                     "0000110" when "0011",
                     "1001100" when "0100",
                     "0100100" when "0101",
                     "0100000" when "0110",
                     "0001111" when "0111",
                     "0000000" when "1000",
                     "0000100" when "1001",
                     "1111111" when others;
end Behavioral;