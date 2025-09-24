library IEEE; use IEEE.std_logic_1164.all;
--Written and Directed By Alvorak

--1º - Escriba un módulo en VHDL que realice la función XOR para cuatro entradas. La entrada del 
--módulo es “a(3:0)” y la salida es “y”

entity ejericio1 is 
    port (a: in std_logic_vector( 3 down to 0);
    y: out std_logic);
end;

architecture Dataflow of ejericio1 is
begin
    y <= a(3) xor a(2) xora(1) xor a(0); --xor sin mas de todas las entradas
end Dataflow; 

--2º - Escriba un módulo en VHDL llamado “minority” con tres entradas A, B y C, y una salida Z. La 
--salida del módulo es TRUE cuando al menos dos de las tres entradas son FALSE

entity ejercicio2_MINORITY is 
    port (A B, C: in std_logic;
    Z: out std_logic);
end;

architecture Dataflow of ejercicio2_MINORITY is
begin
    z <= ((not a) and (not b)) or ((not a) and (not c)) or ((not b) and (not c));
end Dataflow;


--3º - Escriba el código VHDL de un decodificador de 3:8

entity ejercicio3_decodificador is 
    port (a: in std_logic_vector(2 down to 0); --DECODIFICADOS 3 BITS A LA POSICION 2^3 = 8
    y: out std_logic_vector (7 down to 0));
end;

architecture Dataflow of ejercicio3_decodificador is
begin
     with a select
    y <= "0000 0001" when "000", --0
         "0000 0010" when "001", --1
         "0000 0100" when "010", --2
         "0000 1000" when "011", --3
         "0001 0000" when "100", --4
         "0010 0001" when "101", --5
         "0100 0001" when "110", --6
         "1000 0001" when "111", --7
         "0000 0000" when others; -- apagado
end Dataflow;

--4º Escriba el código VHDL de un decodificador BCD a 7 segmentos (7 bits)

entity ejercicio4_decodificador is
    port (
        a : in  std_logic_vector(3 downto 0);  -- Entrada BCD (4 bits)
        y : out std_logic_vector(6 downto 0)   -- Salida a segmentos (a-g)
    );
end ejercicio4_decodificador;

architecture Dataflow of ejercicio4_decodificador is
begin
    process(a)
    begin
        case a is --abcdefg
            when "0000" => y <= "1111110"; -- 0
            when "0001" => y <= "0110000"; -- 1
            when "0010" => y <= "1101101"; -- 2
            when "0011" => y <= "1111001"; -- 3
            when "0100" => y <= "0110011"; -- 4
            when "0101" => y <= "1011011"; -- 5
            when "0110" => y <= "1011111"; -- 6
            when "0111" => y <= "1110000"; -- 7
            when "1000" => y <= "1111111"; -- 8
            when "1001" => y <= "1110011"; -- 9
            when others => y <= "1001111"; -- apagado
        end case;
    end process;
end Dataflow;
