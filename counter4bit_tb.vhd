library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter4bit_tb is
end;

architecture rtl of counter4bit_tb is
  signal clk_tb       : std_logic;
  signal reset_tb     : std_logic;
  signal load_tb      : std_logic;
  signal count_tb  : std_logic_vector(3 downto 0);

  signal sim_end  : boolean := false;
  constant period : time    := 50 ns;
begin
  uut : entity work.counter4bit
    port map
    (
      reset => reset_tb,
      load  => load_tb,
      clk   => clk_tb,
      count => count_tb);

  clock_process : process
  begin
    while (not sim_end) loop
      clk_tb <= '1';
      wait for period/2;
      clk_tb <= '0';
      wait for period/2;
    end loop;
    wait;
  end process;

  stim_proc : process
  begin
    load_tb  <= '0';
    reset_tb <= '1';
    wait for period;

    reset_tb <= '0';
    wait for period;

    load_tb <= '1';
    for i in 0 to 6 loop
      wait for period;
    end loop;

    load_tb <= '0';
    wait for period*2;

    reset_tb <= '1';
    wait for period;

    reset_tb <= '0';
    load_tb  <= '1';
    for i in 0 to 15 loop
      wait for period;
    end loop;

    sim_end <= true;
    wait;
  end process;

end rtl;