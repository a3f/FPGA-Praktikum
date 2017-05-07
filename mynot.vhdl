entity mynot_e is
    port (a : in bit; res : out bit);
end mynot_e;
        
architecture behav of mynot_e is
begin
    mynot : process(a)
    begin
        if a = '0' then
            res <= '1';
        else
            res <= '0';
        end if;
    end process mynot;
end behav;

