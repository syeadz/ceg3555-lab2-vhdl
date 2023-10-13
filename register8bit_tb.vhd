library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register8bit_tb is
end register8bit_tb;

architecture rtl of register8bit_tb is
  signal clk_tb      : std_logic;
  signal reset_tb    : std_logic;
  signal enable_tb   : std_logic;
  signal data_in_tb  : std_logic_vector(7 downto 0);
  signal data_out_tb : std_logic_vector(7 downto 0);

  signal sim_end  : boolean := false;
  constant period : time    := 50 ns;
begin
  uut : entity work.register8bit
    port map
    (
      clk      => clk_tb,
      reset    => reset_tb,
      enable   => enable_tb,
      data_in  => data_in_tb,
      data_out => data_out_tb
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
    enable_tb <= '0';
    reset_tb  <= '1', '0' after period;
    wait for period;
    assert data_out_tb = "00000000" report "Data mismatch at reset" severity error;

    data_in_tb <= "00000001";
    wait for period;
    assert data_out_tb = "00000000" report "Data mismatch at reset" severity error;

    wait for period/2;
    enable_tb <= '1';
    wait for period/2;
    assert data_out_tb = "00000000" report "Data mismatch at clock off" severity error;

    wait for period;
    assert data_out_tb = "00000001" report "Data mismatch at clock on, enable on" severity error;

    reset_tb <= '1';
    wait for period;
    assert data_out_tb = "00000000" report "Data mismatch at reset" severity error;

    reset_tb <= '0';

    enable_tb  <= '0';
    data_in_tb <= "00000010";
    wait for period;
    assert data_out_tb = "00000000" report "Data mismatch at enable off" severity error;

    data_in_tb <= "00000000";
    wait for period;

    enable_tb <= '1';
    for i in 0 to 255 loop
      data_in_tb <= std_logic_vector(to_unsigned(i, 8));
      assert data_out_tb = data_in_tb report "Data mismatch at address " & integer'image(i) severity error;
      wait for period;
    end loop;

    sim_end <= true;
    wait;
  end process;

end rtl;