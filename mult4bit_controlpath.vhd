library ieee;
use ieee.std_logic_1164.all;

entity mult4bit_controlpath is
  port
  (
    clk, reset, start, done                          : in std_logic;
    equal0MT, equal0MP, negMT, negMP, less4C, bit0MP : in std_logic;
    loadMT, loadMP, loadP                            : out std_logic;
    clearMT, clearMP, clearP                         : out std_logic;
    shiftLMT, shiftRMP                               : out std_logic;
    outcC, zeroC                                     : out std_logic;
    selCompMT, selCompMP, selCount, selPDone         : out std_logic
  );
end;

architecture rtl of mult4bit_controlpath is
  signal s0, s1, s2, s3, s4, s5                               : std_logic;
  signal s0_cond, s1_cond, s2_cond, s3_cond, s4_cond, s5_cond : std_logic;
  signal no_zero                                              : std_logic;
begin
  no_zero <= not (equal0MT or equal0MP);

  s0_cond <= not (s1 or s2 or s3 or s4 or s5);

  s0_ff : entity work.enardFF_2 port map
    (
    i_resetBar => s0_cond,
    i_d        => '1',
    i_enable   => '1',
    i_clock    => clk,
    o_q        => s0,
    o_qBar     => open
    );

  s1_cond <= s0 and negMT and no_zero;

  s1_ff : entity work.enardFF_2 port
    map
    (
    i_resetBar => '1',
    i_d        => s1_cond,
    i_enable   => '1',
    i_clock    => clk,
    o_q        => s1,
    o_qBar     => open
    );

  s2_cond <= (s0 or s1) and no_zero and negMP;

  s2_ff : entity work.enardFF_2 port
    map
    (
    i_resetBar => '1',
    i_d        => s2_cond,
    i_enable   => '1',
    i_clock    => clk,
    o_q        => s2,
    o_qBar     => open
    );

  s3_cond <= (s0 or s1 or s2) and no_zero and less4C and bit0MP;

  s3_ff : entity work.enardFF_2 port
    map
    (
    i_resetBar => '1',
    i_d        => s3_cond,
    i_enable   => '1',
    i_clock    => clk,
    o_q        => s3,
    o_qBar     => open
    );

  s4_cond <= (s0 or s1 or s2 or s3 or s4) and no_zero and less4C and not bit0MP;

  s4_ff : entity work.enardFF_2 port
    map
    (
    i_resetBar => '1',
    i_d        => s4_cond,
    i_enable   => '1',
    i_clock    => clk,
    o_q        => s4,
    o_qBar     => open
    );

  s5_cond <= s4 and not less4C;

  s5_ff : entity work.enardFF_2 port
    map
    (
    i_resetBar => '1',
    i_d        => s5_cond,
    i_enable   => '1',
    i_clock    => clk,
    o_q        => s5,
    o_qBar     => open
    );

  loadMT    <= s0 or s1 or s4;
  loadMP    <= s0 or s2 or s4;
  loadP     <= s3 or s5;
  clearP    <= s0;
  zeroC     <= s0;
  selCompMT <= s1;
  selCompMP <= s2;
  shiftLMT  <= s4;
  shiftRMP  <= s4;
  selpDone  <= s5;
end architecture;