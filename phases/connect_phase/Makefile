all:
	rm -rf work
	#rm -rf uvm_connect.log
	rm -rf uvm_connect_phase.log
	clear
	vlib work
	#vlog -sv uvm_connect.sv && vsim top -l uvm_connect.log -c -do "run -all;quit;"
	vlog -sv uvm_connect_phase.sv && vsim top -l uvm_connect_phase.log -c -do "run -all;quit;"

compile:
	vlib work
	#vlog uvm_connect.sv
	vlog uvm_connect_phase.sv

simulate:
	#vsim top UVM_VERBOSITY=UVM_MEDIUM -l uvm_connect.log -c -do "run -all;quit;"
	vsim top UVM_VERBOSITY=UVM_MEDIUM -l uvm_connect_phase.log -c -do "run -all;quit;"

clear:
	rm -rf work
	#rm -rf uvm_connect.log
	rm -rf uvm_connect_phase.log
	clear
