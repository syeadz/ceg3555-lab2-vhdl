library ieee;
use ieee.std_logic_1164.all;

entity mult4bit_datapath_tb is
end;

architecture rtl of mult4bit_datapath_tb is
  signal clk_tb, reset_tb                                                   : std_logic                    := '0';
  signal loadMT_tb, loadMP_tb, loadP_tb                                     : std_logic                    := '0';
  signal clearMT_tb, clearMP_tb, clearP_tb                                  : std_logic                    := '0';
  signal shiftLMT_tb, shiftRMP_tb                                           : std_logic                    := '0';
  signal incC_tb, zeroC_tb                                                  : std_logic                    := '0';
  signal equal0MT_tb, equal0MP_tb, negMT_tb, negMP_tb, less4C_tb, bit0MP_tb : std_logic                    := '0';
  signal selCompMT_tb, selCompMP_tb, selCount_tb, selPDone_tb               : std_logic                    := '0';
  signal mt_tb, mp_tb                                                       : std_logic_vector(3 downto 0) := "0000";
  signal prod_tb                                                            : std_logic_vector(7 downto 0) := "00000000";

  signal sim_end  : boolean := false;
  constant period : time    := 50 ns;
begin
  uut : entity work.mult4bit_datapath port map
    (
    clk       => clk_tb,
    reset     => reset_tb,
    loadMT    => loadMT_tb,
    loadMP    => loadMP_tb,
    loadP     => loadP_tb,
    clearMT   => clearMT_tb,
    clearMP   => clearMP_tb,
    clearP    => clearP_tb,
    shiftLMT  => shiftLMT_tb,
    shiftRMP  => shiftRMP_tb,
    incC      => incC_tb,
    zeroC     => zeroC_tb,
    equal0MT  => equal0MT_tb,
    equal0MP  => equal0MP_tb,
    negMT     => negMT_tb,
    negMP     => negMP_tb,
    less4C    => less4C_tb,
    bit0MP    => bit0MP_tb,
    selCompMT => selCompMT_tb,
    selCompMP => selCompMP_tb,
    selCount  => selCount_tb,
    selPDone  => selPDone_tb,
    mt        => mt_tb,
    mp        => mp_tb,
    prod      => prod_tb
    );

  clock_process : process
  begin
    while (not sim_end) loop
      clk_tb <= '1';
      wait for period/2;
      clk_tb <= '0';
      wait for period/2;
    end loop;
    wait;
  end process;

  stim_proc : process
  begin
    mt_tb     <= "1010";
    mp_tb     <= "0011";
    loadMP_tb <= '1';
    loadMT_tb <= '1';
    clearP_tb <= '1';
    zeroC_tb  <= '1';
    wait for period*2;

    sim_end <= true;
    wait;
  end process;

end architecture;