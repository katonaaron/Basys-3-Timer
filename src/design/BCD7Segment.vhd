----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:48:01 03/27/2019 
-- Design Name: 
-- Module Name:    BCD7Segment - Behavioral 
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

entity BCD7Segment is
    Port ( bcd : in  STD_LOGIC_VECTOR (3 downto 0);
           seven_segment : out  STD_LOGIC_VECTOR (6 downto 0));
end BCD7Segment;

architecture Behavioral of BCD7Segment is
begin
	process(bcd)
	   variable seven_segment_int : STD_LOGIC_VECTOR (6 downto 0);
	begin
		case bcd is
			when "0001" => seven_segment_int := "1001111";
			when "0010" => seven_segment_int := "0010010";
			when "0011" => seven_segment_int := "0000110";
			when "0100" => seven_segment_int := "1001100";
			when "0101" => seven_segment_int := "0100100";
			when "0110" => seven_segment_int := "0100000";
			when "0111" => seven_segment_int := "0001111";
			when "1000" => seven_segment_int := "0000000";
			when "1001" => seven_segment_int := "0000100";
			when others => seven_segment_int := "0000001";
		end case;
		seven_segment <= seven_segment_int;
	end process;
end Behavioral;

