library IEEE; use IEEE.STD_LOGIC_1164.all;

--Primero deberemos crear la entidad del ejericio con sus entradas y salidas
entity FlipFlopDoble is 
    port(
        reset, clk : in std_logic;
        data_in : in std_logic_vector(1 downto 0);
        data_out : out std_logic_vector(1 downto 0)
    );
end FlipFlopDoble;

architecture Behavioral_OPCION1 of FlipFlopDoble is
    signal Q1,Q2 : std_logic; --incializamos las señales salida de los dos flipflop
begin
    process(clk, reset) 
        if(reset = '1') then
            Q1 <= '0'; Q2 <= '0';
        end if;
        if rising_edge(clk) then
            Q1 <= data_in(0);  Q2<= Q1;
        end if;    
    end process; --Q1 CONCATENADO CON XOR(Q2,Q1)  
    --& => VECTOR&VECOR = VECTORVECTOR
    data_out <= Q1 & (Q2 XOR data_in(1));
end Behavioral_OPCION1;

architecture Behavioral_OPCION2 of FlipFlopDoble is
    signal Q1,Q2 : std_logic; --incializamos las señales salida de los dos flipflop
begin
    process(clk, reset) --PRIMER FLIPFLOP
        if(reset = '1') then
            Q1 <= '0';
        end if;
        if rising_edge(clk) then
            Q1 <= data_in(0);
        end if;    
    end process;
    process(clk, reset) --SEGUNDO FLIPFLOP
        if(reset = '1') then
            Q2 <= '0';
        end if;
        if rising_edge(clk) then
            Q2<= Q1;
        end if;    
    end process;
    data_out(0) <= Q2 XOR data_in(1);
    data_out(1) <= Q1;
end Behavioral_OPCION2;