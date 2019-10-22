----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:12:11 03/27/2019 
-- Design Name: 
-- Module Name:    Debouncer - Behavioral 
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

entity Debouncer is
	 Generic( counter_size : INTEGER := 20);
    Port ( clock, ce, button : in  STD_LOGIC;
           button_out : out  STD_LOGIC);
end Debouncer;

architecture Behavioral of Debouncer is
begin
	
	process(clock)
	   variable counter: STD_LOGIC_VECTOR(counter_size downto 0) := (others => '0');
	   variable output: STD_LOGIC := '0';
	   variable flip_flops: STD_LOGIC_VECTOR(1 downto 0);
	begin		
		if clock'EVENT and clock = '1' then	
            if ce = '1' then		
                if (flip_flops(0) xor flip_flops(1))  = '1' then
                    counter := (others => '0');
                else
                    if counter(counter_size) = '0' then
                        counter := counter + 1;
                    else
                        output := flip_flops(1);
                    end if;
                end if;
			end if;			
			flip_flops(1) := flip_flops(0);
			flip_flops(0) := button;
		end if;
		button_out <= output;
	end process;
	
end Behavioral;