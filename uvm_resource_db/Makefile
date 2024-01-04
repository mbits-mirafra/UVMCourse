all:
	rm -rf work
	rm -rf res_op.log
	clear
	vlib work
	vlog -sv res.sv && vsim top -l res_op.log -c -do "run -all;quit;" +UVM_RESOURCE_DB_TRACE

compile:
	vlib work
	vlog res.sv

simulate:
	vsim top -l res_op.log -c -do "run -all;quit;" +UVM_RESOURCE_DB_TRACE

clear:
	rm -rf work
	rm -rf res_op.log
	clear
