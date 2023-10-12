compile:
		    vlib work;
			  vlog -sv tlm_sockets.sv

simulate:
		     vsim tb_top -l tlm_sockets.log -c -do "run -all;exit;"
all:
		clear
		vlib work;
		vlog -sv tlm_sockets.sv
		vsim tb_top -l tlm_sockets.log -c -do "run -all;exit;"

