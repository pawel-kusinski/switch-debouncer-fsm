library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity debouncer is
Port (Clk : in std_logic;
      input : in std_logic;
      output : out std_logic);
end debouncer;

architecture Behavioral of debouncer is
type State_t is (S0, S1, S2, S3);
signal state : State_t := S0;
signal counter : std_logic_vector(23 downto 0);

begin
    process (Clk)
    begin
        if rising_edge(Clk) then
            case state is
                when S0 => 
                    if input = '0' then
                        state <= S1;
                    else
                        state <= S0;
                    end if;
                when S1 => 
                    if input = '1' then
                        state <= S0;
                        counter <= (others => '0');
                    elsif counter = "010110111000110110000000" then
                        state <= S2;
                        counter <= (others => '0');
                    else
                        counter <= counter + 1;
                        state <= S1;
                    end if;
                when S2 =>
                    if input = '1' then
                        state <= S3;
                    else
                        state <= S2;
                    end if;
                when S3 =>
                    if input = '0' then
                        state <= S2;
                        counter <= (others => '0');
                    elsif counter = "010110111000110110000000" then
                        state <= S0;
                        counter <= (others => '0');
                    else
                        counter <= counter + 1;
                        state <= S3;
                    end if;
                when others =>
                    state <= S0;
            end case;
        end if;
    end process;
    
    process (state)
    begin
        case state is
            when S0 => 
                output <= '1';
            when S1 => 
                output <= '1';
            when S2 =>
                output <= '0';
            when S3 =>
                output <= '0';
            when others =>
                output <= '1';
        end case;
    end process;
    
end Behavioral;
