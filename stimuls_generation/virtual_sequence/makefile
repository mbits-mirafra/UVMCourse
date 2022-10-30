compile:
		vlib work;
			vlog virtual_sequence.sv

simulate:
		vsim tb -l virtual_sequence.log -c -do "run -all;exit;"

all:
		clear
			vlib work;
			vlog virtual_sequence.sv
	  	vsim tb -l virtual_sequence.log -c -do "run -all;exit;"
