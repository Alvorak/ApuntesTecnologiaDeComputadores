library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Inversor is
    port (
        E : in  STD_LOGIC; -- Entrada 
        S            : out STD_LOGIC -- Salida S
    );
end Dflop;

architecture Behavioral of Inversor is
begin
    S <= not E;
end Behavioral;
