library ieee;
use ieee.std_logic_1164.all;

entity shftleftreg4bit is
  port
  (
    clk      : in std_logic;
    reset    : in std_logic;
    enable   : in std_logic;
    data_in  : in std_logic_vector(3 downto 0);
    data_out : out std_logic_vector(3 downto 0);
    shift    : in std_logic
  );
end;

architecture rtl of shftleftreg4bit is
  signal int_data_in : std_logic_vector(3 downto 0);
  signal int_data_out: std_logic_vector(3 downto 0);
begin
  int_data_in(0) <= (data_in(0) and not shift) or (data_in(3) and shift);
  int_data_in(1) <= (data_in(1) and not shift) or (data_in(0) and shift);
  int_data_in(2) <= (data_in(2) and not shift) or (data_in(1) and shift);
  int_data_in(3) <= (data_in(3) and not shift) or (data_in(2) and shift);

  reg4bit : entity work.register4bit port map
    (
      clk => clk,
      reset => reset,
      enable => enable,
      data_in => int_data_in,
      data_out => int_data_out
    );

    data_out <= int_data_out;
end rtl;