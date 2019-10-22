----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/03/2019 12:32:50 PM
-- Design Name: 
-- Module Name: FrequencyDivider - Structural
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

entity FrequencyDivider is
    Generic( MAX_COUNT : NATURAL := 10);
    Port ( clock, reset : in STD_LOGIC;
           clock_out : out STD_LOGIC);
end FrequencyDivider;

architecture Behavioral of FrequencyDivider is
    signal count : NATURAL;
    signal clock_int : STD_LOGIC;
begin
    
    clock_out <= clock_int;
    
    Counter: process(reset, clock)
    begin
        if reset = '1' then
            count <= 1;
            clock_int <= '0';
        elsif clock'event and clock = '1' then
            count <= count + 1;
            if count = MAX_COUNT then
                count <= 1;
                clock_int <= not clock_int;        
            end if;
        end if;
    end process;

end Behavioral;
