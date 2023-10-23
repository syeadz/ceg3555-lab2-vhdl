library ieee;
use ieee.std_logic_1164.all;

entity mux8to4 is
  port
  (
    sel    : in std_logic;
    d0, d1 : in std_logic_vector(3 downto 0);
    enable : in std_logic;
    q      : out std_logic_vector(3 downto 0)
  );
end;

architecture rtl of mux8to4 is
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

end;