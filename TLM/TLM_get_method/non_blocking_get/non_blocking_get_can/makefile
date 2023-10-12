compile:
		vlib work;
			vlog -sv non_blocking_get_can.sv
simulate:
	
		vsim mod -l non_blocking_get_can_log.log -c -do "run -all;exit;"
all:
		clear
			vlib work;
				vlog -sv non_blocking_get_can.sv
					vsim mod -l non_blocking_get_can.log -c -do "run -all;exit;"

