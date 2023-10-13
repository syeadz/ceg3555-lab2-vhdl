library ieee;
use ieee.std_logic_1164.all;

entity mux4to1 is
  port
  (
    sel0, sel1     : in std_logic;
    d0, d1, d2, d3 : in std_logic;
    enable         : in std_logic;
    q              : out std_logic
  );
end;

architecture rtl of mux4to1 is
  signal q0, q1, q_out : std_logic;
begin
  mux0 : entity work.mux2to1 port map
    (
    sel    => sel0,
    enable => enable,
    d0     => d0,
    d1     => d1,
    q      => q0
    );

  mux1 : entity work.mux2to1 port
    map (
    sel    => sel0,
    enable => enable,
    d0     => d2,
    d1     => d3,
    q      => q1
    );
  mux2 : entity work.mux2to1 port
    map (
    sel    => sel1,
    enable => enable,
    d0     => q0,
    d1     => q1,
    q      => q_out
    );

  q <= q_out;
end architecture;