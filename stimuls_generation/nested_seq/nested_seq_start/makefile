compile:
			    vlib work;
					vlog -sv nested_seq_start.sv

simulate:
			    vsim tb -l nested_seq_start_log.log -c -do "run -all;exit;"

all:
			clear
			vlib work;
			vlog -sv nested_seq_start.sv 
			vsim tb -l nested_seq_start_log.log -c -do "run -all;exit;"


