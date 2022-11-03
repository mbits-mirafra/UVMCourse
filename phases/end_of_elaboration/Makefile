all:
	rm -rf eoe.log
	rm -rf work 
	clear
	vlib work;
	vlog -sv uvm_eoe.sv && vsim top +UVM_VERBOSITY=UVM_MEDIUM -l eoe.log -c -do "run -all;quit;"
							
compile:
	vlib work;
	vlog -sv uvm_eoe.sv

simulate:
	vsim top +UVM_VERBOSITY=UVM_MEDIUM -l eoe.log -c -do "run -all;quit;"

clear:
	rm -rf eoe.log
	rm -rf work
	clear
