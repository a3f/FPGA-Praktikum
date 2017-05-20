entity mynand_e is
    port (a, b : in bit; res : out bit);
end entity mynand_e;

        
architecture structure of mynand_e is
    component myand_e
        port (a, b : in bit; res : out bit);
    end component;
    component mynot_e
        port (a : in bit; res : out bit);
    end component;
    signal s : bit;

begin
     --res <= '0' when a = '1' and b = '1' else '1';
    t1: myand_e port map (a => a, b => b, res => s);
    t2: mynot_e  port map (a => s, res => res);
end architecture structure;
