library IEEE; use IEEE.std_logic_1164.all;

entity Multiplexor is
    port(
        X : in std_logic_vector(5 downto 0);--vector de 6 bits para representar la entrada
        S : in std_logic_vector(2 downto 0);--vector de 3 bits para la seleccion
        Y : out std_logic_vector(1 downto 0);--vector de 3 bits para la SALIDA
        Valid : out std_logic-- salida valid de 1 bit
    );
end Multiplexor;

architecture Behaviour of Multiplexor is
begin
    process(X,S)
    begin
        case S is
            when "000" => Y <= X(0); Valid <='1';
            when "001" => Y <= X(1); Valid <='1';
            when "010" => Y <= X(2); Valid <='1';
            when "011" => Y <= X(3); Valid <='1';
            when "100" => Y <= X(4); Valid <='1';
            when "101" => Y <= X(5); Valid <='1';
            when others => Y <= '0'; Valid <='0';
        end case;
    end process;
end Behaviour;


architecture Behaviour_Condicional of Multiplexor is
begin
    process(X,S)
    begin

        Y <=  X(0) when S = "000" else
        X(1) when S = "001" else
        X(2) when S = "010" else
        X(3) when S = "011" else
        X(4) when S = "100" else
        X(5) when S = "101" else
        '0';

        Valid <= '0' when SEL = "110" OR "111" else '1';
    end process;
end Behaviour_Condicional;