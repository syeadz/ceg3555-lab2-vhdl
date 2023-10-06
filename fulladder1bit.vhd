library ieee;
use ieee.std_logic_1164.all;

entity fulladder1bit is
  port
  (
    a, b, cin : in std_logic;
    sum, cout : out std_logic
  );
end;

architecture rtl of fulladder1bit is
begin
    sum <= a xor b xor cin;
    cout <= (a and b) or (b and cin) or (a and cin);
end architecture;