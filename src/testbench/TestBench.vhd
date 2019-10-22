----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2019 06:52:16 PM
-- Design Name: 
-- Module Name: TestBench - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TestBench is
--  Port ( );
end TestBench;

architecture Behavioral of TestBench is    
    signal clock, ce, reset, m, s, start_stop : STD_LOGIC;
    signal alarm : STD_LOGIC;
    signal alarm_length : STD_LOGIC_VECTOR (3 downto 0);
    signal second0, second1, minute0, minute1 : STD_LOGIC_VECTOR (6 downto 0);
begin

    ce <= '1';    
    alarm_length <= "0011";
    reset <= '1', '0' after 10 ns;
    
    clock_gen: process
    begin
        if clock = 'U' then
            clock <= '0';
        else
            clock <= not clock;
        end if;
        wait for 5ns;
    end process clock_gen;
    
    stim_start_stop: process
    begin
        start_stop <= '0';
        --start
        wait for 20 ns;
        start_stop <= '1';
        wait for 10 ns;
        start_stop <= '0';
        --pause
        wait for 20 ns;
        start_stop <= '1';
        wait for 30 ns;
        start_stop <= '0';
        --resume
        wait for 20 ns;
        start_stop <= '1';
        wait for 10 ns;
        start_stop <= '0';
        --count down
        wait for 70 ns;
        start_stop <= '1';
        wait for 10 ns;
        start_stop <= '0';
         --pause count down
        wait for 30 ns;
        start_stop <= '1';
        wait for 10 ns;
        start_stop <= '0';
        --resume count down
        wait for 30 ns;
        start_stop <= '1';
        wait for 10 ns;
        start_stop <= '0';
         --count down after inc m
        wait for 100 ns;
        start_stop <= '1';
        wait for 10 ns;
        start_stop <= '0';
        --count up until max
        wait for 30 ns;
        start_stop <= '1';
        wait for 10 ns;
        start_stop <= '0';
        
        wait;
    end process stim_start_stop;
    
    stim_s: process
    begin
        s <= '0';
        --wait for counting up
        wait for 150 ns;
        s <= '1';
        wait for 10 ns;
        s <= '0';
        
        --reset
        wait for 240 ns;
        s <= '1';
        wait for 10 ns;
        s <= '0';
        wait;
    end process stim_s;
    
    stim_m: process
    begin
        
        m <= '0';
        --inc m
        wait for 330 ns;
        m <= '1';
        wait for 30 ns;
        m <= '0';
        --reset 
        wait for 40 ns;
        m <= '1';
        wait for 10 ns;
        m <= '0';
        wait;
    end process stim_m;
        
    
    UUT: entity WORK.Timer(Structural) port map(
        clock => clock,
        ce => ce,
        reset => reset,
        m => m,
        s => s,
        start_stop => start_stop,
        alarm_length => alarm_length,
        alarm => alarm,
        second0 => second0,
        second1 => second1,
        minute0 => minute0,
        minute1 => minute1
    );

end Behavioral;
