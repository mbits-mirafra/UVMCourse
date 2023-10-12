compile:
			    vlib work;
					vlog -sv nested_seq_do_macro.sv

simulate:
			    vsim tb -l nested_seq_do_macro_log.log -c -do "run -all;exit;"

all:
			clear
			vlib work;
			vlog -sv nested_seq_do_macro.sv 
			vsim tb -l nested_seq_do_macro_log.log -c -do "run -all;exit;"


