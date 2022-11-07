compile:
			vlib work;
			vlog -sv pool_method.sv

simulate:
			vsim top -l pool_method.log -c -do "run -all; exit;"

all:
			clear;
			vlog -sv pool_method.sv
			vsim top -l pool_method.log -c -do "run -all; exit;"

clear:
			clear
