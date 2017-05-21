# Makefile for GHDL projects
.NOTPARALLEL: # has problems otherwise


GHDL_FLAGS = --workdir=work --std=93

all: sync.o shader.o txt_util.o bitmap ;

%.o: %.vhd
	ghdl -a $(GHDL_FLAGS) $^


bitmap: bitmap_tb.o
	ghdl -e $(GHDL_FLAGS) bitmap_tb
	ghdl -r $(GHDL_FLAGS) bitmap_tb --vcd=bitmap_tb.vcd

text: text_tb.o
	ghdl -e $(GHDL_FLAGS) text_tb
	ghdl -r $(GHDL_FLAGS) text_tb --vcd=text_tb.vcd


.PHONY: clean
clean:
	$(RM) *.vcd vga.txt vga.pbm vga.ppm
	ghdl --remove
	$(RM) *.o *.cf *.lst
	cd work && $(RM) *.o *.cf *.lst

