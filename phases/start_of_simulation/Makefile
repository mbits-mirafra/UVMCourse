all:
	rm -rf sos.log
	rm -rf work 
	clear
	vlib work;
	vlog -sv uvm_sos.sv && vsim top +UVM_VERBOSITY=UVM_MEDIUM -l sos.log -c -do "run -all;quit;"
							
compile:
	vlib work;
	vlog -sv uvm_sos.sv

simulate:
	vsim top +UVM_VERBOSITY=UVM_MEDIUM -l sos.log -c -do "run -all;quit;"

clear:
	rm -rf sos.log
	rm -rf work
	clear
