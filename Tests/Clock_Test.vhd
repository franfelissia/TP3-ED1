library IEEE;
use IEEE.std_logic_1164.ALL;


entity Clock_Test is
end Clock_Test;

architecture Behavioral of Clock_Test is
    
    component Clock is
        Port (
            Ext: in  std_logic;
            Clk: out std_logic
        );
    end component;

    signal Ext: std_logic := '0';
    signal Clk: std_logic;

begin
    
    DUT: Clock port map(
        Ext => Ext,
        Clk => clk
    );
    
    Clk_Ext_100Mhz: process begin
        Ext <= not(Ext);
        wait for 5 ns;
    end process Clk_Ext_100Mhz;
    
    Stop_Sim: process begin
        wait for 10 ms;
        std.env.stop;
    end process;

end Behavioral;
