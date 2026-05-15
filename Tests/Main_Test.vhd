----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/11/2026 11:34:13 PM
-- Design Name: 
-- Module Name: TP3_Test - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.ALL;


entity Main_Test is
end Main_Test;

architecture Behavioral of Main_Test is
    
    component Main is
        Port (
            Ext:  in  std_logic;
            A:    in  std_logic_vector (3 downto 0);
            B:    in  std_logic_vector (3 downto 0);
            Btns: in  std_logic_vector (4 downto 0);
            LEDs: out std_logic_vector (9 downto 0);
            Cato: out std_logic_vector (6 downto 0);
            Anod: out std_logic_vector (3 downto 0)
        );
    end component;
    
    signal Ext:  std_logic := '1';
    signal A:    std_logic_vector (3 downto 0) := "0001";
    signal B:    std_logic_vector (3 downto 0) := "0010";
    signal Btns: std_logic_vector (4 downto 0) := "00000";
    signal LEDs: std_logic_vector (9 downto 0);
    signal Cato: std_logic_vector (6 downto 0);
    signal Anod: std_logic_vector (3 downto 0);
    
begin
    
    DUT: Main port map(
        Ext => Ext,
        A => A,
        B => B,
        Btns => Btns,
        LEDs => LEDs,
        Cato  => Cato,
        Anod  => Anod
    );
    
    Clock: process begin
        Ext <= not(Ext);
        wait for 5 ns;
    end process Clock;
    
    Simulacion: process begin
        Btns <= "01110"; -- Cambia a Resta
        wait for 30 ms;
        Btns <= "00000";
        wait for 30 ms;
        
        Btns <= "10000"; -- Cambia variable del display
        wait for 30 ms;
        Btns <= "00000";
        wait for 30 ms;
        
        Btns <= "10000"; -- Cambia variable del display
        wait for 30 ms;
        Btns <= "00000";
        wait for 30 ms;
        
        Btns <= "00010"; -- Cambia a Suma
        wait for 30 ms;
        Btns <= "00000";
        wait for 30 ms;
        std.env.stop;
    end process Simulacion;
    
end Behavioral;
