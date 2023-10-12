compile:
	vlib work;
	vlog -sv TLM_decl_macros.sv
simulate:
	vsim tb -l TLM_decl_macros_log.log -c -do "run -all;exit;"
all:
	clear
	vlib work;
	vlog TLM_decl_macros.sv
	vsim tb -l TLM_decl_macros_log.log -c -do "run -all;exit;" 
