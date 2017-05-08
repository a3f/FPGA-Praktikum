# Makefile for GHDL projects
# Seems to have problems with parallel make

GHDL_FLAGS = --workdir=work --std=08

.PHONY: ops counter test_ops test_counter
all: ops counter

ops: myand.o myor.o mynot.o mynand.o mynor.o ;
counter: counter.o ;

%.o: %.vhdl
	ghdl -a $(GHDL_FLAGS) $^


test: test_ops test_counter ;

#find . -maxdepth 1 -perm '-u=x' -type f -exec sh -c '{} --vcd={}.vcd && rm {}.vcd' \;
test_ops: ops myand_tb myor_tb mynot_tb mynand_tb
	ghdl -r $(GHDL_FLAGS) myand_tb --vcd=myand_tb.vcd && rm myand_tb.vcd
	ghdl -r $(GHDL_FLAGS) myor_tb --vcd=myor_tb.vcd && rm myor_tb.vcd
	ghdl -r $(GHDL_FLAGS) mynot_tb --vcd=mynot_tb.vcd && rm mynot_tb.vcd
	ghdl -r $(GHDL_FLAGS) mynand_tb --vcd=mynand_tb.vcd && rm mynand_tb.vcd
	ghdl -r $(GHDL_FLAGS) mynor_tb --vcd=mynor_tb.vcd && rm mynor_tb.vcd

test_counter: counter_tb
	ghdl -r $(GHDL_FLAGS) counter_tb --vcd=counter_tb.vcd



%: testbench/%.o
	ghdl -e $(GHDL_FLAGS) $@


.PHONY: clean
clean:
	$(RM) *.vcd testbench/*.vcd
	ghdl --remove
	cd testbench && $(RM) *.o *.cf *.lst
	$(RM) *.o *.cf *.lst
	cd work && $(RM) *.o *.cf *.lst
#$(RM) -f myand_tb myor_tb mynot_tb mynand_tb
# There's a ghdl --remove command, but it's prone to crashing
