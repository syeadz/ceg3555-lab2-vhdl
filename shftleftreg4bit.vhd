library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shftleftreg4bit is
    Port (
        clk       : in  STD_LOGIC;
        rst       : in  STD_LOGIC;
        load      : in  STD_LOGIC;
        shift     : in  STD_LOGIC;
        data_in   : in  STD_LOGIC_VECTOR(3 downto 0);
        data_out  : out STD_LOGIC_VECTOR(3 downto 0)
    );
end;

architecture rtl of shftleftreg4bit is
    signal reg_data : STD_LOGIC_VECTOR(3 downto 0) := "0000";
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
                    reg_data <= data_in(2 downto 0) & data_in(3);
                else
                    -- Load the register
                    reg_data <= data_in;
                end if;
            end if;
        end if;
    end process;

    data_out <= reg_data;
end;
