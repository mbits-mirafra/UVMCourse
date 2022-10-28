compile:
		vlib work;
			vlog sequence_driver.sv

simulate:
		vsim tb -l sequence_driver.log -c -do "run -all;exit;"

all:
		clear
			vlib work;
			vlog sequence_driver.sv
	  	vsim tb -l sequence_driver.log -c -do "run -all;exit;"


