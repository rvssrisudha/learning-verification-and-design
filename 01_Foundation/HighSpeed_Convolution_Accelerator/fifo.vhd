--Sri Sudha Renduchintala
--Monica Sheethal Gurakala
library ieee;
use ieee.std_logic_1164.all;

entity fifo is
    port (
        wr_clk      : in  std_logic;
        rd_clk      : in  std_logic;
        rst         : in  std_logic; 
        empty       : out std_logic;
        full        : out std_logic;
        prog_full   : out std_logic;
        rd_en       : in  std_logic;
        wr_en       : in  std_logic;
        din     : in  std_logic_vector(31 downto 0);
        dout    : out std_logic_vector(15 downto 0);
	  wr_rst_busy : out std_logic;
	  rd_rst_busy : out std_logic
		);
end fifo;


architecture STR of fifo is
 

COMPONENT fifo_generator_3
  PORT (
    rst : IN STD_LOGIC;
    wr_clk : IN STD_LOGIC;
    rd_clk : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC;
    prog_full : OUT STD_LOGIC;
    wr_rst_busy : OUT STD_LOGIC;
    rd_rst_busy : OUT STD_LOGIC
  );
END COMPONENT;

begin
  U_FIFO : fifo_generator_3
  PORT MAP (
    rst => rst,
    wr_clk => wr_clk,
    rd_clk => rd_clk,
    din => din,
    wr_en => wr_en,
    rd_en => rd_en,
    dout => dout,
    full => full,
    empty => empty,
    prog_full => prog_full,
    wr_rst_busy => wr_rst_busy,
    rd_rst_busy => rd_rst_busy
  );
  
  
  end STR;