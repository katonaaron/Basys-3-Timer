----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/03/2019 11:41:32 AM
-- Design Name: 
-- Module Name: MSCounter - Dataflow
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

entity MSCounter is
    Port ( clock, ce, reset, dir, m, s : in STD_LOGIC;
           tc : out STD_LOGIC;
           second0, second1, minute0, minute1 : out STD_LOGIC_VECTOR (3 downto 0));
end MSCounter;

architecture Dataflow of MSCounter is
    component Counter is
        Generic( P : INTEGER := 10;
                 SIZE : INTEGER := 4);	 
        Port ( clock, ce, reset, dir : in  STD_LOGIC;
               tc : out  STD_LOGIC;
               q : out  STD_LOGIC_VECTOR (SIZE - 1 downto 0));
    end component Counter;
    
    signal ce_int, tc_int : STD_LOGIC_VECTOR (3 downto 0);
begin
    
    ce_int(0) <= ce and s;
    ce_int(1) <= ce and tc_int(0);
    ce_int(2) <= ce and (tc_int(1) or m);
    ce_int(3) <= ce and tc_int(2);
    tc <= tc_int(3);
    
    S0: Counter generic map(10, 4) port map(clock => clock, ce => ce_int(0), reset => reset, dir => dir, tc => tc_int(0), q => second0);
    S1: Counter generic map(6, 4) port map(clock => clock, ce => ce_int(1), reset => reset, dir => dir, tc => tc_int(1), q => second1);
    M0: Counter generic map(10, 4) port map(clock => clock, ce => ce_int(2), reset => reset, dir => dir, tc => tc_int(2), q => minute0);
    M1: Counter generic map(10, 4) port map(clock => clock, ce => ce_int(3), reset => reset, dir => dir, tc => tc_int(3), q => minute1);
end Dataflow;
