compile:
		vlib work;
			vlog sequence_pre_post.sv

simulate:
		vsim tb -l sequence_pre_post.log -c -do "run -all;exit;"

all:
		clear
			vlib work;
			vlog sequence_pre_post.sv
	  	vsim tb -l sequence_pre_post.log -c -do "run -all;exit;"
