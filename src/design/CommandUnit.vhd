----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/02/2019 04:06:29 PM
-- Design Name: 
-- Module Name: CommandUnit - Dataflow
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CommandUnit is
    Port ( clock, ce, reset, tc, m, s, start_stop : in STD_LOGIC;
           command : out STD_LOGIC_VECTOR (3 downto 0));
end CommandUnit;

architecture Behavioral of CommandUnit is
    signal address, data : STD_LOGIC_VECTOR (7 downto 0);
    signal next_state : STD_LOGIC_VECTOR (1 downto 0);
begin

    command <= data(3 downto 0);  
    address(0) <= start_stop;
    address(1) <= s;
    address(2) <= m;
    address(3) <= tc;  
    address(5 downto 4) <= next_state;
    address(7 downto 6) <= "00";
    
    NextStateRegister: process(clock, reset)
        variable next_state_int : STD_LOGIC_VECTOR (1 downto 0);
    begin
        if reset = '1' then
            next_state_int := (others => '0');
        elsif clock = '1' and clock'Event then
            if ce = '1' then
                next_state_int := data(5 downto 4);
           end if;
        end if;
        next_state <= next_state_int;
    end process NextStateRegister;
    
    ROM: process(address)
        variable address_int : INTEGER;
    begin
        address_int := conv_integer(address);
        case address_int is
            when 16#00# | 16#08# | 16#21# | 16#28# to 16#2F# | 16#38# to 16#3F# => data <= x"00";            
            when 16#06# | 16#07# | 16#0E# | 16#0F# | 16#16# | 16#17# | 16#1E# | 16#1F# | 16#26# | 16#27# | 16#36# | 16#37# => data <= x"01";
            when 16#10# | 16#18# | 16#31# => data <= x"10";  
            when 16#04# | 16#05# | 16#0C# | 16#0D# | 16#14# | 16#15# | 16#1C# | 16#1D# | 16#24# | 16#25# | 16#34# | 16#35# => data <= x"14";  
            when 16#02# | 16#03# | 16#0A# | 16#0B# | 16#12# | 16#13# | 16#1A# | 16#1B# | 16#22# | 16#23# | 16#32# | 16#33# => data <= x"18";  
            when 16#01# | 16#09# | 16#20# => data <= x"28";  
            when 16#11# | 16#19# | 16#30# => data <= x"3A";  
            when others => data <= x"00";
        end case;
    end process ROM;

end Behavioral;
