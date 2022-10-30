compile:
			    vlib work;
					vlog -sv macro_stimulus.sv

simulate:
			    vsim tb -l macro_stimulus_log.log -c -do "run -all;exit;"

all:
			clear
			vlib work;
			vlog -sv macro_stimulus.sv 
			vsim tb -l macro_stimulus_log.log -c -do "run -all;exit;"


