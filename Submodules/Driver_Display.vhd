library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Driver_Display is
    Port(
        A, B, Outs: in  std_logic_vector (3 downto 0);
        Ctls:       in  std_logic_vector (1 downto 0);
        Clk:        in  std_logic;
        Cato:       out std_logic_vector (6 downto 0);
        Anod:       out std_logic_vector (3 downto 0)
    );
end Driver_Display;

architecture DataFlow of Driver_Display is
    
    signal Dig, Name, Sig: std_logic_vector(6 downto 0) := "1111111";
    signal Var:            std_logic_vector(3 downto 0) := "0000";
    signal Aux:            std_logic_vector(1 downto 0) := "11";
    signal Dp:             std_logic_vector(1 downto 0) := "11";

begin
    
    -- Selector de variable a mostrar
    
    Selector_Var: process (Ctls(1)) begin
        if rising_edge(Ctls(1)) then           -- Cambio de variable.
            if    Aux = "01" then Aux <= "10";
            elsif Aux = "10" then Aux <= "11";
            elsif Aux = "11" then Aux <= "01";
        end if; end if;        
    end process Selector_Var;
    
    -- Selector de display
    
    Selector_Dp: process (Clk, Ctls(0)) begin
        if rising_edge(Clk) and (Ctls(0) = '1') then
            if    Dp = "00" then Dp <= "01";
            elsif Dp = "01" then Dp <= "10";
            elsif Dp = "10" then Dp <= "11";
            elsif Dp = "11" then Dp <= "00";
        end if; end if;
    end process Selector_Dp;
    
    -- Asignaciones
    
    Var  <= A    when Aux = "01" else
            B    when Aux = "10" else
            Outs when Aux = "11";
    
    Name <= "0100000" when Aux = "01" else -- 'a'
            "0000011" when Aux = "10" else -- 'b'
            "0100011" when Aux = "11";     -- 'o'
    
    Sig(6) <= not(Var(3));
    
    -- Decodificador de complemento a 2 a 7 segmentos anodo común.
    
    with Var select Dig <=
      -- GFEDCBA
        "1000000" when "0000",
        "1111001" when "0001",
        "0100100" when "0010",
        "0110000" when "0011",
        "0011001" when "0100",
        "0010010" when "0101",
        "0000010" when "0110",
        "1111000" when "0111",
        "0000000" when "1000",
        "1111000" when "1001",
        "0000010" when "1010",
        "0010010" when "1011",
        "0011001" when "1100",
        "0110000" when "1101",
        "0100100" when "1110",
        "1111001" when "1111",
        "1111111" when others;
    
    Cato <= "1111111" when Ctls(0) = '0'  else
            Dig       when Dp =      "00" else
            Sig       when Dp =      "01" else
            "0110111" when Dp =      "10" else
            Name      when Dp =      "11";
            
    Anod <= "1111" when Ctls(0) = '0'  else
            "1110" when Dp =      "00" else
            "1101" when Dp =      "01" else
            "1011" when Dp =      "10" else
            "0111" when Dp =      "11";

end DataFlow;
