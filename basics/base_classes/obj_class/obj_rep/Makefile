all:
	rm -rf obj_rep_op.log
	rm -rf work 
	clear
	vlib work;
	#vlog -sv obj_rep.sv && vsim tb +UVM_VERBOSITY=UVM_FULL -l obj_rep_op.log -c -do "run -all;quit;"
	vlog -sv obj_rep.sv && vsim tb  -l obj_rep_op.log -c -do "run -all;quit;"
							
compile:
	vlib work;
	vlog -sv obj_rep.sv

simulate:
	vsim tb -l obj_rep_op.log -c -do "run -all;quit;"

clear:
	rm -rf obj_rep_op.log
	rm -rf work
	clear
