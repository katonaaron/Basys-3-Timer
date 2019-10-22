----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/10/2019 04:42:43 PM
-- Design Name: 
-- Module Name: Timer - Structural
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

entity Timer is
    Port ( clock, ce, reset, m, s, start_stop : in STD_LOGIC;
           alarm_length : in STD_LOGIC_VECTOR (3 downto 0);
           alarm : out STD_LOGIC;
           second0, second1, minute0, minute1 : out STD_LOGIC_VECTOR (6 downto 0));
end Timer;

architecture Structural of Timer is

    component CommandUnit is
        Port ( clock, ce, reset, tc, m, s, start_stop : in STD_LOGIC;
               command : out STD_LOGIC_VECTOR (3 downto 0));
    end component CommandUnit;
    
    component ExecutionUnit is
        Port ( clock, ce, reset : in STD_LOGIC;
               command, alarm_length : in STD_LOGIC_VECTOR (3 downto 0);
               tc, alarm : out STD_LOGIC;
               second0, second1, minute0, minute1 : out STD_LOGIC_VECTOR (6 downto 0));
    end component ExecutionUnit;
    
    signal tc : STD_LOGIC;
    signal command_int : STD_LOGIC_VECTOR (3 downto 0);
begin

    CU: CommandUnit port map (clock => clock, ce => ce, reset => reset, tc => tc, m => m, 
                              s => s, start_stop => start_stop, command => command_int);
    EU: ExecutionUnit port map (
        clock => clock,
        ce => ce, 
        reset => reset, 
        command => command_int, 
        alarm_length => alarm_length,
        tc => tc, 
        alarm => alarm,
        second0 => second0, 
        second1 => second1, 
        minute0 => minute0, 
        minute1 => minute1
    );

end Structural;
