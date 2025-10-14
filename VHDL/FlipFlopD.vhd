library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Dflop is
    port (
        D, S, R, CLK : in  STD_LOGIC; -- Entradas D, Set, Reset y reloj
        Q            : out STD_LOGIC -- Salida Q
    );
end Dflop;

architecture Behavioral of Dflop is
begin
    process (CLK) --Proceso sensible al reloj
    begin
        if rising_edge(CLK) then -- Disparo en flanco de subida del reloj
            if (S = '1' and R = '0') then
                Q <= '1';          -- Set (prioridad al Set)
            elsif (S = '0' and R = '1') then
                Q <= '0';          -- Reset (prioridad al Reset)
            elsif (S = '1' and R = '1') then
                Q <= not D;        -- Inversión de D (condición especial)
            else
                Q <= D;            -- Captura del valor D normal
            end if;
        end if;
    end process;
end Behavioral;
