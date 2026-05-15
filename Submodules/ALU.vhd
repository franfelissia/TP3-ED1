library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is Port(
    A, B, Ctls:   in  std_logic_vector(3 downto 0);
    Outs:         out std_logic_vector(3 downto 0);
    Carry, OFlow: out std_logic
); end ALU;

architecture DataFlow of ALU is

    component Full_Adder is Port (
        a, b, ci: in  std_logic;
        s, co:    out std_logic
    ); end component;

    signal CAux:           std_logic_vector(3 downto 0);
    signal BAux, Sum, Sat: std_logic_vector(3 downto 0);
    signal OFAux:          std_logic;

begin

    BAux  <= B xor (Ctls(1) & Ctls(1) & Ctls(1) & Ctls(1));

    FA0: Full_Adder port map (a => A(0), b => BAux(0), ci => Ctls(1), s => sum(0), co => CAux(0));
    FA1: Full_Adder port map (a => A(1), b => BAux(1), ci => CAux(0), s => sum(1), co => CAux(1));
    FA2: Full_Adder port map (a => A(2), b => BAux(2), ci => CAux(1), s => sum(2), co => CAux(2));
    FA3: Full_Adder port map (a => A(3), b => BAux(3), ci => CAux(2), s => sum(3), co => CAux(3));
    
    OFAux <= (CAux(2) xor CAux(3)) and Ctls(3);
    OFlow <= OFAux;

    Carry <= CAux(3) and Ctls(3);

    Sat   <= "0111" when Sum(3) = '1' and OFAux = '1' and Ctls(2) = '1' else
             "1000" when Sum(3) = '0' and OFAux = '1' and Ctls(2) = '1' else
             Sum;
    
    Outs  <= Sat     when Ctls(3) = '1' else
             A and B when Ctls(0) = '1' else
             A or  B;

end DataFlow;
