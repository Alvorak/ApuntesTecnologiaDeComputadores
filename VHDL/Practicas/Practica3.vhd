library IEEE; use IEEE.STD_LOGIC_1164.all;

-- Y = AB' + B'C' + A'BC

entity ejercicio1 is
    port ( A, B, C : in STD_LOGIC;
    Y : out STD_LOGIC
    );
end ejercicio1;

architecture Structural of ejercicio1 is
    component mux8_1 is
        generic ( width : integer
        );
        port ( D0, D1, D2, D3, D4, D5, D6, D7 : in STD_LOGIC_VECTOR(width-1 downto 0);
         S : in STD_LOGIC_VECTOR(2 downto 0);
         Y : out STD_LOGIC_VECTOR(width-1 downto 0)
         );
         end component;
         signal sel : STD_LOGIC_VECTOR(2 downto 0);
begin
    sel <= A & B & C;
    mux : mux8_1
        generic map(1)
        port map("1", "0", "0", "1", "1", "1", "0", "0", --D0 ... D7
        sel --seleccionador
        , Y); --salida
end Structural;


library IEEE; use IEEE.STD_LOGIC_1164.all;

entity MEMORY is -- Memoria formada por un SENDER y un STORAGE
    port ( CLR, CLK : in STD_LOGIC; 
    EMPTY : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR(7 downto 0)
    );
end MEMORY;

architecture Structural of MEMORY is
    component SENDER is -- Componente de SENDER
        port (
            ENABLE, CLK, CLR : in  STD_LOGIC; -- entradas 
            VALID : out STD_LOGIC; 
            DATA : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    component STORAGE is
        port (
            CLR, WE, CLK : in  STD_LOGIC;
            DATA, Q : in  STD_LOGIC_VECTOR(7 downto 0);
            EMPTY : out STD_LOGIC;
            FULL : buffer STD_LOGIC
        );
    end component;

    signal S_FULL   : STD_LOGIC; --SEÑAL DE FULL DEL STORAGE PARA EL SENDER
    signal S_ENABLE : STD_LOGIC; --SEÑAL DE ENABLE DEL SENDER PARA EL STORAGE
    signal S_VALID  : STD_LOGIC; --SEÑAL DE VALID DEL SENDER PARA EL STORAGE
    signal S_DATA   : STD_LOGIC_VECTOR(7 downto 0); --SEÑAL DE DATA DEL SENDER PARA EL STORAGE
begin
    S_ENABLE <= not S_FULL; -- ENABLE es el inverso de FULL
    M_SENDER : SENDER 
        port map ( -- mapeo de puertos
            ENABLE => S_ENABLE,
            CLR    => CLR,
            CLK    => CLK,
            VALID  => S_VALID,
            DATA   => S_DATA
        );

    M_STORAGE : STORAGE
        port map ( -- mapeo de puertos
            CLR   => CLR,
            WE    => S_VALID,
            CLK   => CLK,
            DATA  => S_DATA,
            Q     => Q,
            EMPTY => EMPTY,
            FULL  => S_FULL
        );
end Structural;

library IEEE; use IEEE.STD_LOGIC_1164.all;

entity Testbench is
end Testbench;

architecture Behavioral of Testbench is
    component MEMORY is
        port ( CLR, CLK : in STD_LOGIC;
        EMPTY : out STD_LOGIC;
        Q : out STD_LOGIC_VECTOR(7 downto 0)
        );
end component;

    signal CLR, CLK, EMPTY : STD_LOGIC;
    signal Q : STD_LOGIC_VECTOR(7 downto 0);
begin
    MY_DUT : MEMORY port map(CLR, CLK, EMPTY, Q);
    process begin
        CLK <= '0'; wait for 10ns;
        CLK <= '1'; wait for 10ns;
    end process;
    process begin
        CLR <= '0'; wait for 15ns;
        CLR <= '1'; wait for 20ns;
        CLR <= '0'; wait;
    end process;
end Behavioral;