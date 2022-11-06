all:
	vlib work;
	vlog -sv testbench.sv
	vsim tb -l TLM_Example.log -c -do "run -all;exit;"

compile:
	vlib work;
	vlog -sv testbench.sv

simulate:
	vsim tb  -l TLM_Example.log -c -do "run -all;exit;"
