library ieee;
use ieee.std_logic_1164.all;

entity register4bit is
  port
  (
    clk      : in std_logic;
    reset    : in std_logic;
    enable   : in std_logic;
    data_in  : in std_logic_vector(3 downto 0);
    data_out : out std_logic_vector(3 downto 0)
  );
end;

architecture rtl of register4bit is
  signal i_reset : std_logic;
  signal int_data_out : std_logic_vector(3 downto 0);
begin
  i_reset <= not reset;
    
  q0 : entity work.enardFF_2 port map
    (
    i_resetBar => i_reset,
    i_d        => data_in(0),
    i_enable   => enable,
    i_clock    => clk,
    o_q        => int_data_out(0),
    o_qBar     => open
    );

  q1 : entity work.enardFF_2 port
    map (
    i_resetBar => i_reset,
    i_d        => data_in(1),
    i_enable   => enable,
    i_clock    => clk,
    o_q        => int_data_out(1),
    o_qBar     => open
    );

  q2 : entity work.enardFF_2 port
    map (
    i_resetBar => i_reset,
    i_d        => data_in(2),
    i_enable   => enable,
    i_clock    => clk,
    o_q        => int_data_out(2),
    o_qBar     => open
    );

  q3 : entity work.enardFF_2 port
    map (
    i_resetBar => i_reset,
    i_d        => data_in(3),
    i_enable   => enable,
    i_clock    => clk,
    o_q        => int_data_out(3),
    o_qBar     => open
    );

  data_out <= int_data_out;
end rtl;