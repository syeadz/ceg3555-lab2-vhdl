library ieee;
use ieee.std_logic_1164.all;

entity mult4bit_datapath is
  port
  (
    clk, reset                                       : in std_logic;
    loadMT, loadMP, loadP                            : in std_logic;
    clearMT, clearMP, clearP                         : in std_logic;
    shiftLMT, shiftRMP                               : in std_logic;
    incC, zeroC                                      : in std_logic;
    equal0MT, equal0MP, negMT, negMP, less4C, bit0MP : out std_logic;
    selCompMT, selCompMP, selCount, selPDone         : in std_logic;
    mt, mp                                           : in std_logic_vector(3 downto 0);
    prod                                             : out std_logic_vector(7 downto 0)
  );
end;

architecture rtl of mult4bit_datapath is
  signal from_muxMT, from_muxMP     : std_logic_vector(3 downto 0);
  signal from_MuxP                  : std_logic_vector(7 downto 0);
  signal from_regMT, from_regMP     : std_logic_vector(3 downto 0);
  signal from_regP                  : std_logic_vector(7 downto 0);
  signal from_complMT, from_complMP : std_logic_vector(3 downto 0);
  signal from_adder                 : std_logic_vector(7 downto 0);
  signal neg_P                      : std_logic_vector(7 downto 0);
  signal from_count                 : std_logic_vector(3 downto 0);
begin

  muxMT : entity work.mux8to4 port map
    (
    sel    => selCompMT,
    d0     => mt,
    d1     => from_complMT,
    q      => from_muxMT,
    enable => '1'
    );

  regMT : entity work.shftleftreg4bit port
    map (
    clk      => clk,
    rst      => clearMT,
    load     => loadMT,
    shift    => shiftLMT,
    data_in  => from_muxMT,
    data_out => from_regMT
    );

  compaMT : entity work.comparator4bit port
    map
    (a      => from_regMT,
    b       => "0000",
    equal   => equal0MT,
    greater => open,
    less    => open
    );

  complMT : entity work.complementer4bit port
    map (
    data_in  => from_regMT,
    data_out => from_complMT
    );

  muxMP : entity work.mux8to4 port
    map
    (
    sel    => selCompMP,
    d0     => mp,
    d1     => from_complMP,
    q      => from_muxMP,
    enable => '1'
    );

  regMP : entity work.shftrightreg4bit port
    map (
    clk      => clk,
    rst      => clearMP,
    load     => loadMP,
    shift    => shiftRMP,
    data_in  => from_muxMP,
    data_out => from_regMP
    );

  compaMP : entity work.comparator4bit port
    map (
    a       => from_regMP,
    b       => "0000",
    equal   => equal0MP,
    greater => open,
    less    => open
    );

  complMP : entity work.complementer4bit port
    map (
    data_in  => from_regMP,
    data_out => from_complMP
    );

  neg_P <= (mt(3) xor mp(3)) & from_regP(6 downto 0);

  muxP : entity work.mux16to8 port
    map (
    sel    => selPDone,
    d0     => from_adder,
    d1     => neg_P,
    q      => from_muxP,
    enable => '1'
    );

  regP : entity work.register8bit port
    map (
    clk      => clk,
    reset    => clearP,
    load     => loadP,
    data_in  => from_muxP,
    data_out => from_regP
    );

  adder : entity work.adder8bit port
    map (
    a    => from_regMT,
    b    => from_regP,
    sum  => from_adder,
    cout => open,
    zero => open
    );

  counter : entity work.counter4bit port
    map (
    clk   => clk,
    reset => zeroC,
    load  => incC,
    count => from_count
    );

  compaC : entity work.comparator4bit port
    map (
    a       => from_count,
    b       => "0100",
    equal   => open,
    greater => less4C,
    less    => open
    );

  bit0MP <= from_regMP(0);
  prod   <= from_regP;
  negMT  <= from_regMT(3);
  negMP  <= from_regMP(3);
end architecture;