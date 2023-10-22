library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity complementer4bit_tb is
end;

architecture rtl of complementer4bit_tb is
  signal data_in_tb, data_out_tb : std_logic_vector(3 downto 0);

  constant period : time := 50 ns;
begin
  uut : entity work.complementer4bit
    port map
    (
      data_in  => data_in_tb,
      data_out => data_out_tb
    );

  stim_proc : process
  begin
    for i in -8 to 7 loop
      data_in_tb <= std_logic_vector(to_signed(i, 4));
      wait for period;
    end loop;

    wait;
  end process;

end rtl;