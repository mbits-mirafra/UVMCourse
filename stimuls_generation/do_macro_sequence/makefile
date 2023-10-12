compile:
		vlib work;
		vlog do_macro_sequence.sv

simulate:
		vsim tb -l do_macro_sequence_log.log -c -do "run -all;exit;"

all:
		clear
		vlib work;
		vlog do_macro_sequence.sv 
		vsim tb -l do_macro_sequence_log.log -c -do "run -all;exit;"


