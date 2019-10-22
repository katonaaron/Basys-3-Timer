----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/03/2019 01:37:43 PM
-- Design Name: 
-- Module Name: ExecutionUnit - Dataflow
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

entity ExecutionUnit is
    Port ( clock, ce, reset : in STD_LOGIC;
           command, alarm_length : in STD_LOGIC_VECTOR (3 downto 0);
           tc, alarm : out STD_LOGIC;
           second0, second1, minute0, minute1 : out STD_LOGIC_VECTOR (6 downto 0));
end ExecutionUnit;

architecture Dataflow of ExecutionUnit is
    component MSCounter is
        Port ( clock, ce, reset, dir, m, s : in STD_LOGIC;
               tc : out STD_LOGIC;
               second0, second1, minute0, minute1 : out STD_LOGIC_VECTOR (3 downto 0));
    end component MSCounter;
    component BCD7Segment is
        Port ( bcd : in  STD_LOGIC_VECTOR (3 downto 0);
               seven_segment : out  STD_LOGIC_VECTOR (6 downto 0));
    end component BCD7Segment;
    component SignalExtender is
        Port ( clock, ce, reset, input_signal : in STD_LOGIC;
               length : in STD_LOGIC_VECTOR (3 downto 0);
               extended_signal : out STD_LOGIC);
    end component SignalExtender;
    
    signal reset_int, last_dir, start_alarm : STD_LOGIC;
    signal s0, s1, m0, m1 : STD_LOGIC_VECTOR (3 downto 0);
begin

    reset_int <= reset or command(0);
    start_alarm <= '1' when command(1) = '1' and  m1&m0&s1&s0 = x"0001" else '0';
    
    Counters: MSCounter port map(clock => clock, ce => ce, reset => reset_int, dir => command(1), m => command(2), s => command(3),
                              second0 => s0, second1 => s1, minute0 => m0, minute1 => m1);
    
    Conv0: BCD7Segment port map(bcd => s0, seven_segment => second0);
    Conv1: BCD7Segment port map(bcd => s1, seven_segment => second1);
    Conv2: BCD7Segment port map(bcd => m0, seven_segment => minute0);
    Conv3: BCD7Segment port map(bcd => m1, seven_segment => minute1);
    
    AlarmExtender: SignalExtender port map(
        clock => clock,
        ce => ce,
        reset => reset_int,
        input_signal => start_alarm,
        length => alarm_length,
        extended_signal => alarm
    );
    
    DelayTC: process(clock, reset_int)
        variable tc_int : STD_LOGIC;
    begin
        if reset_int = '1' then
            tc_int := '0';
        elsif clock'event and clock = '1' then
            if ce = '1' then
                tc_int := '0';
                case command(1) is
                    when '1' =>
                        if m1&m0&s1&s0 = x"0001" then
                            tc_int := '1';
                        end if;
                    when others =>
                        if m1&m0&s1&s0 = x"9959" then
                            tc_int := '1';
                        end if;
                end case;
            end if;
        end if;
        tc <= tc_int;            
    end process;

end Dataflow;
