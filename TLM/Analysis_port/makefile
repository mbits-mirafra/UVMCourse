compile:
	vlib work;
	vlog -sv analysis_port.sv
simulate:
	vsim tb -l analysis_port_log.log -c -do "run -all;exit;"
all:
	clear
	vlib work;
	vlog analysis_port.sv
	vsim tb -l analysis_port_log.log -c -do "run -all;exit;" 
