library ieee;
use ieee.std_logic_1164.all;

entity fulladder1bit_tb is
end;

architecture rtl of fulladder1bit_tb is
  signal a_tb, b_tb, cin_tb : std_logic;
  signal sum_tb, cout_tb   : std_logic;
begin
  uut : entity work.fulladder1bit port map
    (
        a    => a_tb,
        b    => b_tb,
        cin  => cin_tb,
        sum  => sum_tb,
        cout => cout_tb
        );

    stim_proc : process
    begin
        a_tb   <= '0';
        b_tb   <= '0';
        cin_tb <= '0';
        wait for 10 ns;
        assert (sum_tb = '0' and cout_tb = '0') report "Test failed for input combination: 000" severity error;

        a_tb   <= '0';
        b_tb   <= '0';
        cin_tb <= '1';
        wait for 10 ns;
        assert (sum_tb = '1' and cout_tb = '0') report "Test failed for input combination: 001" severity error;

        a_tb   <= '0';
        b_tb   <= '1';
        cin_tb <= '0';
        wait for 10 ns;
        assert (sum_tb = '1' and cout_tb = '0') report "Test failed for input combination: 010" severity error;

        a_tb   <= '0';
        b_tb   <= '1';
        cin_tb <= '1';
        wait for 10 ns;
        assert (sum_tb = '0' and cout_tb = '1') report "Test failed for input combination: 011" severity error;

        a_tb   <= '1';
        b_tb   <= '0';
        cin_tb <= '0';
        wait for 10 ns;
        assert (sum_tb = '1' and cout_tb = '0') report "Test failed for input combination: 100" severity error;

        a_tb   <= '1';
        b_tb   <= '0';
        cin_tb <= '1';
        wait for 10 ns;
        assert (sum_tb = '0' and cout_tb = '1') report "Test failed for input combination: 101" severity error;

        a_tb   <= '1';
        b_tb   <= '1';
        cin_tb <= '0';
        wait for 10 ns;
        assert (sum_tb = '0' and cout_tb = '1') report "Test failed for input combination: 110" severity error;

        a_tb   <= '1';
        b_tb   <= '1';
        cin_tb <= '1';
        wait for 10 ns;
        assert (sum_tb = '1' and cout_tb = '1') report "Test failed for input combination: 111" severity error;

        wait;
    end process;
  end architecture;