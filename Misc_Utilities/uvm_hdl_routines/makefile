
all:
	make clear;make compile;make simulate

compile:
	vlib work;
	vlog uvm_misc.sv

simulate:
		vsim top -l top.log -c -do "log -r/*; run -all;quit;" -wlf waveform.wlf
		

clear:
		clear  
