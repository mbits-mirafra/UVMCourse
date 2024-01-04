
`include "uvm_macros.svh"

import uvm_pkg::*;
//Environment class

class env extends uvm_env;
`uvm_component_utils(env)

agent a;

function new(string name = "env", uvm_component parent = null);
super.new(name, parent); 
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
a = agent::type_id::create("a", this);
endfunction

//Objection is used to hold the simulator

endclass

