library ieee;
use ieee.std_logic_1164.all;

entity complementer4bit is
  port
  (
    data_in  : in std_logic_vector(3 downto 0);
    data_out : out std_logic_vector(3 downto 0)
  );
end;

architecture rtl of complementer4bit is
  signal data : std_logic_vector(3 downto 0);
begin
    data <= not data_in; -- 1's complement
    data(0) <= data(0) xor '1';
    data(1) <= data(0);
    data(2) <= data(1) and data(0);
    data(3) <= data(2) and data(1) and data(0);

    data_out <= data;
end architecture;