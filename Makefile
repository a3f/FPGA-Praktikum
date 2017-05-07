# Makefile for GHDL projects
# Seems to have problems with parallel make

GHDL_FLAGS = --workdir=work --std=08

all: myand.o myor.o mynot.o mynand.o mynor.o

%.o: %.vhdl
	ghdl $(GHDL_VER) -a $(GHDL_FLAGS) $^

#find . -maxdepth 1 -perm '-u=x' -type f -exec sh -c '{} --vcd={}.vcd && rm {}.vcd' \;
test: all myand_tb myor_tb mynot_tb mynand_tb
	ghdl -r --workdir=work --std=08 myand_tb --vcd=myand_tb.vcd && rm myand_tb.vcd
	ghdl -r --workdir=work --std=08 myor_tb --vcd=myor_tb.vcd && rm myor_tb.vcd
	ghdl -r --workdir=work --std=08 mynot_tb --vcd=mynot_tb.vcd && rm mynot_tb.vcd
	ghdl -r --workdir=work --std=08 mynand_tb --vcd=mynand_tb.vcd && rm mynand_tb.vcd

test_mynand: all mynand_tb
	ghdl -r --workdir=work --std=08 mynand_tb --vcd=mynand_tb.vcd && rm mynand_tb.vcd

test_mynor: all mynor_tb
	ghdl -r --workdir=work --std=08 mynor_tb --vcd=mynor_tb.vcd && rm mynor_tb.vcd

%: testbench/%.o
	ghdl $(GHDL_VER) -e $(GHDL_FLAGS) $@


.PHONY: clean
clean:
	$(RM) *.vcd testbench/*.vcd
	ghdl --remove
	cd testbench && $(RM) *.o *.cf
	$(RM) *.o *.cf
	cd work && $(RM) *.o *.cf
	$(RM) -f myand_tb myor_tb mynot_tb mynand_tb
# There's a ghdl --remove command, but it's prone to crashing
