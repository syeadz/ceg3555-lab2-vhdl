library ieee;
use ieee.std_logic_1164.all;

entity shftleftreg4bit is
  port
  (
    clk      : in std_logic;
    reset    : in std_logic;
    load     : in std_logic;
    data_in  : in std_logic_vector(3 downto 0);
    data_out : out std_logic_vector(3 downto 0);
    shift    : in std_logic
  );
end;

architecture rtl of shftleftreg4bit is
  signal int_data_in : std_logic_vector(3 downto 0);
  signal not_reset   : std_logic;

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

  mux3 : entity work.mux2to1 port map
    (
    sel    => shift,
    d0     => data_in(3),
    d1     => data_in(2),
    enable => '1',
    q      => int_data_in(3));

  ff3 : enARdFF_2
  port
  map
  (
  i_resetBar => not_reset,
  i_d        => int_data_in(3),
  i_enable   => load,
  i_clock    => clk,
  o_q        => data_out(3),
  o_qBar     => open);

  mux2 : entity work.mux2to1 port
    map
    (
    sel    => shift,
    d0     => data_in(2),
    d1     => data_in(1),
    enable => '1',
    q      => int_data_in(2));

  ff2 : enARdFF_2
  port
  map (i_resetBar => not_reset,
  i_d             => int_data_in(2),
  i_enable        => load,
  i_clock         => clk,
  o_q             => data_out(2),
  o_qBar          => open);

  mux1 : entity work.mux2to1 port
    map
    (
    sel    => shift,
    d0     => data_in(1),
    d1     => data_in(0),
    enable => '1',
    q      => int_data_in(1));

  ff1 : enARdFF_2
  port
  map (i_resetBar => not_reset,
  i_d             => int_data_in(1),
  i_enable        => load,
  i_clock         => clk,
  o_q             => data_out(1),
  o_qBar          => open);

  mux0 : entity work.mux2to1 port map (
    sel    => shift,
    d0     => data_in(0),
    d1     => data_in(3),
    enable => '1',
    q      => int_data_in(0)
  );

  ff0 : enARdFF_2
  port
  map (i_resetBar => not_reset,
  i_d             => int_data_in(0),
  i_enable        => load,
  i_clock         => clk,
  o_q             => data_out(0),
  o_qBar          => open);

end;