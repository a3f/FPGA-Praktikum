entity myor_e is
    port (a, b : in bit; res : out bit);
end myor_e;

        
architecture behav of myor_e is
begin
    myor : process(a, b)
    begin
        if a = '1' or  b = '1' then
            res <= '1';
        else
            res <= '0';
        end if;
    end process myor;
end behav;


