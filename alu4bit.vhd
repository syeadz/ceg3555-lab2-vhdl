library ieee;
use ieee.std_logic_1164.all;

entity alu4bit is
  port
  (
    a       : in std_logic_vector(3 downto 0);
    b       : buffer std_logic_vector(3 downto 0);
    op      : in std_logic_vector(1 downto 0);
    f       : out std_logic_vector(7 downto 0);
    c, z, v : out std_logic;
    hexa1, hexa2, hexb1, hexb2, hexf1, hexf2, hexf3, hexf4 : out std_logic_vector(6 downto 0)
  );
end;

architecture rtl of alu4bit is
  signal add_op, sub_op, mul_op, div_op : std_logic;
begin
  add_op <= not op(0) and not op(1);
  sub_op <= not op(0) and op(1);
  mul_op <= op(0) and not op(1);
  div_op <= op(0) and op(1);

  dec_hexa1 : entity work.dec_7seg port map (
        i_hexDigit => a,
        o_segment_a => hexa1(0),
        o_segment_b => hexa1(1),
        o_segment_c => hexa1(2),
        o_segment_d => hexa1(3),
        o_segment_e => hexa1(4),
        o_segment_f => hexa1(5)
    );

  adder : entity work.adder4bit port map
    (
    a      => a,
    b      => b,
    sub_op => sub_op,
    sum    => f,
    cout   => c,
    zero   => z
    );
end architecture;