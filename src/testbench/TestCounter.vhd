----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2019 11:13:46 PM
-- Design Name: 
-- Module Name: TestCounter - Behavioral
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

entity TestCounter is
--  Port ( );
end TestCounter;

architecture Behavioral of TestCounter is
    component MSCounter is
        Port ( clock, ce, reset, dir, m, s : in STD_LOGIC;
               tc : out STD_LOGIC;
               second0, second1, minute0, minute1 : out STD_LOGIC_VECTOR (3 downto 0));
    end component MSCounter;
    
    signal clock, ce, reset, dir, m, s, tc : STD_LOGIC;
    signal second0, second1, minute0, minute1 : STD_LOGIC_VECTOR (3 downto 0);
begin
    ce <= '1';
    reset <= '1', '0' after 10 ns;
    dir <= '0', '1' after 115 ns;
    s <= '1', '0' after 105 ns, '1' after 115 ns;
    m <= '0';
    
    
    clock_gen: process
    begin
        if clock = 'U' then
            clock <= '0';
        else
            clock <= not clock;
        end if;
        wait for 5ns;
    end process clock_gen;
    
    UUT: MSCounter port map(
        clock => clock,
        ce => ce,
        reset => reset,
        dir => dir,
        m => m,
        s => s,
        tc => tc,
        second0 => second0,
        second1 => second1,
        minute0 => minute0,
        minute1 => minute1
    );

end Behavioral;
