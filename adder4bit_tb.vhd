library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder4bit_tb is
end;

architecture test of adder4bit_tb is
  signal a      : std_logic_vector(3 downto 0);
  signal b      : std_logic_vector(3 downto 0);
  signal sum    : std_logic_vector(7 downto 0);
  signal cout   : std_logic;
  signal sub_op : std_logic;
begin
  uut : entity work.adder4bit port map
    (
    a      => a,
    b      => b,
    sum    => sum,
    cout   => cout,
    sub_op => sub_op
    );

  stim_proc : process
  begin
    sub_op <= '0';
    for i in -8 to 7 loop
      a <= std_logic_vector(to_signed(i, 4));
      for j in -8 to 7 loop
        b   <= std_logic_vector(to_signed(j, 4));
        wait for 10 ns;
      end loop;
    end loop;

    a <= "0000";
    b <= "0000";
    wait for 50 ns;

    sub_op <= '1';
    for i in -8 to 7 loop
      a <= std_logic_vector(to_signed(i, 4));
      for j in -8 to 7 loop
        b   <= std_logic_vector(to_signed(j, 4));
        wait for 10 ns;
      end loop;
    end loop;

    wait;
  end process;
end;