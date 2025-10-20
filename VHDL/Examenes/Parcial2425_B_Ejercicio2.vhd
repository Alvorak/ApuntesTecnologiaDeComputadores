library IEEE; use IEEE.std_logic_1164.all;

entity mux_4_1 is 
    port(
        A, B, C, D, S0, S1 : in std_logic;
        Y : out std_logic
    );
end mux_4_1;

architecture struct of mux_4_1 is
    component mux_2_1 is --definimos el componente que vamos a usar dentro del mux_4_1
        port(
            A, B, S : in std_logic;
            Y : out std_logic;
        );
    end component;
    signal wire_h, wite_l : std_logic;
begin
    i_mux_2_1_h : mux_2_1 port map (
        A <= A, 
        B <= B,
        Y <= wire_h, --cable que conecta Y del 2_1 de arriba con el 2_1 final
        S <= S0
    );
    i_mux_2_1_l : mux_2_1 port map (
        A <= C, 
        B <= D,
        Y <= wire_l, --cable que conecta Y del 2_1 de abajo con el 2_1 final
        S <= S0
    );
     i_mux_2_1_f : mux_2_1 port map (
        A <= wire_h, 
        B <= wire_l, --usamos los cables de los mux 2_1 de antes 
        Y <= Y, --salida final
        S <= S1 --señal de control s1 porque es la segunda parte
    );
end struct;
