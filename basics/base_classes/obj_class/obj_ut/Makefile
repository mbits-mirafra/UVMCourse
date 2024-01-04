all:
	rm -rf obj_ut_op.log
	rm -rf work 
	clear
	vlib work;
	vlog -sv obj_ut.sv && vsim tb -l obj_ut_op.log -c -do "run -all;quit;"
							
compile:
	vlib work;
	vlog -sv obj_ut.sv

simulate:
	vsim tb -l obj_ut_op.log -c -do "run -all;quit;"

clear:
	rm -rf obj_ut_op.log
	rm -rf work
	clear
