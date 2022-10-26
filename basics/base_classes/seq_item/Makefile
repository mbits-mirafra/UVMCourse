all:
	rm -rf seq_op.log
	rm -rf work 
	clear
	vlib work;
	vlog -sv seq.sv && vsim tb  -l seq_op.log -c -do "run -all;quit;"
							
compile:
	vlib work;
	vlog -sv seq.sv

simulate:
	vsim tb -l seq_op.log -c -do "run -all;quit;"

clear:
	rm -rf seq_op.log
	rm -rf work
	clear
