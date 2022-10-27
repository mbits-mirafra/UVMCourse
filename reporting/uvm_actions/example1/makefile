compile:
	vlog -sv actions_example1.sv

simulate:
	vsim top -l top.log -c -do "run -all;exit"

all:
	make compile && make simulate

clear:
	make clear

