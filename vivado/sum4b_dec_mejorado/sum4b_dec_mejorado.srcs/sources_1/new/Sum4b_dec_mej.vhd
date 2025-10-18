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

entity sum4bdec_mej is
    Port ( clk    : in STD_LOGIC;
           reset  : in STD_LOGIC;
           sum    : in STD_LOGIC;
           A      : in  STD_LOGIC_VECTOR(3 downto 0);
           B      : in  STD_LOGIC_VECTOR(3 downto 0);
           Display: out  STD_LOGIC_VECTOR(6 downto 0);
           an     : out std_logic_vector (3 downto 0)
           );
end sum4bdec_mej;
    
architecture Behavioral of sum4bdec_mej is
      signal S  : STD_LOGIC_VECTOR(4 downto 0);
      signal CC1,CC2,CS,CCS  : STD_LOGIC_VECTOR(2 downto 0);
      signal U1,U2,US,D1,D2,DS  : std_logic_vector (3 downto 0);
      
      signal data_in, data_out: std_logic_vector (31 downto 0);
      signal pulso: std_logic;
      signal selector : std_logic_vector (1 downto 0);
      
      signal numero      : std_logic_vector (3 downto 0);

--SUMA
begin

--   convertidor a 2 decimales 
   process(A,CC1)
   begin
       if A < "1010" then  -- Cuando la suma sea inferior a 10
           D1 <= "0000";

           U1(0) <= A(0);
           U1(1) <= A(1);
           U1(2) <= A(2);
           U1(3) <= A(3);

       elsif A > "1010" then  -- Cuando el numero es superior a 9
           D1 <= "0001";

           U1(0) <= A(0);
           U1(1) <= A(1) xor '1';
           CC1(1) <= A(1) and '1';
           U1(2) <= A(2) xor '1' xor CC1(1);
           CC1(2) <= (A(2) and '1') or ((A(2) xor '1') and CC1(1));
           U1(3) <= A(3) xor CC1(2);
       end if;
   end process;
   
   process(B,CC2)
   begin
       if B < "1010" then  -- Cuando la suma sea inferior a 10
           D2 <= "0000";

           U2(0) <= B(0);
           U2(1) <= B(1);
           U2(2) <= B(2);
           U2(3) <= B(3);

       elsif B > "1010" then  -- Cuando el numero es superior a 9
           D2 <= "0001";

           U2(0) <= B(0);
           U2(1) <= B(1) xor '1';
           CC2(1) <= B(1) and '1';
           U2(2) <= B(2) xor '1' xor CC2(1);
           CC2(2) <= (B(2) and '1') or ((B(2) xor '1') and CC2(1));
           U2(3) <= B(3) xor CC2(2);
       end if;
   end process;
    S(0) <= A(0) XOR B(0);
    CS(0) <= (A(0) AND B(0));
    
    S(1) <= A(1) XOR B(1) XOR CS(0);
    CS(1) <= (A(1) AND B(1)) OR ((A(1) XOR B(1)) AND CS(0));
 
    S(2) <= A(2) XOR B(2) XOR CS(1);
    CS(2) <= (A(2) AND B(2)) OR ((A(2) XOR B(2)) AND CS(1));

    S(3) <= A(3) XOR B(3) XOR CS(2);
    S(4) <= (A(3) AND B(3)) OR ((A(3) XOR B(3)) AND CS(2));
   
--   convertidor a 2 decimales 
   process(S,CS)
   begin
       if S < "01010" then  -- Cuando la suma sea inferior a 10
           DS <= "0000";

           US(0) <= S(0);
           US(1) <= S(1);
           US(2) <= S(2);
           US(3) <= S(3);

       elsif S > "01010" and S < "10100" then  -- Cuando la suma es superior a 9 e inferior a 20
           DS <= "0001";

           US(0) <= S(0);
           US(1) <= S(1) xor '1';
           CCS(1) <= S(1) and '1';
           US(2) <= S(2) xor '1' xor CCS(1);
           CCS(2) <= (S(2) and '1') or ((S(2) xor '1') and CCS(1));
           US(3) <= S(3) xor CCS(2);
       elsif S > "10011" and S < "11110" then  -- Cuando la suma es mayor a 19 e inferior a 30
           DS <= "0010";

           US(0) <= S(0);
           US(1) <= S(1);
           US(2) <= S(2) xor '1';
           CCS(2) <=(S(2) and '1');
           US(3) <= S(3) XOR '1' XOR CCS(2);

       elsif S > "11101" then  -- Cuando la suma es superior a 29 
           DS <= "0011";
           US(0) <= S(0);
           US(1) <= S(1) xor '1';
           CCS(1) <= S(1) and B(1);
           US(2) <= S(2) xor CCS(1);
           CCS(2) <= S(2) and CCS(1);
           US(3) <= S(3) xor CCS(2);
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
    
   process (sum, selector, U1,U2,US, D1,D2,DS)
   begin
       if (sum = '1') then
           case selector is
               when "00" =>
                   numero <= "0000";
                   an<= "1111";
               when "01" =>
                   numero <= DS;
                   an<= "1011";
               when "10" =>
                   numero <= US;
                   an<= "1101";
               when others =>
                   numero <= "0000";
                   an<= "1111";
           end case;
       else
           case selector is
               when "00" =>
                   numero <= D2;
                   an<= "0111";
               when "01" =>
                   numero <= U2;
                   an<= "1011";
               when "10" =>
                   numero <= D1;
                   an<= "1101";
               when others =>
                   numero <= U1;
                   an<= "1110";
           end case;
       end if;
   end process;
                
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