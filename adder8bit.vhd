library ieee;
use ieee.std_logic_1164.all;

entity adder8bit is
  port
  (
    a      : in std_logic_vector(3 downto 0);
    b      : in std_logic_vector(7 downto 0);
    sum    : out std_logic_vector(7 downto 0);
    cout   : out std_logic; -- overflow
    zero   : out std_logic -- zero
  );
end;

architecture rtl of adder8bit is
  signal cout0, cout1, cout2, cout3, cout4, cout5, cout6 : std_logic;
  signal int_sum                                         : std_logic_vector(7 downto 0);
begin
  fa0 : entity work.fulladder1bit port map
    (
    a    => a(0),
    b    => b(0),
    cin  => '0',
    sum  => int_sum(0),
    cout => cout0
    );

  fa1 : entity work.fulladder1bit port
    map (
    a    => a(1),
    b    => b(1),
    cin  => cout0,
    sum  => int_sum(1),
    cout => cout1
    );

  fa2 : entity work.fulladder1bit port
    map (
    a    => a(2),
    b    => b(2),
    cin  => cout1,
    sum  => int_sum(2),
    cout => cout2
    );

  fa3 : entity work.fulladder1bit port
    map (
    a    => a(3),
    b    => b(3),
    cin  => cout2,
    sum  => int_sum(3),
    cout => cout3
    );

  fa4 : entity work.fulladder1bit port
    map (
    a    => '0',
    b    => b(4),
    cin  => cout3,
    sum  => int_sum(4),
    cout => cout4
    );

  fa5 : entity work.fulladder1bit port
    map (
    a    => '0',
    b    => b(5),
    cin  => cout4,
    sum  => int_sum(5),
    cout => cout5
    );

  fa6 : entity work.fulladder1bit port
    map (
    a    => '0',
    b    => b(6),
    cin  => cout5,
    sum  => int_sum(6),
    cout => cout6
    );

  fa7 : entity work.fulladder1bit port
    map (
    a    => '0',
    b    => b(7),
    cin  => cout6,
    sum  => int_sum(7),
    cout => cout
    );

  zero <= not (int_sum(7) or int_sum(6) or int_sum(5) or int_sum(4) or int_sum(3) or int_sum(2) or int_sum(1) or int_sum(0));
  sum  <= int_sum;
end architecture;