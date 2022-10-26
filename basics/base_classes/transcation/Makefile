all:
	rm -rf tran_op.log
	rm -rf work 
	clear
	vlib work;
	vlog -sv tran.sv && vsim tb  -l tran_op.log -c -do "run -all;quit;"
							
compile:
	vlib work;
	vlog -sv tran.sv

simulate:
	vsim tb -l tran_op.log -c -do "run -all;quit;"

clear:
	rm -rf tran_op.log
	rm -rf work
	clear
