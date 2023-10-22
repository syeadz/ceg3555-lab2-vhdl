library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comparator4bit_tb is
end;

architecture rtl of comparator4bit_tb is
  signal a_tb, b_tb                    : std_logic_vector(3 downto 0);
  signal greater_tb, equal_tb, less_tb : std_logic;

  signal sim_end  : boolean := false;
  constant period : time    := 50 ns;
begin
  uut : entity work.comparator4bit
    port map
    (
      a       => a_tb,
      b       => b_tb,
      greater => greater_tb,
      equal   => equal_tb,
      less    => less_tb
    );

  stim_proc : process
  begin
    for i in 0 to 15 loop
      for j in 0 to 15 loop
        a_tb <= std_logic_vector(to_unsigned(i, 4));
        b_tb <= std_logic_vector(to_unsigned(j, 4));
        wait for period;
      end loop;
    end loop;

    wait;
  end process;

end rtl;