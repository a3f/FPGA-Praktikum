--  A testbench has no ports.
entity myor_tb is
    end myor_tb;

architecture behav of myor_tb is
   --  Declaration of the component that will be instantiated.
    component myor
        port (a, b : in bit; res : out bit);
    end component;

   --  Specifies which entity is bound with the component.
    for instance: myor use entity work.myor_e;
        signal a, b, res : bit;
begin
   --  Component instantiation.
        instance: myor port map (a => a, b => b, res => res);

   --  This process does the real job.
        process
        type truth_table_entry is record
            a, b, res : bit;
        end record;

        type truth_table_t is array (natural range <>) of truth_table_entry;
        constant truth_table : truth_table_t := (
            ('0','0',  '0'),
            ('0','1',  '1'),
            ('1','0',  '1'),
            ('1','1',  '1')
        );
        begin
            for i in truth_table'range loop
         --  Set the inputs.
                a   <= truth_table(i).a;
                b   <= truth_table(i).b;
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
