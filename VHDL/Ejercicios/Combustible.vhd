library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Indicador_Combustible is
    port (
        clk   : in  std_logic; -- Reloj
        R     : in  std_logic; -- Reset síncrono activo en alto (Reset)
        nivel : in  std_logic_vector(2 downto 0); -- Nivel de combustible (3 bits)
        L     : out std_logic; -- Luz de nivel bajo (Low)
        M     : out std_logic; -- Luz de nivel medio (medium)
        W     : out std_logic -- Indicador persistente de "combustible bajo" (Warning)
    );
end Indicador_Combustible;

architecture Behavioral of Indicador_Combustible is
    signal W_reg : std_logic := '0'; -- Registro para el indicador persistente de "combustible bajo" (Warning)
begin

    -- Proceso combinacional: determina L y M según el nivel
    process(nivel) --Procesamos nivel
    begin
        case nivel is
            when "000" | "001" | "010" =>  -- niveles 0, 1, 2 → bajo
                L <= '1';
                M <= '0';
            when "011" | "100" | "101" =>  -- niveles 3, 4, 5 → medio
                L <= '0';
                M <= '1';
            when others =>                  -- niveles 6, 7 → alto => no los encendemos
                L <= '0';
                M <= '0';
        end case;
    end process;

    -- Proceso secuencial: flip-flop D para W (persistente)
    process(clk) --Procesamos clk
    begin
        if rising_edge(clk) then -- Flanco de subida del reloj
            if R = '1' then                -- Reset síncrono
                W_reg <= '0';
            elsif L = '1' then             -- Si hay nivel bajo, activa la alerta
                W_reg <= '1';
            end if;
        end if;
    end process;

    -- Asignación de salida
    W <= W_reg; -- Salida del indicador persistente de "combustible bajo" (Warning) usando la señal del registro

end Behavioral;
