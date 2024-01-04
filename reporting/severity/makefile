compile:
		vlib work;
		vlog -sv severity.sv

simulate:
		vsim top -l severity.log -c -do "run -all; exit;"

all:
		clear;
		vlog -sv severity.sv
		vsim top -l severity.log -c -do "run -all; exit;"

clear:
		clear
