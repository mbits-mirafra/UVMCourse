all:
	rm -rf top_op.log
	rm -rf work 
	clear
	vlib work;
	vlog -sv top.sv && vsim top  -l top_op.log -c -do "run -all;quit;"
							
compile:
	vlib work;
	vlog -sv top.sv

simulate:
	vsim top -l top_op.log -c -do "run -all;quit;"

clear:
	rm -rf top_op.log
	rm -rf work
	clear
