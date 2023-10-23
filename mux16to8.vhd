library ieee;
use ieee.std_logic_1164.all;

entity mux16to8 is
  port
  (
    sel    : in std_logic;
    d0, d1 : in std_logic_vector(7 downto 0);
    enable : in std_logic;
    q      : out std_logic_vector(7 downto 0)
  );
end;

architecture rtl of mux16to8 is
begin
  mux0 : entity work.mux2to1 port map
    (
    sel    => sel,
    enable => enable,
    d0     => d0(0),
    d1     => d1(0),
    q      => q(0)
    );

  mux1 : entity work.mux2to1 port
    map (
    sel    => sel,
    enable => enable,
    d0     => d0(1),
    d1     => d1(1),
    q      => q(1)
    );

  mux2 : entity work.mux2to1 port
    map (
    sel    => sel,
    enable => enable,
    d0     => d0(2),
    d1     => d1(2),
    q      => q(2)
    );

  mux3 : entity work.mux2to1 port
    map (
    sel    => sel,
    enable => enable,
    d0     => d0(3),
    d1     => d1(3),
    q      => q(3)
    );

  mux4 : entity work.mux2to1 port
    map (
    sel    => sel,
    enable => enable,
    d0     => d0(4),
    d1     => d1(4),
    q      => q(4)
    );

  mux5 : entity work.mux2to1 port
    map (
    sel    => sel,
    enable => enable,
    d0     => d0(5),
    d1     => d1(5),
    q      => q(5)
    );

  mux6 : entity work.mux2to1 port
    map (
    sel    => sel,
    enable => enable,
    d0     => d0(6),
    d1     => d1(6),
    q      => q(6)
    );

  mux7 : entity work.mux2to1 port
    map (
    sel    => sel,
    enable => enable,
    d0     => d0(7),
    d1     => d1(7),
    q      => q(7)
    );
end;