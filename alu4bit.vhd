library ieee;
use ieee.std_logic_1164.all;

entity alu4bit is
  port
  (
    a        : in std_logic_vector(3 downto 0);
    b        : in std_logic_vector(3 downto 0);
    f        : out std_logic_vector(7 downto 0);
    op       : in std_logic_vector(1 downto 0);
    c, z, v  : out std_logic;
    clk, rst : in std_logic
  );
end;

architecture rtl of alu4bit is
  signal add_op, sub_op, mul_op, div_op : std_logic;
  signal int_f                          : std_logic_vector(7 downto 0);
  signal int_b                          : std_logic_vector(3 downto 0);
begin
  add_op <= not op(0) and not op(1);
  sub_op <= not op(0) and op(1);
  mul_op <= op(0) and not op(1);
  div_op <= op(0) and op(1);

  adder : entity work.adder4bit port map
    (
    a      => a,
    b      => int_b,
    sub_op => sub_op,
    sum    => int_f,
    cout   => c,
    zero   => z
    );
    
  f <= int_f;
end architecture;