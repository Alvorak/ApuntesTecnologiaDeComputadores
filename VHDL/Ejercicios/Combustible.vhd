entity Combustible is
    port( combustible : in std_logic_vector(2 downto 0); --señal de entrada a 3 bit
        clk, reset : in std_logic; --clok y reset para el flip flop
        L, M, W : out std_logic); --salidas Low Medium y Waring
end Combustible;

architecture Behavioral of Combustible is
    signal W_reg : std_logic := '0'; --Señal para poder tratar la salida W en la parte secuencial
begin
    --primero tratamos las entradas de la parte combinacional
    process(combustible) 
    begin
        case (combustible) is
            when "000" | "001" | "010" then --para los casos 0 1 2
                L <= '1'; M <='0';
            when "011" | "100" | "101" then --para los casos entre 3 y 5
                L <= '0'; M <='1';
            when others --para el resto de casos
                L <='0'; M <= '0';
        end case;
    end process;

    --proceso secuencial
    process(clk)
    begin
        if rising_edge(clk) then --cuando el reloj nivel alto
            if(R = '1') then --reset
                W_reg <= '0';
                elseif(L = '1') then --señal de que el nivel estuvo bajo
                    W_reg <= '1';
            end if;
        end if;
    end process;
    W  <= W_reg;
end Behavioral;