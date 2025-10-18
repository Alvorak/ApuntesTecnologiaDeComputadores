--Written and Directed by Alvorak
library IEEE; use IEEE.std_logic_1164.all;

entity ejercicio1 is
    port (A, B, C, S1, S2: IN std_logic; -- tenemmos 3 entradas y dos señales de control para los MUX
    out Q IN std_logic); -- una sola salida
end ejercicio1;

architecture Behavior_if of ejercicio1 is
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
end Behavior_if;

architecture Behavior_case of ejercicio1 is
begin
    process(A, B, C, S0, S1)
    begin
        case (S0 & S1) is  -- concatenamos los selectores para cogerlos en pares
            when "00" => Q <= A;  -- S0=0 -> A
            when "10" => Q <= B;  -- S0=1, S1=0 -> B
            when "11" => Q <= C;  -- S0=1, S1=1 -> C
            when others => Q <= '0';  -- caso "default" 
        end case;
    end process;
end Behavior_case;


architecture Behavior_select of ejercicio1 is
begin
    with (S0 & S1) select 
        Q <= A when "00",
             B when "10",
             C when "11",
             '0' when others; -- caso "default" 
end Behavior_select;


architecture Behavior_logico of ejercicio1 is
begin
    Q <= (A and (not S0)) or -- Q = A*S0' + B*S0*S1' + C*S0*S1 
         (B and S0 and (not S1)) or
         (C and S0 and S1);
end Behavior_logico;
