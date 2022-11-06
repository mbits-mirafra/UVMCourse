compile:
	vlib work;
	vlog -sv blocking_put.sv
simulate:
	vsim tb -l blocking_put_log.log -c -do "run -all;exit;"
all:
	clear
	vlib work;
	vlog blocking_put.sv
	vsim tb -l blocking_put_log.log -c -do "run -all;exit;" 
