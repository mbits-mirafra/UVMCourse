
compile:
	vlib work;
	vlog -sv port_port_imp.sv

simulate:
	vsim tb -l port_port_imp.log -c -do "run -all;exit;"
all:
	clear
	vlib work;
	vlog -sv port_port_imp.sv
	vsim tb -l port_port_imp.log -c -do "run -all;exit;"

