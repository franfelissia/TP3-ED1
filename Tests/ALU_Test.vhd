library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_Test is
end ALU_Test;

architecture Behavioral of ALU_Test is

    component ALU is Port (
        A, B, Ctls:   in  std_logic_vector(3 downto 0);
        Outs:         out std_logic_vector(3 downto 0);
        Carry, OFlow: out std_logic
    ); end component;

    signal A, B, Ctls:   std_logic_vector(3 downto 0);
    signal Outs:         std_logic_vector(3 downto 0);
    signal Carry, OFlow: std_logic;

begin

    DUT: ALU port map(
        A     => A,
        B     => B,
        Ctls  => Ctls,
        Outs  => Outs,
        Carry => Carry,
        OFlow => OFlow
    );
    
    Simulacion: process begin

        -- |Ctls|Operación|
        -- |----|---------|
        -- |0xx0| OR      |
        -- |0xx1| AND     |
        -- |1x0x| Suma    |
        -- |1x1x| Resta   |
        -- |x1xx| Sat. On |
        
        ----------------
        -- Aritmética --
        ----------------

        -- Suma s/ Saturador
        -- - Res: 3 (0011),
        -- - Carry: 0,
        -- - OFlow: 0
        Ctls <= "1000";
        A    <= "0010";  -- 2
        B    <= "0001";  -- 1
        wait for 500 us;

        -- Suma c/ Saturador
        -- - Res: 3 (0011),
        -- - Carry: 0,
        -- - OFlow: 0
        Ctls <= "1101";
        wait for 500 us;

        -- Suma s/ Saturador
        -- - Res: -2 (1110),
        -- - Carry: 1,
        -- - OFlow: 0
        Ctls <= "1001";
        A    <= "1111";  -- -1
        B    <= "1111";  -- -1
        wait for 500 us;

        -- Suma c/ Saturador
        -- - Res: -2 (1110),
        -- - Carry: 1,
        -- - OFlow: 0
        Ctls <= "1100";
        wait for 500 us;

        -- Suma s/ Saturador
        -- - Res: -8 (1000),
        -- - Carry: 0,
        -- - OFlow: 1
        Ctls <= "1000";
        A    <= "0111";  -- 7
        B    <= "0001";  -- 1
        wait for 500 us;

        -- Suma c/ Saturador
        -- - Res: 7 (0111),
        -- - Carry: 0,
        -- - OFlow: 1
        Ctls <= "1101";
        wait for 500 us;

        -- Suma s/ Saturador
        -- - Res: 7 (0111),
        -- - Carry: 1,
        -- - OFlow: 1
        Ctls <= "1000";
        A    <= "1000";  -- -1
        B    <= "1111";  -- -8
        wait for 500 us;

        -- Suma c/ Saturador
        -- - Res: -8 (1000),
        -- - Carry: 1,
        -- - OFlow: 1
        Ctls <= "1101";
        wait for 500 us;
        
        -- Resta s/ Saturador
        -- - Res: -1 (1111),
        -- - Carry: 0,
        -- - OFlow: 0
        Ctls <= "1010";
        A    <= "0001";  -- 1
        B    <= "0010";  -- 2
        wait for 500 us;

        -- Resta c/ Saturador
        -- - Res: 3 (0011),
        -- - Carry: 0,
        -- - OFlow: 0
        Ctls <= "1111";
        wait for 500 us;

        -- Resta s/ Saturador
        -- - Res: 2 (0010),
        -- - Carry: 1,
        -- - OFlow: 0
        Ctls <= "1011";
        A    <= "0011";  -- 3
        B    <= "0001";  -- 1
        wait for 500 us;

        -- Resta c/ Saturador
        -- - Res: -2 (1110),
        -- - Carry: 1,
        -- - OFlow: 0
        Ctls <= "1110";
        wait for 500 us;

        -- Resta s/ Saturador
        -- - Res: -8 (1000),
        -- - Carry: 0,
        -- - OFlow: 1
        Ctls <= "1010";
        A    <= "0111";  --  7
        B    <= "1111";  -- -1
        wait for 500 us;

        -- Resta c/ Saturador
        -- - Res: 7 (0111),
        -- - Carry: 0,
        -- - OFlow: 1
        Ctls <= "1111";
        wait for 500 us;

        -- Resta s/ Saturador
        -- - Res: 7 (0111),
        -- - Carry: 1,
        -- - OFlow: 1
        Ctls <= "1010";
        A    <= "1000";  -- -8
        B    <= "0001";  --  1
        wait for 500 us;

        -- Resta c/ Saturador
        -- - Res: -8 (1000),
        -- - Carry: 1,
        -- - OFlow: 1
        Ctls <= "1111";
        wait for 500 us;

        ------------
        -- Lógica --
        ------------

        -- OR bit a bit
        -- - Res: 1111,
        -- - Carry: 0,
        -- - OFlow: 0
        Ctls <= "0100";
        A    <= "1010";
        B    <= "0101";
        wait for 500 us;

        -- AND bit a bit
        -- - Res: 0000,
        -- - Carry: 0,
        -- - OFlow: 0
        Ctls <= "0011";
        wait for 500 us;

        ---------
        -- Fin --
        ---------

        std.env.stop;
    
    end process Simulacion;
end Behavioral;
