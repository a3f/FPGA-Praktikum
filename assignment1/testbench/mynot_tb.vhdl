--  A testbench has no ports.
entity mynot_tb is
    end mynot_tb;

architecture behav of mynot_tb is
   --  Declaration of the component that will be instantiated.
    component mynot
        port (a : in bit; res : out bit);
    end component;

   --  Specifies which entity is bound with the component.
    for instance: mynot use entity work.mynot_e;
        signal a, res : bit;
begin
   --  Component instantiation.
        instance: mynot port map (a => a, res => res);

   --  This process does the real job.
        process
        type truth_table_entry is record
            a, res : bit;
        end record;

        type truth_table_t is array (natural range <>) of truth_table_entry;
        constant truth_table : truth_table_t := (
            ('0',  '1'),
            ('1',  '0')
        );
        begin
            for i in truth_table'range loop
         --  Set the inputs.
                a   <= truth_table(i).a;
         --  Wait for the results.
                wait for 1 ns;
         --  Check the outputs.
                assert res = truth_table(i).res
                report "Truth table not true" severity error;
            end loop;
            assert false report
            -- ANSI escape characters for green text
            Character'Val(27) & "[32mTest's over." & Character'Val(27) & "[m"
            severity note;
      --  Wait forever; this will finish the simulation.
            wait;
        end process;
end behav;


