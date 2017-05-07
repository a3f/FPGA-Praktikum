entity binaryop is
    port (a, b : in bit; res : out bit);
end binaryop;
        
architecture behav of binaryop is
begin
    myand : process(a, b)
    begin
        if a = '1' and  b = '1' then
            res <= '1';
        else
            res <= '0';
        end if;
    end process myand;
end behav;

