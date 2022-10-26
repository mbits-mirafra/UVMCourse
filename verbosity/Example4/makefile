

compile:
	vlib work;
	vlog -sv Example.sv

simulate:
	vsim tb -l top.log -c -do "run -all; exit;"

all:
	make compile && make simulate

