entity mynor_e is
    port (a, b : in bit; res : out bit);
end entity mynor_e;

        
architecture structure of mynor_e is
    component myor_e
        port (a, b : in bit; res : out bit);
    end component;
    component mynot_e
        port (a : in bit; res : out bit);
    end component;
    signal s : bit;

begin
     --res <= a nor b;
    t1: myor_e  port map (a => a, b => b, res => s);
    t2: mynot_e port map (a => s, res => res);
end architecture structure;
