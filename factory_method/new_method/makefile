compile:
	vlib work;
	vlog factory_new_code.sv

simulate:
	vsim top -l factory_new_log.log -c -do "run -all;exit;"

all:
	clear
	vlib work;
	vlog factory_new_code.sv
	vsim top -l factory_new_log.log -c -do "run -all;exit;"

