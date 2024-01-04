compile:
			vlib work;
			vlog -sv top.sv

simulate:
	   	vsim tb_top -l comparer_log.log -c -do "run -all;exit;"

all:
			clear;
			vlog -sv top.sv
		  vsim tb_top -l comparer_log.log -c -do "run -all;exit;"

clear:
			clear
