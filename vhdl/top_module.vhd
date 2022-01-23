library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_module is
Port (Clk : in std_logic;
      input : in std_logic;
      output : out std_logic);
end top_module;

architecture Behavioral of top_module is

component debouncer is
Port (Clk : in std_logic;
      input : in std_logic;
      output : out std_logic);
end component;

begin

the_debouncer : debouncer
port map (Clk => Clk,
          input => input,
          output => output);

end Behavioral;
