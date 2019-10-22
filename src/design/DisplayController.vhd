----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:09:21 03/27/2019 
-- Design Name: 
-- Module Name:    DisplayController - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DisplayController is
    Port ( clock, ce : in  STD_LOGIC;
           second0, second1, minute0, minute1 : in  STD_LOGIC_VECTOR (6 downto 0);
           cathodes : out  STD_LOGIC_VECTOR (6 downto 0);
           anodes : out  STD_LOGIC_VECTOR (3 downto 0);
           dp : out  STD_LOGIC);
end DisplayController;

architecture Behavioral of DisplayController is
    component FrequencyDivider is
        Generic( MAX_COUNT : NATURAL := 10;
                 SIZE : NATURAL := 4);
        Port ( clock, ce : in STD_LOGIC;
               clock_out : out STD_LOGIC);
    end component FrequencyDivider;
begin
	
	dp <= '1';
	
	RefreshDisplay: process(clock)
	   variable anodes_int : STD_LOGIC_VECTOR (3 downto 0);
	   variable cathodes_int: STD_LOGIC_VECTOR (6 downto 0);
	begin
		if clock'EVENT and clock = '1' then
            if ce = '1' then
                case anodes_int is
                    when "1110" =>
                        anodes_int := "1101";
                        cathodes_int := second1;
                    when "1101" =>
                        anodes_int := "1011";
                        cathodes_int := minute0;
                    when "1011" =>
                        anodes_int := "0111";
                        cathodes_int := minute1;
                    when others =>
                        anodes_int := "1110";
                        cathodes_int := second0;
                end case;
            end if;
		end if;
		anodes <= anodes_int;
		cathodes <= cathodes_int;
	end process RefreshDisplay;
end Behavioral;

