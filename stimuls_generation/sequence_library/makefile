compile:
		vlib work;
			vlog sequence_library.sv

simulate:
		vsim tb -l sequence_library.log -c -do "run -all;exit;"

all:
		clear
			vlib work;
			vlog sequence_library.sv
	  	vsim tb -l sequence_library.log -c -do "run -all;exit;"
