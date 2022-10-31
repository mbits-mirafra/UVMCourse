compile:
			vlib work;
			vlog -sv top.sv

simulate:
	   	vsim top -l get_next_log.log -c -do "run -all;exit;"

all:
			clear;
			vlog -sv top.sv
		  vsim top -l get_next_log.log -c -do "run -all;exit;"

clear:
			clear
