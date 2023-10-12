compile:
	vlib work;
	vlog -sv blocking_get.sv
simulate:
	vsim mod -l blocking_get_log.log -c -do "run -all;exit;"
all:
	clear
	vlib work;
	vlog -sv blocking_get.sv
	vsim mod -l blocking_get_log.log -c -do "run -all;exit;"

