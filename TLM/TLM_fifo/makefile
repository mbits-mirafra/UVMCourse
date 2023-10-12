compile:
	vlib work;
	vlog -sv tlm_fifo.sv
simulate:
	vsim tb -l tlm_fifo_log.log -c -do "run -all;exit;"
all:
	clear
	vlib work;
	vlog tlm_fifo.sv
	vsim tb -l tlm_fifo_log.log -c -do "run -all;exit;" 
