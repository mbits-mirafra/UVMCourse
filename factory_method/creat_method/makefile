compile:
	vlib work;
	vlog factory_creation_code.sv

simulate:
	vsim top -l factory_creation_log.log -c -do "run -all;exit;"

all:
	clear
	vlib work;
	vlog factory_creation_code.sv
	vsim top -l factory_creation_log.log -c -do "run -all;exit;"

