all:
	rm -rf root_op.log
	rm -rf work 
	clear
	vlib work;
	vlog -sv root.sv && vsim tb -l root_op.log -c -do "run -all;quit;"
							
compile:
	vlib work;
	vlog -sv root.sv

simulate:
	vsim tb -l root_op.log -c -do "run -all;quit;"

clear:
	rm -rf root_op.log
	rm -rf work
	clear
