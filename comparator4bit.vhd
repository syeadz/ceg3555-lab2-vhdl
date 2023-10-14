library ieee;
use ieee.std_logic_1164.all;

entity comparator4bit is
  port
  (
    i_Ai, i_Bi       : in std_logic_vector(3 downto 0);
    o_GT, o_LT, o_EQ : out std_logic);
end;

architecture rtl of comparator4bit is
  signal int_GT, int_LT : std_logic_vector(3 downto 0);
  signal gnd            : std_logic;

  component oneBitComparator
    port
    (
      i_GTPrevious, i_LTPrevious : in std_logic;
      i_Ai, i_Bi                 : in std_logic;
      o_GT, o_LT                 : out std_logic);
  end component;

begin

  -- Concurrent Signal Assignment
  gnd <= '0';

  comp3 : oneBitComparator
  port map
  (
    i_GTPrevious => gnd,
    i_LTPrevious => gnd,
    i_Ai         => i_Ai(3),
    i_Bi         => i_Bi(3),
    o_GT         => int_GT(3),
    o_LT         => int_LT(3));

  comp2 : oneBitComparator
  port
  map (i_GTPrevious => int_GT(3),
  i_LTPrevious      => int_LT(3),
  i_Ai              => i_Ai(2),
  i_Bi              => i_Bi(2),
  o_GT              => int_GT(2),
  o_LT              => int_LT(2));

  comp1 : oneBitComparator
  port
  map (i_GTPrevious => int_GT(2),
  i_LTPrevious      => int_LT(2),
  i_Ai              => i_Ai(1),
  i_Bi              => i_Bi(1),
  o_GT              => int_GT(1),
  o_LT              => int_LT(1));

  comp0 : oneBitComparator
  port
  map (i_GTPrevious => int_GT(1),
  i_LTPrevious      => int_LT(1),
  i_Ai              => i_Ai(0),
  i_Bi              => i_Bi(0),
  o_GT              => int_GT(0),
  o_LT              => int_LT(0));

  -- Output Driver
  o_GT <= int_GT(0);
  o_LT <= int_LT(0);
  o_EQ <= int_GT(0) nor int_LT(0);

end rtl;