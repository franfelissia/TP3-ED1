library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Driver_Display_Test is
end Driver_Display_Test;

architecture Behavioral of Driver_Display_Test is

    component Driver_Display is
        Port(
            A, B, Outs: in  std_logic_vector (3 downto 0);
            Ctls:       in  std_logic_vector (1 downto 0);
            Clk:        in  std_logic;
            Cato:       out std_logic_vector (6 downto 0);
            Anod:       out std_logic_vector (3 downto 0)
        );
    end component;

    signal A, B, Outs: std_logic_vector (3 downto 0) := "0000";
    signal Ctls:       std_logic_vector (1 downto 0) := "00";
    signal Clk:        std_logic                     := '0';
    signal Cato:       std_logic_vector (6 downto 0);
    signal Anod:       std_logic_vector (3 downto 0);

begin

    DUT: Driver_Display port map(
        A    => A,
        B    => B,
        Outs => Outs,
        Ctls => Ctls,
        Clk  => Clk,
        Cato => Cato,
        Anod => Anod
    );
    
    clock: process begin
        Clk <= not(Clk);
        wait for 500 us;
    end process clock;
    
    simulacion: process begin
        
        -- Asignamos números cualquiera a A, B y Outs.
        A    <= "0001";
        B    <= "0010";
        Outs <= "1000";
        
        -- Ponemos en modo aritmético, debería empezar mostrando Outs.
        Ctls(0) <= '1';
        wait for 16 ms;
        
        -- Mandamos un pulso para cambiar a A.
        Ctls(1) <= '1'; wait for 100 us; Ctls(1) <= '0';
        wait for 16 ms;
        
        -- Mandamos un pulso para cambiar a B.
        Ctls(1) <= '1'; wait for 100 us; Ctls(1) <= '0';
        wait for 16 ms;
        
        -- Mandamos un pulso para volver a Outs
        Ctls(1) <= '1'; wait for 100 us; Ctls(1) <= '0';
        wait for 16 ms;
        
        -- Ponemos en modo binario, debería apagarse la salida.
        Ctls(0) <= '0';
        wait for 32 ms;
        
        -- Fin
        std.env.stop;
        
    end process simulacion;
    
end Behavioral;
