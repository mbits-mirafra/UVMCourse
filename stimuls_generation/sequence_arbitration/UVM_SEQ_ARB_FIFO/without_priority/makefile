all:
	clear;
	vlib work;
	vlog -sv testbench.sv
	vsim tb -l seq-arb_fifo.log -c -do "run -all;exit;"

compile:
	vlib work;
	vlog -sv testbench.sv

simulate:
	vsim tb  -l seq_arb_fifo.log -c -do "run -all;exit;"

clear:
	clear

