all:
	rm -rf top.log
	rm -rf work 
	clear
	vlib work;
	vlog -sv seq_item.sv && vsim top +UVM_VERBOSITY=UVM_MEDIUM -l top.log -c -do "run -all;quit;"
							
compile:
	vlib work;
	vlog -sv seq_item.sv

simulate:
	vsim top +UVM_VERBOSITY=UVM_MEDIUM -l top.log -c -do "run -all;quit;"

clear:
	rm -rf top.log
	rm -rf work
	clear
