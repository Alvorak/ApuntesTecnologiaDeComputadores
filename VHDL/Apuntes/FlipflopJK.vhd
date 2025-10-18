library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity jkflop is
    port (
        J, K, CLK  : in  STD_LOGIC; -- Entradas J, K y reloj
        Q   : out STD_LOGIC -- Salida Q
    );
end jkflop;

architecture Behavioral of jkflop is
    signal aux : STD_LOGIC := '0'; --Señal auxiliar para almacenar el estado
begin
    process (CLK) --Proceso sensible al reloj
    begin
        if rising_edge(CLK) then -- Disparo en flanco de subida del reloj
            if (J = '0' and K = '0') then
                aux <= aux; -- Mantiene el estado (no cambia)
            elsif (J = '0' and K = '1') then
                aux <= '0'; -- Reset (señal de reset encendida)
            elsif (J = '1' and K = '0') then
                aux <= '1'; -- Set (señal de set encendida)
            else
                aux <= not aux; -- Toggle (cambia el estado => 0 a 1 o 1 a 0)
            end if;
        end if;
    end process;

    Q <= aux;
end Behavioral;
