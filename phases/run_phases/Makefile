all:
		rm -rf run_phases.log
			rm -rf work 
				clear
					vlib work;
						vlog -sv run_phases.sv && vsim black_squad -l run_phases.log -c -do "run -all;quit;"
													
compile:
		vlib work;
			vlog -sv run_phases.sv

simulate:
		vsim black_squad -l run_phases.log -c -do "run -all;quit;"

clear:
		rm -rf run_phases.log
			rm -rf work
				clear
