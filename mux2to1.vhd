library ieee;
use ieee.std_logic_1164.all;

entity mux2to1 is
  port
  (
    sel    : in std_logic;
    d0, d1 : in std_logic;
    enable : in std_logic;
    q      : out std_logic
  );
end;

architecture rtl of mux2to1 is
begin
  q <= ((not sel and d0) or (sel and d1)) and enable;
end;