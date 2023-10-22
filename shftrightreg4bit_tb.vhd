library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shftrightreg4bit_tb is
end;

architecture rtl of shftrightreg4bit_tb is
  signal clk_tb      : std_logic;
  signal reset_tb    : std_logic;
  signal load_tb   : std_logic;
  signal data_in_tb  : std_logic_vector(3 downto 0);
  signal data_out_tb : std_logic_vector(3 downto 0);
  signal shift_tb    : std_logic;

  signal sim_end  : boolean := false;
  constant period : time    := 50 ns;
begin
  uut : entity work.shftrightreg4bit
    port map
    (
      clk      => clk_tb,
      rst    => reset_tb,
      load     => load_tb,
      data_in  => data_in_tb,
      data_out => data_out_tb,
      shift    => shift_tb
    );

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
    reset_tb <= '1';
    wait for period;

    -- shifting test
    reset_tb  <= '0';
    load_tb <= '1';
    shift_tb  <= '0';
    for i in 0 to 15 loop
      data_in_tb <= std_logic_vector(to_unsigned(i, 4));
      wait for period;
    end loop;

    data_in_tb <= "0000";
    reset_tb <= '1';
    wait for period;

    -- non-shifting test
    load_tb <= '1';
    shift_tb  <= '1';
    reset_tb  <= '0';
    for i in 0 to 15 loop
      data_in_tb <= std_logic_vector(to_unsigned(i, 4));
      wait for period;
    end loop;

    sim_end <= true;
    wait;
  end process;

end rtl;