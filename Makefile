# Makefile for GHDL/GCC projects
# Seems to have problems with parallel make

GHDL_FLAGS = --workdir=work

all: myand.o myor.o mynot.o

%.o: %.vhdl
	ghdl -a $(GHDL_FLAGS) $^



test: all myand_tb myor_tb mynot_tb
	./myand_tb --vcd=$@.vcd && rm $@.vcd
	./myor_tb  --vcd=$@.vcd && rm $@.vcd
	./mynot_tb --vcd=$@.vcd && rm $@.vcd

%: testbench/%.o
	ghdl -e $(GHDL_FLAGS) $@


.PHONY: clean
clean:
	$(RM) *.vcd testbench/*.vcd
	ghdl --remove
	cd testbench && ghdl --remove
	cd work && ghdl --remove
	$(RM) -f myand_tb myor_tb mynot_tb
