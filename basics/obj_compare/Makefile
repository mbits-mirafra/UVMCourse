all:
	rm -rf compare.log
	rm -rf work 
	clear
	vlib work;
	vlog uvm_object_compare.sv && vsim top -l compare.log -c -do "run -all;quit;"
							
compile:
	vlib work;
	vlog uvm_object_compare.sv

simulate:
	vsim top -l compare.log -c -do "run -all;quit;"

clear:
	rm -rf compare.log
	rm -rf work
	clear
