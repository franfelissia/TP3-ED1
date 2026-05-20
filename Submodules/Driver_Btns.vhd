-- Ctls0 :     OR (0) | (1) AND
-- Ctls1 :   Suma (0) | (1) Resta
-- Ctls2 : A pelo (0) | (1) Saturador
-- Ctls3 : Lógica (0) | (1) Aritmética
-- Ctls4 : Variable mostrada en el display

library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Driver_Btns is Port(
    Clk:  in  std_logic;
    Btns: in  std_logic_vector (4 downto 0);
    Ctls: out std_logic_vector (4 downto 0)
); end Driver_Btns;

architecture Behavioral of Driver_Btns is
    
    component Debounce is Port(
        Clk:  in  std_logic;
        Btn:  in  std_logic;
        Data: out std_logic
    ); end component;
    
    signal Data: std_logic_vector (3 downto 0) := "0000";
    signal CAux: std_logic_vector (3 downto 0);
    
begin
    
    Ctls(3 downto 0) <= CAux;
    
    D0: Debounce port map (
        Clk  => Clk,
        Btn  => Btns(0),
        Data => Data(0)
    );
    
    D1: Debounce port map (
        Clk  => Clk,
        Btn  => Btns(1),
        Data => Data(1)
    );

    D2: Debounce port map (
        Clk  => Clk,
        Btn  => Btns(2),
        Data => Data(2)
    );

    D3: Debounce port map (
        Clk  => Clk,
        Btn  => Btns(3),
        Data => Data(3)
    );

    D4: Debounce port map (
        Clk  => Clk,
        Btn  => Btns(4),
        Data => Ctls(4)
    );

    T0 : process (Data(0)) begin
        if rising_edge(Data(0)) and Data(0) = '1' then CAux(0) <= not(CAux(0)); end if;
    end process T0;

    T1 : process (Data(1)) begin
        if rising_edge(Data(1)) and Data(1) = '1' then CAux(1) <= not(CAux(1)); end if;
    end process T1;

    T2 : process (Data(2)) begin
        if rising_edge(Data(2)) and Data(2) = '1' then CAux(2) <= not(CAux(2)); end if;
    end process T2;    
    
    T3 : process (Data(3)) begin
        if rising_edge(Data(3)) and Data(3) = '1' then CAux(3) <= not(CAux(3)); end if;
    end process T3;
    
end Behavioral;
