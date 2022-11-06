
compile:
	vlib work;
	vlog -sv port_export_imp.sv

simulate:
	vsim tb -l port_export_imp.log -c -do "run -all;exit;"
all:
	clear
	vlib work;
	vlog -sv port_export_imp.sv
	vsim tb -l port_export_imp.log -c -do "run -all;exit;"

