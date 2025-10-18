library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Tflop is
    port (
        T, CLK : in  STD_LOGIC; -- Entradas T y reloj
        Q      : out STD_LOGIC -- Salida Q
    );
end Tflop;

architecture Behavioral of Tflop is
    signal aux : STD_LOGIC := '0'; -- Señal auxiliar para almacenar el estado
begin
    process (CLK) --Proceso sensible al reloj
    begin
        if rising_edge(CLK) then -- Disparo en flanco de subida del reloj
            if T = '1' then
                aux <= not aux;   -- Conmuta el estado (toggle)
            else
                aux <= aux;       -- Mantiene el estado (no cambia)
            end if;
        end if;
    end process;

    Q <= aux;
end Behavioral;
