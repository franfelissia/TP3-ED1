library IEEE;
use IEEE.std_logic_1164.ALL;


entity Main is
    Port (
        Ext:  in  std_logic;
        A:    in  std_logic_vector(3 downto 0);
        B:    in  std_logic_vector(3 downto 0);
        Btns: in  std_logic_vector(4 downto 0);
        LEDs: out std_logic_vector(9 downto 0);
        Cato: out std_logic_vector(6 downto 0);
        Anod: out std_logic_vector(3 downto 0)
    );
end Main;

architecture Schematical of Main is

    component ALU is
        Port (
            A, B, Ctls:   in  std_logic_vector(3 downto 0);
            Outs:         out std_logic_vector(3 downto 0);
            Carry, OFlow: out std_logic
        );
    end component;
    
    component Clock is
        Port (
            Ext: in  std_logic;
            Clk: out std_logic
        );
    end component;
    
    component Driver_Btns is
        Port(
            Clk:  in    std_logic;
            Btns: in    std_logic_vector(4 downto 0);
            Ctls: inout std_logic_vector(4 downto 0)
        );
    end component;
    
    component Driver_Display is
        Port(
            A, B, Outs: in  std_logic_vector(3 downto 0);
            Ctls:       in  std_logic_vector(1 downto 0);
            Clk:        in  std_logic;
            Cato:       out std_logic_vector(6 downto 0);
            Anod:       out std_logic_vector(3 downto 0)
        );
    end component;
    
    signal Clk, Carry, OFlow: std_logic;
    signal Outs:              std_logic_vector(3 downto 0);
    signal Ctls:              std_logic_vector(4 downto 0);
    
begin
    
    leds <= (ctls(3 downto 0) & oFlow & carry & outs);
    
    ALU_c: ALU port map(
        A     => A,
        B     => B,
        Ctls  => Ctls(3 downto 0),
        Outs  => Outs,
        Carry => Carry,
        OFlow => OFlow
    );
    
    Clock_c: Clock port map (
        Ext   => Ext,
        Clk   => Clk
    );
    
    Driver_Btns_c: Driver_Btns port map (
        Clk   => Clk,
        Btns  => Btns,
        Ctls  => Ctls
    );
    
    Driver_Display_c: Driver_Display port map (
        A     => A,
        B     => B,
        Outs  => Outs,
        Ctls  => Ctls(4 downto 3),
        Clk   => Clk,
        Cato  => Cato,
        Anod  => Anod
    );
    
end Schematical;
