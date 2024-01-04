all:
	rm -rf work
	rm -rf uvm_build_phase.log
	clear
	vlib work
	vlog -sv uvm_build_phase.sv && vsim top +UVM_VERBOSITY=UVM_MEDIUM -l uvm_build_phase.log -c -do "run -all;quit;"

compile:
	vlib work
	vlog uvm_build_phase.sv

simulate:
	vsim top UVM_VERBOSITY=UVM_MEDIUM -l uvm_build_phase.log -c -do "run -all;quit;"

clear:
	rm -rf work
	rm -rf uvm__build_phase.log
	clear
