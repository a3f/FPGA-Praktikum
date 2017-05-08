-- Entwerfen Sie eine Schaltung für einen Zähler mit einem Eingang und einem 
-- Eingang stellt ein Taktsignal dar. Dieses Taktsignal soll ausgewertet, d.h. gezählt werden. Nach
-- einer vorher festgelegten Anzahl von Taktzyklen soll der Ausgang für einen Takt auf den Wert
-- '1' gesetzt werden. Speichern Sie die Implementierung in der Datei impuls.vhd

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity impuls_e is
    port (clk : in std_logic; pulse : out std_logic);
end entity impuls_e;

        
architecture behav of impuls_e is
    signal counter: integer range 0 to 5;
begin process(clk)
begin
    if clk'event and clk='1' then
        counter <= counter + 1;
        if counter = 5-1 then -- is there some counter'high attribute?
            pulse <= '1';
            counter <= 0;
        else
            pulse <= '0';
        end if;
    end if;
end process;
end architecture behav;

