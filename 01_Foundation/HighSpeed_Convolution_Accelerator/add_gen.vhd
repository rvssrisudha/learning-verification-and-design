--Sri sudha Renduchintala
--Monica Sheethal Gurakala
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.config_pkg.all;
use work.user_pkg.all;

entity addr_generator is
  generic(width:positive:=15);
  port (
      clk          : in std_logic;
	rst        : in std_logic;
	go         : in std_logic;
    size       : in std_logic_vector(16 downto 0);
	dram_start_addr : in std_logic_vector(14 downto 0);
	stall      : in std_logic;
	ready_d      : in std_logic;
	valid_out      : out std_logic; 
	addr_out       : out std_logic_vector(14 downto 0)
	);
end addr_generator;

architecture bhv of addr_generator is
 type state_type is (START, INIT, IMPLEMENTATION);
 signal count, next_count : unsigned(16 downto 0);
 signal state, next_state : state_type;
 signal size_delay, next_size_d : unsigned(16 downto 0);
 signal address, next_address : std_logic_vector(14 downto 0);
  
 begin
  process(clk, rst)
   begin  
    if (rst = '1') then
	 address    <= (others => '0');
	 size_delay     <= (others => '0');
	 count      <= (others => '0');
	 state      <= START;
	 
	elsif (rising_edge(clk)) then
	 address   <= next_address;
	 size_delay   <= next_size_d;
	 count     <= next_count;
	 state     <= next_state;
	end if;
	end process;
	
  process(stall, go, size_delay, address, state, size, dram_start_addr, count, ready_d)
   begin 
   
    next_state    <= state;
    next_address  <= address;
    next_size_d   <= size_delay;
    next_count    <= count;
    addr_out          <= address;
    valid_out         <= '0';

     case state is 
      when START =>
             next_count <= (others => '0');
             next_address <= dram_start_addr;
             if(go = '1') then
               next_state <= INIT;
             end if;

      when INIT =>

       if(size(0) = '1') then
                next_size_d  <= unsigned( '0' & size(16 downto 1) ) + 1;
        else 
                next_size_d  <= unsigned('0' & size(16 downto 1) );
        end if;

          next_state    <= IMPLEMENTATION;

	
	  when IMPLEMENTATION =>

            if(unsigned(count) = unsigned(size_delay)) then
		
			 next_state    <= START;
            elsif (stall = '0' and ready_d = '1' ) then
		
			valid_out <= '1';
			next_count  <=count+1;
			next_address <= std_logic_vector(unsigned(address)+1);
		      addr_out <= std_logic_vector(address);
        end if;		
	  when others => null;
	  end case;
	end process;
	  
end bhv;