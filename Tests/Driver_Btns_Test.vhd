library IEEE;
use IEEE.std_logic_1164.ALL;


entity Driver_Btns_Test is
end Driver_Btns_Test;

architecture Behavioral of Driver_Btns_Test is
    component Driver_Btns is Port(
        Clk:  in    std_logic;
        Btns: in    std_logic_vector (4 downto 0);
        Ctls: inout std_logic_vector (4 downto 0)
    ); end component;
    
    signal Clk:  std_logic                     := '0';
    signal Btns: std_logic_vector (4 downto 0) := "00000";
    signal Ctls: std_logic_vector (4 downto 0);
    

    -- ----------------------------------------------------------------
    -- Simula el rebote al PRESIONAR un botón.
    -- El patrón de tiempos Varía según 'Variante' (0-3) para que
    -- cada botón o cada pulsación se vea diferente en el simulador.
    -- ----------------------------------------------------------------
    procedure PresionarBtn(
        signal   Btn: out std_logic;
        constant Var: in  integer range 0 to 3 := 0
    ) is begin
        case Var is
            when 0 =>                          -- rebote corto y rápido
                Btn <= '1'; wait for 310 us;
                Btn <= '0'; wait for 190 us;
                Btn <= '1'; wait for 140 us;
                Btn <= '0'; wait for  95 us;
                Btn <= '1'; wait for  70 us;
                Btn <= '0'; wait for  45 us;
                Btn <= '1';
            when 1 =>                          -- rebote largo con más oscilaciones
                Btn <= '1'; wait for 250 us;
                Btn <= '0'; wait for 210 us;
                Btn <= '1'; wait for 180 us;
                Btn <= '0'; wait for 150 us;
                Btn <= '1'; wait for 120 us;
                Btn <= '0'; wait for  90 us;
                Btn <= '1'; wait for  60 us;
                Btn <= '0'; wait for  35 us;
                Btn <= '1';
            when 2 =>                          -- primer pico muy corto
                Btn <= '1'; wait for  80 us;
                Btn <= '0'; wait for 220 us;
                Btn <= '1'; wait for 160 us;
                Btn <= '0'; wait for 110 us;
                Btn <= '1'; wait for  55 us;
                Btn <= '0'; wait for  30 us;
                Btn <= '1';
            when 3 =>                          -- casi sin rebote (pulsación limpia)
                Btn <= '1'; wait for 350 us;
                Btn <= '0'; wait for  80 us;
                Btn <= '1';
        end case;
        wait for 80 ms;   -- botón estable presionado
    end procedure;

    -- ----------------------------------------------------------------
    -- Simula el rebote al SOLTAR un botón.
    -- ----------------------------------------------------------------
    procedure SoltarBtn(
        signal   Btn: out std_logic;
        constant Var: in  integer range 0 to 3 := 0
    ) is begin
        case Var is
            when 0 =>
                Btn <= '0'; wait for 280 us;
                Btn <= '1'; wait for 175 us;
                Btn <= '0'; wait for 125 us;
                Btn <= '1'; wait for  85 us;
                Btn <= '0'; wait for  60 us;
                Btn <= '1'; wait for  40 us;
                Btn <= '0';
            when 1 =>
                Btn <= '0'; wait for 230 us;
                Btn <= '1'; wait for 200 us;
                Btn <= '0'; wait for 170 us;
                Btn <= '1'; wait for 130 us;
                Btn <= '0'; wait for  95 us;
                Btn <= '1'; wait for  65 us;
                Btn <= '0'; wait for  40 us;
                Btn <= '1'; wait for  20 us;
                Btn <= '0';
            when 2 =>
                Btn <= '0'; wait for  90 us;
                Btn <= '1'; wait for 200 us;
                Btn <= '0'; wait for 140 us;
                Btn <= '1'; wait for  70 us;
                Btn <= '0'; wait for  35 us;
                Btn <= '1'; wait for  20 us;
                Btn <= '0';
            when 3 =>                          -- casi sin rebote
                Btn <= '0'; wait for 320 us;
                Btn <= '1'; wait for  70 us;
                Btn <= '0';
        end case;
        wait for 80 ms;   -- botón estable liberado
    end procedure;

begin
    
    DUT: Driver_Btns port map(
        Clk  => Clk,
        Btns => Btns,
        Ctls => Ctls
    );
    
    Clock: process begin
        Clk <= not(Clk);
        wait for 500 us;
    end process clock;
    
     -- ----------------------------------------------------------------
    -- Btns(0): dos pulsaciones seguidas, Variantes de rebote distintas
    -- ----------------------------------------------------------------
    Sim_Btns0: process begin
        Btns(0) <= '0'; wait for 10 ms;          -- reposo inicial
        PresionarBtn(Btns(0), 0);
        SoltarBtn   (Btns(0), 1);
        wait for 20 ms;
        PresionarBtn(Btns(0), 2);
        SoltarBtn   (Btns(0), 0);
        wait;
    end process;

    -- ----------------------------------------------------------------
    -- Btns(1): empieza desplazado, simula usuario más lento
    -- ----------------------------------------------------------------
    Sim_Btns1: process begin
        Btns(1) <= '0'; wait for 30 ms;
        PresionarBtn(Btns(1), 1);
        SoltarBtn   (Btns(1), 3);
        wait for 10 ms;
        PresionarBtn(Btns(1), 3);
        SoltarBtn   (Btns(1), 2);
        wait;
    end process;

    -- ----------------------------------------------------------------
    -- Btns(2): una sola pulsación larga (mantiene presionado más tiempo)
    -- ----------------------------------------------------------------
    Sim_Btns2: process begin
        Btns(2) <= '0'; wait for 50 ms;
        PresionarBtn(Btns(2), 2);
        wait for 150 ms;                       -- mantiene presionado extra
        SoltarBtn   (Btns(2), 1);
        wait;
    end process;

    -- ----------------------------------------------------------------
    -- Btns(3): tres pulsaciones rápidas (doble-click + extra)
    -- ----------------------------------------------------------------
    Sim_Btns3: process begin
        Btns(3) <= '0'; wait for 15 ms;
        PresionarBtn(Btns(3), 0);
        SoltarBtn   (Btns(3), 0);
        wait for 5 ms;                         -- pausa corta entre pulsaciones
        PresionarBtn(Btns(3), 3);
        SoltarBtn   (Btns(3), 3);
        wait for 5 ms;
        PresionarBtn(Btns(3), 1);
        SoltarBtn   (Btns(3), 2);
        wait;
    end process;

    -- ----------------------------------------------------------------
    -- Btns(4): se activa tarde para verificar que no interfiere con otros
    -- ----------------------------------------------------------------
    Sim_Btns4: process begin
        Btns(4) <= '0'; wait for 200 ms;
        PresionarBtn(Btns(4), 2);
        SoltarBtn   (Btns(4), 0);
        wait;
    end process;

    -- ----------------------------------------------------------------
    -- Fin de simulación: cuando todos los estímulos terminaron
    -- ----------------------------------------------------------------
    Stop_Sim: process begin
        wait for 700 ms;
        std.env.stop;
    end process;
end Behavioral;
