compile:
	vlib work;
	vlog -sv global_override_code.sv

simulate:
	vsim top -l global_override_log.log -c -do "run -all;exit;"

all:
	clear
	vlib work;
	vlog -sv global_override_code.sv
	vsim top -l global_override_log.log -c -do "run -all;exit;"
