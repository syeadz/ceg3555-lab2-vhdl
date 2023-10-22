library ieee;
use ieee.std_logic_1164.all;

entity counter4bit is
  port
  (
    clk, load, reset : in std_logic;
    count            : out std_logic_vector(3 downto 0)
  );
end;

architecture rtl of counter4bit is
  signal not_reset     : std_logic;
  signal count_low     : std_logic_vector(1 downto 0);
  signal count_high    : std_logic_vector(1 downto 0);
  signal count_high_on : std_logic;
begin
  not_reset <= not reset;

  counter_low : entity work.counter port map
    (
    i_resetBar => not_reset,
    i_load     => load,
    i_clock    => clk,
    o_Value    => count_low);

  count_high_on <= count_low(1) and count_low(0) and load;

  counter_high : entity work.counter port
    map
    (
    i_resetBar => not_reset,
    i_load     => count_high_on,
    i_clock    => clk,
    o_Value    => count_high);

count <= count_high & count_low;

end architecture;