compile:
	vlib work;
	vlog -sv non_blocking_put.sv
simulate:
	vsim tb -l non_blocking_put_log.log -c -do "run -all;exit;"
all:
	clear
	vlib work;
	vlog non_blocking_put.sv
	vsim tb -l non_blocking_put_log.log -c -do "run -all;exit;" 
