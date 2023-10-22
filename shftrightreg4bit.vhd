library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity shftrightreg4bit is
  port
  (
    clk      : in std_logic;
    rst      : in std_logic;
    load     : in std_logic;
    shift    : in std_logic;
    data_in  : in std_logic_vector(3 downto 0);
    data_out : out std_logic_vector(3 downto 0)
  );
end;

architecture rtl of shftrightreg4bit is
  signal reg_data : std_logic_vector(3 downto 0) := "0000";
begin
  process (clk, rst)
  begin
    if rst = '1' then
      -- Reset the register
      reg_data <= "0000";
    elsif rising_edge(clk) then
      if load = '1' then
        if shift = '1' then
          -- Shift the register
          reg_data <= data_in(0) & data_in(3 downto 1);
        else
          -- Load the register
          reg_data <= data_in;
        end if;
      end if;
    end if;
  end process;

  data_out <= reg_data;
end;