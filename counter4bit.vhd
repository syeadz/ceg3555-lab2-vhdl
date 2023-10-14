library ieee;
use ieee.std_logic_1164.all;

entity counter4bit is
  port
  (
    clk       : in std_logic;
    reset     : in std_logic;
    enable    : in std_logic;
    data_in   : in std_logic_vector(3 downto 0);
    data_out  : out std_logic_vector(3 downto 0);
    increment : in std_logic
  );
end;

architecture rtl of counter4bit is
  signal counter_in  : std_logic_vector(3 downto 0);
  signal counter_out : std_logic_vector(3 downto 0);
begin
    counter_in(0) <= data_in(0) xor increment;
    counter_in(1) <= data_in(1) xor (increment and data_in(0));
    counter_in(2) <= data_in(2) xor (increment and data_in(1) and data_in(0));
    counter_in(3) <= data_in(3) xor (increment and data_in(2) and data_in(1) and data_in(0));

  reg : entity work.register4bit port map
    (
    clk       => clk,
    reset     => reset,
    enable    => enable,
    data_in   => counter_in,
    data_out  => counter_out,
    increment => increment
    );

    data_out <= counter_out;
end;