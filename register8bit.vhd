library ieee;
use ieee.std_logic_1164.all;

entity register8bit is
  port
  (
    reset, load : in std_logic;
    clk         : in std_logic;
    data_in     : in std_logic_vector(7 downto 0);
    data_out    : out std_logic_vector(7 downto 0));
end;

architecture rtl of register8bit is
  signal int_Value, int_notValue : std_logic_vector(7 downto 0);
  signal not_reset               : std_logic;

  component enARdFF_2
    port
    (
      i_resetBar  : in std_logic;
      i_d         : in std_logic;
      i_enable    : in std_logic;
      i_clock     : in std_logic;
      o_q, o_qBar : out std_logic);
  end component;

begin
  not_reset <= not reset;

  ff7 : enARdFF_2
  port map
  (
    i_resetBar => not_reset,
    i_d        => data_in(7),
    i_enable   => load,
    i_clock    => clk,
    o_q        => int_Value(7),
    o_qBar     => int_notValue(7));

  ff6 : enARdFF_2
  port map
  (
    i_resetBar => not_reset,
    i_d        => data_in(6),
    i_enable   => load,
    i_clock    => clk,
    o_q        => int_Value(6),
    o_qBar     => int_notValue(6));

  ff5 : enARdFF_2
  port map
  (
    i_resetBar => not_reset,
    i_d        => data_in(5),
    i_enable   => load,
    i_clock    => clk,
    o_q        => int_Value(5),
    o_qBar     => int_notValue(5));

  ff4 : enARdFF_2
  port map
  (
    i_resetBar => not_reset,
    i_d        => data_in(4),
    i_enable   => load,
    i_clock    => clk,
    o_q        => int_Value(4),
    o_qBar     => int_notValue(4));

  ff3 : enARdFF_2
  port map
  (
    i_resetBar => not_reset,
    i_d        => data_in(3),
    i_enable   => load,
    i_clock    => clk,
    o_q        => int_Value(3),
    o_qBar     => int_notValue(3));

  ff2 : enARdFF_2
  port
  map (i_resetBar => not_reset,
  i_d             => data_in(2),
  i_enable        => load,
  i_clock         => clk,
  o_q             => int_Value(2),
  o_qBar          => int_notValue(2));

  ff1 : enARdFF_2
  port
  map (i_resetBar => not_reset,
  i_d             => data_in(1),
  i_enable        => load,
  i_clock         => clk,
  o_q             => int_Value(1),
  o_qBar          => int_notValue(1));

  ff0 : enARdFF_2
  port
  map (i_resetBar => not_reset,
  i_d             => data_in(0),
  i_enable        => load,
  i_clock         => clk,
  o_q             => int_Value(0),
  o_qBar          => int_notValue(0));

  -- Output Driver
  data_out <= int_Value;

end rtl;