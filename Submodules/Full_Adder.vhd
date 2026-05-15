library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Full_Adder is Port (
    A, B, Ci: in  std_logic;
    S, Co:    out std_logic
); end Full_Adder;

architecture DataFlow of Full_Adder is begin

    S <=  A xor B xor Ci;
    Co <= (A and B) or (A and Ci) or (B and Ci);

end DataFlow;
