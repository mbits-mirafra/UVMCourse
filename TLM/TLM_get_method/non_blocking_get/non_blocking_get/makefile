compile:
	vlib work;
	vlog -sv non_blocking_get.sv
simulate:
	vsim mod -l non_blocking_get_log.log -c -do "run -all;exit;"
all:
	clear
	vlib work;
	vlog -sv non_blocking_get.sv
	vsim mod -l non_blocking_get_log.log -c -do "run -all;exit;"

