library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux_42 is
    port (
        A, B, C, D : in  STD_LOGIC; -- Entradas
        SEL : in std_logic_vector (1 downto 0); --Señal de control
        Y : out STD_LOGIC -- Salida S
    );
end mux_42;

architecture Behavioral of mux_42 is
begin
    process (A, B, C, D, SEL)
    begin
      case SEL is
          when "00" =>
                Y <= A;
          when "01" =>
                Y <= B;
          when "10" =>
                Y <= C;  
          when "11" =>
                Y <= D;
          when others =>
                Y <= '0';
      end case;
    end process;
end Behavioral;
