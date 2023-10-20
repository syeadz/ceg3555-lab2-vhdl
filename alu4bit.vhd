library ieee;
use ieee.std_logic_1164.all;

entity alu4bit is
  port
  (
    a                        : in std_logic_vector(3 downto 0);
    b                        : in std_logic_vector(3 downto 0);
    op                       : in std_logic_vector(1 downto 0);
    c, z, v                  : out std_logic;
    hexa, hexb, hexf1, hexf2 : out std_logic_vector(6 downto 0)
  );
end;

architecture rtl of alu4bit is
  signal add_op, sub_op, mul_op, div_op : std_logic;
  signal f                              : std_logic_vector(7 downto 0);
  signal int_b                         : std_logic_vector(3 downto 0);
begin
  add_op <= not op(0) and not op(1);
  sub_op <= not op(0) and op(1);
  mul_op <= op(0) and not op(1);
  div_op <= op(0) and op(1);

  int_b <= b;

  dec_hexa : entity work.dec_7seg port map
    (
    i_hexDigit  => a,
    o_segment_a => hexa(0),
    o_segment_b => hexa(1),
    o_segment_c => hexa(2),
    o_segment_d => hexa(3),
    o_segment_e => hexa(4),
    o_segment_f => hexa(5),
    o_segment_g => hexa(6)
    );

  dec_hexb : entity work.dec_7seg port
    map (
    i_hexDigit  => int_b,
    o_segment_a => hexb(0),
    o_segment_b => hexb(1),
    o_segment_c => hexb(2),
    o_segment_d => hexb(3),
    o_segment_e => hexb(4),
    o_segment_f => hexb(5),
    o_segment_g => hexb(6)
    );

  dec_hexf1 : entity work.dec_7seg port
    map (
    i_hexDigit  => f(3 downto 0),
    o_segment_a => hexf1(0),
    o_segment_b => hexf1(1),
    o_segment_c => hexf1(2),
    o_segment_d => hexf1(3),
    o_segment_e => hexf1(4),
    o_segment_f => hexf1(5),
    o_segment_g => hexf1(6)
    );

  dec_hexf2 : entity work.dec_7seg port
    map (
    i_hexDigit  => f(7 downto 4),
    o_segment_a => hexf2(0),
    o_segment_b => hexf2(1),
    o_segment_c => hexf2(2),
    o_segment_d => hexf2(3),
    o_segment_e => hexf2(4),
    o_segment_f => hexf2(5),
    o_segment_g => hexf2(6)
    );

  adder : entity work.adder4bit port
    map
    (
    a      => a,
    b      => int_b,
    sub_op => sub_op,
    sum    => f,
    cout   => c,
    zero   => z
    );
end architecture;