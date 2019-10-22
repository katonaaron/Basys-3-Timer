----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/10/2019 05:30:29 PM
-- Design Name: 
-- Module Name: SignalExtender - Dataflow
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SignalExtender is
    Port ( clock, ce, reset, input_signal : in STD_LOGIC;
           length : in STD_LOGIC_VECTOR (3 downto 0);
           extended_signal : out STD_LOGIC);
end SignalExtender;

architecture Behavioral of SignalExtender is

begin

    Counter: process(clock, reset, length)
        variable output, increment : STD_LOGIC;
        variable q : STD_LOGIC_VECTOR(3 downto 0);
    begin
        if reset = '1' then
            q := "0000";
            output := '0';
            increment := '0';
        elsif clock'event and clock = '1' then
            if ce = '1' then
                if input_signal = '1' then
                    increment := '1';
                    q := "0000";
                end if;
                if increment = '1' and q < length then
                    output := '1';
                    q := q + 1;
                else
                    output := '0';
                    increment := '0';
                end if;
            end if;
        end if;                        
        extended_signal <= output;
    end process Counter;
    

end Behavioral;
