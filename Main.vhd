library IEEE;
use IEEE.std_logic_1164.ALL;


entity Main is
    Port (
        Ext:  in  std_logic;
        A:    in  std_logic_vector(3 downto 0);
        B:    in  std_logic_vector(3 downto 0);
        Btns: in  std_logic_vector(4 downto 0);
        Ctls: out std_logic_vector(3 downto 0);
        Outs: out std_logic_vector(3 downto 0);
        Cato: out std_logic_vector(6 downto 0);
        Anod: out std_logic_vector(3 downto 0);
        Carry: out std_logic;
        OFlow: out std_logic
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
    
    signal Clk:     std_logic;
    signal OutsAux: std_logic_vector(3 downto 0);
    signal CtlsAux: std_logic_vector(4 downto 0);
    
begin
    
    Ctls <= CtlsAux (3 downto 0);
    Outs <= OutsAux;
    
    ALU_c: ALU port map(
        A     => A,
        B     => B,
        Ctls  => CtlsAux(3 downto 0),
        Outs  => OutsAux,
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
        Ctls  => CtlsAux
    );
    
    Driver_Display_c: Driver_Display port map (
        A     => A,
        B     => B,
        Outs  => OutsAux,
        Ctls  => CtlsAux(4 downto 3),
        Clk   => Clk,
        Cato  => Cato,
        Anod  => Anod
    );
    
end Schematical;
