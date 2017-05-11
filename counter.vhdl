-- Erweitern Sie die Schaltung aus Aufgabe 2.3 dahingehend, dass am Ausgang der Wert 1 nicht
-- mehr counterartig für einen Originaltakt, sondern alternierend jeweils gleich lang 1 und 0 ausgegeben
-- werden. Speichern Sie die Implementierung in der Datei counter.vhd

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_e is
    port (clk : in std_logic; pulse : out std_logic);
end entity counter_e;

        
architecture behav of counter_e is
    constant ticks :integer := 5;
    signal counter: integer range 0 to ticks;
    signal level: std_logic := '0';
begin process(clk)
begin
    --if clk'event and clk='1' then
    if rising_edge(clk) then
        if counter < counter'min then
            counter <= counter + 1;
            pulse <= level;
        else
            level <= not level;
            counter <= 0;
        end if;
    end if;
end process;
end architecture behav;


