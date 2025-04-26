-- Sri Sudha Renuchintala
--Monica Sheethal Gurakala

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity dual_ff_2 is
port( 
        clk     :  in std_logic;
	  rst     :  in std_logic;
	  input   :  in std_logic;
	  output  :  out std_logic
	) ;
end dual_ff_2;

architecture bhv of dual_ff_2 is

begin
process(clk,rst)
  begin 
  if (rst='1') then
     output<='0';
	
  elsif(clk'event and clk = '1') then
     output<=input;
    
end if;
end process;
end bhv;	 