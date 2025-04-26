--Sri Sudha Renduchintala
--Monica Sheethal Gurakala

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.config_pkg.all;
use work.user_pkg.all;

entity dram_rd is
      port(  dram_clk   : in  std_logic;
             user_clk   : in  std_logic;
			 dram_rst   : in  std_logic;
			 user_rst	: in  std_logic;
            -- rst        : in  std_logic;
             --clear      : in  std_logic;
             go         : in  std_logic;
             rd_en      : in  std_logic;
             stall      : in  std_logic;
             start_addr : in  std_logic_vector(14 downto 0);
             size       : in  std_logic_vector(16 downto 0);
             valid      : out std_logic;
             data       : out std_logic_vector(15 downto 0);
             done       : out std_logic;
			 
			 -- debugging signals
             debug_count          : out std_logic_vector (16 downto 0);
             debug_dma_size       : out std_logic_vector (15 downto 0);
             debug_dma_start_addr : out std_logic_vector (14 downto 0);
             debug_dma_addr       : out std_logic_vector (14 downto 0);
             debug_dma_prog_full  : out std_logic;
             debug_dma_empty      : out std_logic;
			 			 
             dram_ready    : in  std_logic;
             dram_rd_en    : out std_logic;
             dram_rd_addr  : out std_logic_vector(14 downto 0);
             dram_rd_data  : in  std_logic_vector(31 downto 0);
             dram_rd_valid : in  std_logic
             --dram_rd_flush : out std_logic
             );
end dram_rd;

architecture STR of dram_rd is

signal rcv        : std_logic;
signal addr_here : std_logic_vector(14 downto 0);
signal addr_full    : std_logic;
signal full           : std_logic;
signal size_reg       : std_logic_vector(16 downto 0);
--signal addr_gen_done  : std_logic;
signal not_valid      : std_logic;
signal fifo_not_valid : std_logic;
--signal fifo_flush     : std_logic;
signal value1_local      : std_logic_vector(31 downto 0);
signal value2_local     : std_logic_vector(31 downto 0);


begin

process(user_clk, user_rst)
	begin
		if(user_rst = '1') then			
			size_reg      <= (others => '0');
			addr_here<= (others => '0');
		elsif(rising_edge(user_clk)) then
			if(go = '1') then
				addr_here  <= start_addr;
				size_reg        <= size;
			end if;
		end if;
	end process;  
	
	-- not_valid <= not fifo_not_valid;
	fifo_not_valid <= not not_valid;
valid <=  not not_valid; 	
value1_local <=  dram_rd_data(15 downto 0) & dram_rd_data(31 downto 16);	



U_ADDRESS: entity work.addr_generator
generic map(
			    width => 15)
  port map(	
	       clk          => dram_clk, 
             rst          =>dram_rst,
             go           =>rcv,
	       size         => size_reg,
             stall        =>addr_full,
             dram_start_addr   =>addr_here,
             ready_d        =>dram_ready,
             valid_out        =>dram_rd_en,
             addr_out         =>dram_rd_addr);
			



U_HANDSHAKE_GO: entity work.handshake
           port map(	
		 clk_src   => user_clk,
             clk_dest  => dram_clk,
             rst       => dram_rst,
             go        => go,
		 delay_ack => std_logic'('0'),
	       rcv 	     => rcv,	
		 ack       => open);

U_COUNTER: entity work.counter
        port map(
        clk  => user_clk,
        rst  => dram_rst,
        rd_en=> rd_en,
        size => size,
		fifo_valid => fifo_not_valid,
        done => done
         );
		 



U_FIFO_32_16: entity  work.fifo
  port map (
    rst => dram_rst,
    wr_clk => dram_clk,
    rd_clk => user_clk,
    din => value1_local,
    wr_en =>dram_rd_valid,
    rd_en => rd_en,
    dout =>data,
    full =>full,
    empty=> not_valid,
    prog_full => addr_full,
    wr_rst_busy => open,
    rd_rst_busy => open
  );	
 
		 
		 
end STR;