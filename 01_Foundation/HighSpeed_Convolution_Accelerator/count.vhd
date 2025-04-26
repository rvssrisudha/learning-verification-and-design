--Sri Sudha Renduchintala
--Monica Sheethal Gurakala
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.config_pkg.all;
use work.user_pkg.all;

entity counter is 
port(
clk        :in std_logic;
rst        :in std_logic;
rd_en      :in std_logic;
size       :in std_logic_vector(16 downto 0);
fifo_valid :in std_logic;
done       :out std_logic
);

end counter;

architecture bhv of counter is
begin

process(clk, rst)
  variable count_value : unsigned(16 downto 0);
	begin
		if rst = '1' then
			count_value:= (others => '0');
			done<='0';
		elsif(rising_edge(clk)) then
		
			done<='0';
			if(rd_en= '1' and fifo_valid='1') then
			
				if(count_value /= unsigned(size)) then
				
				count_value := count_value +1;
				done<='0';
			else
				count_value:= (others => '0');
				done<='1';
			end if;
		end if;
		end if;
end process;
	
end bhv;