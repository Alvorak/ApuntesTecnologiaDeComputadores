library IEEE; use IEEE.std_logic_1164.all;

entity my_circuit is 
    port(
        clk, reset : in std_logic;
        q0_out, q1_out, q2_out : out std_logic
    );
end my_circuit;

architecture Behaviour of my_circuit is
    signal q0, q1, q2, q2_n std_logic; --señales que corresponden a las salidas de los flipflops
begin
    --preparamos la parte sincrona
    process(clk)
    begin
        if(reset = '0') then --reset de los 3 flipflop
            q0 <= '0';
            q1 <= '1';
            q2 <= '0';
        elsif rising_edge(clk) then --parte sincrona de los 3 flipflop
            q0 <= q2_n;
            q1 <= q0;
            q2 <= q1;
        end if;
    end process;
    --asignamos las señales a las salidas
    q0_out <= q0;
    q1_out <= q1;
    q2_out <= not q2; --como q2_out esta vinculada a la Q' del ultimo flipflop
end Behaviour;