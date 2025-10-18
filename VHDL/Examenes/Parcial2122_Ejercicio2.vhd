library IEEE; use IEEE.std_logic_1164.all;

entity MaquinaMoore is
    port( X, reset, clk : in std_logic;
    Y : out std_logic_vector(2 downto 0)
    );
end MaquinaMoore;


architecture Behaviour of MaquinaMoore is 
    type type_state is (S0, S1, S2, S3, S4, S5);
    signal current, nextS : state_type;
begin
    process(clk)
    begin
        if reset = '1' then
            current <= S0;
        else 
            current <= nextS;
        end if;
    end process
    process(X,current) begin --process de la parte combinacional
        case current is --tratamos el estado actual y definimos el siguiente
        when S0 => Y <= "000"
            if X ='0' then --sumo 1
                nextS <= S0;
            else 
                nextS <= S1; --sumo 2
            end if;
        when S1 => Y <= "001"
            if X ='0' then --sumo 1
                nextS <= S2;
            else  
                nextS <= S3; --sumo 2
            end if;
        when S2 => Y <= "010"
            if X ='0' then --sumo 1
                nextS <= S3;
            else  
                nextS <= S4; --sumo 2
            end if;
        when S3 => Y <= "011"
            if X ='0' then --sumo 1
                nextS <= S4;
            else  
                nextS <= S5; --sumo 2
            end if;
        when S4 => Y <= "100"
            if X ='0' then --sumo 1
                nextS <= S5;
            else  
                nextS <= S4; --como al sumar 2 me paso de 4 me quedo en 4 (asi se ha solicitado en el enunciado)
            end if;
        when S5 => Y <= "101"
            nextS <= S5; --estado de saturacion y esperamos a resetear
        when other => Y <= "000"
            nextS <= S0; 
        end case;
    end process;

end Behaviour;