test_myand: myand
	ghdl -a myand_tb.vhdl
	ghdl -e myand_tb
	ghdl -r myand_tb --vcd=myand.vcd

myand:
	ghdl -a myand.vhdl


ifeq ($(OS),Windows_NT)
## No rm?
ifeq (, $(shell where rm 2>NUL)) 
RM = del /Q 2>NUL
# Powershell, cygwin and msys all provide rm(1)
endif
endif

.PHONY: clean
clean:
	$(RM) *.vcd
