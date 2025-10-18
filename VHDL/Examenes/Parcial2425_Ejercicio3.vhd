library IEEE; use IEEE.std_logic_1164.all;

entity MaquinaEstados is 
    port( X : in std_logic_vector (1 downto 0); --entrada de dos bits
        clk, reset : in std_logic;
        Z : out std_logic_vector(2 downto 0) --3 bits para representar numeros del 0 al 4
    );
end MaquinaEstados;

architecture Behaviour of MaquinaEstados is
    --Definimos los estados
    type state_type is (S0, S1, S2, S3, S4);
    signal current_state, next_state : state_type; --Definimos el estado actual y siguiente
    begin
    process(clk) begin --process de la parte sincrona
        if rising_edge(clk) then 
            if(reset = '0') then
                current_state <= S0;
            else 
                current_state <= next_state;
            end if;
        end if;
    end process;
    process(X,current_state) begin --process de la parte combinacional
        case current_state is --tratamos el estado actual y definimos el siguiente
            when S0 => Z <= "000";
                if(X = "00") then --QUEDARME
                    next_state <= S0
                elsif X = "01" then --avanzar 1
                    next_state <= S1;
                elsif X = "10" then  --avanzar 2
                    next_state <= S2;
                elsif X = "11" then --retroceder 1
                    next_state <= S4;
                end if; 
            when S1 => Z <= "001";
                if(X = "00") then --QUEDARME
                    next_state <= S1
                elsif X = "01" then --avanzar 1
                    next_state <= S2;
                elsif X = "10" then  --avanzar 2
                    next_state <= S3;
                elsif X = "11" then --retroceder 1
                    next_state <= S0;
                end if; 
            when S2 => Z <= "010";
                if(X = "00") then --QUEDARME
                    next_state <= S2
                elsif X = "01" then --avanzar 1
                    next_state <= S3;
                elsif X = "10" then  --avanzar 2
                    next_state <= S4;
                elsif X = "11" then --retroceder 1
                    next_state <= S1;
                end if; 
            when S3 => Z <= "011";
                if(X = "00") then --QUEDARME
                    next_state <= S3
                elsif X = "01" then --avanzar 1
                    next_state <= S4;
                elsif X = "10" then  --avanzar 2
                    next_state <= S0;
                elsif X = "11" then --retroceder 1
                    next_state <= S2;
                end if; 
            when S4 => Z <= "100";
                if(X = "00") then --QUEDARME
                    next_state <= S4
                elsif X = "01" then --avanzar 1
                    next_state <= S0;
                elsif X = "10" then  --avanzar 2
                    next_state <= S1;
                elsif X = "11" then --retroceder 1
                    next_state <= S3;
                end if; 
            when others =>
                Z <= "000"
                next_state <= S0;
        end case;
    end process;
end Behaviour;