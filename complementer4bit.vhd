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
  signal data1, data2 : std_logic_vector(3 downto 0);
begin
  data1    <= not data_in; -- 1's complement
  data2(0) <= data1(0) xor '1';
  data2(1) <= data1(1) xor data1(0);
  data2(2) <= data1(2) xor (data1(0) and data1(1));
  data2(3) <= data1(3) xor (data1(0) and data1(1) and data1(2));

  data_out <= data2;
end architecture;