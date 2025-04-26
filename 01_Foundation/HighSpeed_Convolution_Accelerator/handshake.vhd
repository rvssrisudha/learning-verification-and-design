-- Sri Sudha Renuchintala
--Monica Sheethal Gurakala

library ieee;
use ieee.std_logic_1164.all;

entity handshake is
    port (
        clk_src   : in  std_logic;
        clk_dest  : in  std_logic;
        rst       : in  std_logic;
        go        : in  std_logic;
        delay_ack : in  std_logic;
        rcv       : out std_logic;
        ack       : out std_logic
        );
end handshake;



architecture TRANSITIONAL of handshake is

    type state_type is (S_READY, S_WAIT_FOR_ACK, S_RESET_ACK);
    type state_type2 is (S_READY, S_SEND_ACK, S_RESET_ACK);
    signal state_src  : state_type;
    signal state_dest : state_type2;

    signal send_r : std_logic;
    signal ack_s : std_logic;
    
    signal ack_d : std_logic;
    signal send_s : std_logic;
    signal out1,out2 : std_logic;

begin

    process(clk_src, rst)
    begin
        if (rst = '1') then
            state_src  <= S_READY;
            send_s <= '0';
            ack        <= '0';
        elsif (rising_edge(clk_src)) then

            ack <= '0';

            case state_src is
                when S_READY =>
                    if (go = '1') then
                        send_s <= '1';
                        state_src  <= S_WAIT_FOR_ACK;
                    end if;

                when S_WAIT_FOR_ACK =>
                    if (ack_s = '1') then
                        send_s <= '0';
                        state_src  <= S_RESET_ACK;
                    end if;

                when S_RESET_ACK =>
                    if (ack_s = '0') then
                        ack       <= '1';
                        state_src <= S_READY;
                    end if;

                when others => null;
            end case;
        end if;
    end process;

  U_DUAL_FF_1:entity work.dual_ff_2
  port map(
  clk=>clk_dest,
  rst=>rst,
  input=>send_s,
  output=>out1
  );
  
  U_DUAL_FF_2:entity work.dual_ff_2
  port map(
  clk=>clk_dest,
  rst=>rst,
  input=>out1,
  output=>send_r
  );


    process(clk_dest, rst)
    begin
        if (rst = '1') then
            state_dest <= S_READY;
            ack_d <= '0';
            rcv        <= '0';
        elsif (rising_edge(clk_dest)) then

            rcv <= '0';

            case state_dest is
                when S_READY =>
                   
                    if (send_r = '1') then
                        rcv        <= '1';
                        state_dest <= S_SEND_ACK;
                    end if;

                when S_SEND_ACK =>
                    if (delay_ack = '0') then
                        ack_d <= '1';
                        state_dest <= S_RESET_ACK;
                    end if;

                when S_RESET_ACK =>
                    if (send_r = '0') then
                        ack_d <= '0';
                        state_dest <= S_READY;
                    end if;

                when others => null;
            end case;
        end if;
    end process;
    
  U_DUAL_FF_3:entity work.dual_ff_2
  port map(
  clk=>clk_src,
  rst=>rst,
  input=>ack_d,
  output=>out2
  );
  
  
  
  U_DUAL_FF_4:entity work.dual_ff_2
  port map(
  clk=>clk_src,
  rst=>rst,
  input=>out2,
  output=>ack_s
  );


end TRANSITIONAL;
