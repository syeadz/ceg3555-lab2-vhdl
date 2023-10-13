library ieee;
use ieee.std_logic_1164.all;

entity adder4bit is
  port
  (
    a      : in std_logic_vector(3 downto 0);
    b      : buffer std_logic_vector(3 downto 0);
    sub_op : in std_logic;
    sum    : out std_logic_vector(3 downto 0);
    cout   : out std_logic; -- overflow
    zero   : out std_logic -- zero
  );
end;

architecture rtl of adder4bit is
  signal cin   : std_logic;
  signal cout0 : std_logic;
  signal cout1 : std_logic;
  signal cout2 : std_logic;
  signal int_b : std_logic_vector(3 downto 0);
begin
  -- 2's complement if sub_op
  cin      <= sub_op;
  int_b(0) <= b(0) xor sub_op;
  int_b(1) <= b(1) xor sub_op;
  int_b(2) <= b(2) xor sub_op;
  int_b(3) <= b(3) xor sub_op;

  fa0 : entity work.fulladder1bit port map
    (
    a    => a(0),
    b    => int_b(0),
    cin  => cin,
    sum  => sum(0),
    cout => cout0
    );

  fa1 : entity work.fulladder1bit port
    map (
    a    => a(1),
    b    => int_b(1),
    cin  => cout0,
    sum  => sum(1),
    cout => cout1
    );

  fa2 : entity work.fulladder1bit port
    map (
    a    => a(2),
    b    => int_b(2),
    cin  => cout1,
    sum  => sum(2),
    cout => cout2
    );

  fa3 : entity work.fulladder1bit port
    map (
    a    => a(3),
    b    => int_b(3),
    cin  => cout2,
    sum  => sum(3),
    cout => cout
    );
end architecture;