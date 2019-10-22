----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/25/2019 09:37:11 AM
-- Design Name: 
-- Module Name: Top - Dataflow
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

entity Top is
    Port ( clock, reset, m, s, start_stop : in STD_LOGIC;
           alarm_length : in STD_LOGIC_VECTOR (3 downto 0);
           cathodes : out  STD_LOGIC_VECTOR (6 downto 0);
           anodes : out  STD_LOGIC_VECTOR (3 downto 0);
           dp, alarm : out  STD_LOGIC);
end Top;

architecture Structural of Top is
    
    component FrequencyDivider is
        Generic( MAX_COUNT : NATURAL := 10);
        Port ( clock, reset : in STD_LOGIC;
               clock_out : out STD_LOGIC);
    end component FrequencyDivider;
    component DisplayController is
        Port ( clock, ce : in  STD_LOGIC;
               second0, second1, minute0, minute1 : in  STD_LOGIC_VECTOR (6 downto 0);
               cathodes : out  STD_LOGIC_VECTOR (6 downto 0);
               anodes : out  STD_LOGIC_VECTOR (3 downto 0);
               dp : out  STD_LOGIC);
    end component DisplayController;
    component Debouncer is
        Generic( counter_size : INTEGER := 19);
        Port ( clock, ce, button : in  STD_LOGIC;
               button_out : out  STD_LOGIC);
    end component Debouncer;
    component Timer is
        Port ( clock, ce, reset, m, s, start_stop : in STD_LOGIC;
               alarm_length : in STD_LOGIC_VECTOR (3 downto 0);
               alarm : out STD_LOGIC;
               second0, second1, minute0, minute1 : out STD_LOGIC_VECTOR (6 downto 0));
    end component Timer;
    
    signal clock_1s, clock_3ms, tc, m_int, s_int, start_stop_int : STD_LOGIC;
    signal command_int : STD_LOGIC_VECTOR (3 downto 0);
    signal second0, second1, minute0, minute1 : STD_LOGIC_VECTOR (6 downto 0);
begin

    FreqDiv1s: FrequencyDivider generic map(50_000_000) port map(clock => clock, reset => reset, clock_out => clock_1s);
    FreqDiv3ms: FrequencyDivider generic map(150_000) port map(clock => clock, reset => reset, clock_out => clock_3ms);
    
    BlackBox: Timer port map(
        clock => clock_1s, 
        ce => '1', 
        reset => reset, 
        m => m_int, 
        s => s_int, 
        start_stop => start_stop_int,
        alarm_length => alarm_length,
        alarm => alarm,
        second0 => second0, 
        second1 => second1, 
        minute0 => minute0,
        minute1 => minute1
     );
    
    Display: DisplayController port map(
        clock => clock_3ms, 
        ce => '1', 
        second0 => second0, 
        second1 => second1, 
        minute0 => minute0, 
        minute1 => minute1,
        cathodes => cathodes,
        anodes => anodes,
        dp => dp
    );
                                        
    DebounceS: Debouncer port map(clock => clock, ce => '1', button => s, button_out => s_int);
    DebounceM: Debouncer port map(clock => clock, ce => '1', button => m, button_out => m_int);
    DebounceStartStop: Debouncer port map(clock => clock, ce => '1', button => start_stop, button_out => start_stop_int);

end Structural;
