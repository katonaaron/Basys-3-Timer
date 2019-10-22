----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:45:04 03/27/2019 
-- Design Name: 
-- Module Name:    Counter - Dataflow 
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

use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Counter is
    Generic( P : INTEGER := 10;
			 SIZE : INTEGER := 4);	 
    Port ( clock, ce, reset, dir : in  STD_LOGIC;
           tc : out  STD_LOGIC;
           q : out  STD_LOGIC_VECTOR (SIZE - 1 downto 0));
end Counter;

architecture Behavioral of Counter is
    signal q_int : STD_LOGIC_VECTOR (SIZE - 1 downto 0);
begin
    tc <= '1' when reset = '0' and ce = '1' and ((dir = '0' and q_int = P - 1) or (dir = '1' and q_int = 0)) else 
          '0';
    q <= q_int;
    
	Count: process(reset, clock)
        variable q_int_v : STD_LOGIC_VECTOR(SIZE - 1 downto 0);
	begin		
        if reset = '1' then
			q_int_v := (others => '0');
		elsif clock'EVENT and clock = '1' then
            if ce = '1' then
                if dir = '0' then
                    if q_int_v = P - 1 then
                        q_int_v := (others => '0');
                    else
                        q_int_v := q_int_v + 1;
                    end if;
                else
                    if q_int_v = 0 then
                        q_int_v := conv_std_logic_vector(P - 1, SIZE);
                    else
                        q_int_v := q_int_v - 1;
                    end if;
                end if;
			end if;		
		end if;
		q_int <= q_int_v;
	end process Count;
end Behavioral;

