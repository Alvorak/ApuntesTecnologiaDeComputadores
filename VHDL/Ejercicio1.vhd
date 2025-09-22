--Written and Directed by Alvorak
library IEEE; use IEEE.std_logic_1164.all;

entity ejercicio1 is
    port (A, B, C, S1, S2: IN std_logic; -- tenemmos 3 entradas y dos señales de control para los MUX
    out Q IN std_logic); -- una sola salida
end ejercicio1;

architecture Behavior of ejercicio1 is
begin
    process(A, B, C, S0, S1)
    begin
        if (S0 = '0') then -- si S0 es 0 cogemos el valor de A
                Q <= A;
            else -- si S0 = 1 
                if (S1 = '0') then -- S0=1 S1=0 => cogemos B
                    Q <= B;
                else
                    Q <= C; -- S0=1 S1=1 => cogemos C
                end if;
        end if;
    end process;
end Behavior;
