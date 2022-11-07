all:
	rm -rf work
	rm -rf uvm_config_db_set.log
	clear
	vlib work
	vlog -sv uvm_config_db_set.sv && vsim top +UVM_VERBOSITY=UVM_MEDIUM -l uvm_config_db_set.log -c -do "run -all;quit;"

compile:
	vlib work
	vlog uvm_config_db_set.sv

simulate:
	vsim top UVM_VERBOSITY=UVM_MEDIUM +UVM_CONFIG_DB_TRACE-l uvm_config_db_set.log -c -do "run -all;quit;"

clear:
	rm -rf work
	rm -rf uvm_config_db_set.log
	clear
