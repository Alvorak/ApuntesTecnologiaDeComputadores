library IEEE;
use IEEE.STD_LOGIC_1164.ALL; use IEEE.NUMERIC_STD.ALL; 

entity ALU is
    port(A, B : in std_logic_vector(3 downto 0); --Entradas de 4 bits
    S : in std_logic_vector(1 downto 0); --Seleccion de operacion (suma o resta)
    Cout : out std_logic;--Resto de bits de la suma
    Y : out std_logic_vector(3 downto 0) --Salida de 4 bits
    );
end ALU;

architecture Behavioural of ALU is
    signal sum : unsigned(4 downto 0) := (others => '0');  --Señal interna para la suma con bit extra (resto)
begin
    process(S,A,B,sum) 
    begin
        case S is
            when "00" => -- Suma
                sum <= ('0' & unsigned(A)) + ('0' & unsigned(B)); -- Convertir a unsigned y sumar
                Y <= std_logic_vector(sum(3 downto 0)); -- Asignar los 4 bits menos significativos a la salida
                Cout <= sum(4); -- Asignar el bit de resto a Cout
            when "01" => -- Resta
                sum <= ('0' & unsigned(A)) - ('0' & unsigned(B)); -- Convertir a unsigned y restar
                Y <= std_logic_vector(sum(3 downto 0)); -- Asignar los 4 bits menos significativos a la salida
                Cout <= sum(4); -- Asignar el bit de resto a Cout
            when "10" => -- AND
                sum <= (others => '0'); -- No se usa en esta operacion
                Y <= A and B; -- Asignar la operacion AND a la salida 
                Cout <= '0'; -- No se usa en esta operacion
            when others => -- OR
                sum <= (others => '0'); -- No se usa en esta operacion
                Y <= A or B; -- Asignar la operacion OR a la salida
                Cout <= '0'; -- No se usa en esta operacion
        end case;
    end process;
end Behavioural;

--Ejercicio 2: Banco de pruebas para la ALU
library IEEE; use IEEE.STD_LOGIC_1164.ALL;

entity tb_ALU is
end tb_ALU;

architecture Behavioral of tb_ALU is
    component ALU is 
        port(A,B : in std_logic_vector(3 downto 0);
        S : in std_logic_vector(1 downto 0);
        Cout : out std_logic;
        Y : out std_logic_vector(3 downto 0)
        );
    end component;
 
    signal A_in, B_in, _Y : std_logic_vector(3 downto 0); 
    signal S_in : std_logic_vector(1 downto 0); 
    signal _Cout : std_logic; 
    constant time : time := 20 ns;
begin
    inst_alu : ALU
    port map(A => A_in,
    B => B_in,
    S => S_in,
    Cout => _Cout,
    Y => _Y
    );
    process
    begin 
        --7 + 10 = 17
        A_in <= "0111";
        B_in <= "1010";
        S_in <= "00";
        wait for time;
        --14 - 9 = 5
        A_in <= "1110";
        B_in <= "1001";
        S_in <= "01";
        wait for time;
        --15 AND 2 = 2
        A_in <= "1111";
        B_in <= "0010";
        S_in <= "10";
        wait for time;
        --8 OR 3 = 11
        A_in <= "0011";
        B_in <= "1011";
        S_in <= "11";
        wait;
    end process;
end Behavioral;
