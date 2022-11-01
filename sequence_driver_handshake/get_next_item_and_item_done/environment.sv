
`include "uvm_macros.svh"

import uvm_pkg::*;
//Environment class

class env extends uvm_env;
`uvm_component_utils(env)

agent a;
sequence1 s1;

function new(string name = "env", uvm_component parent = null);
super.new(name, parent); 
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
a = agent::type_id::create("a", this);
s1= sequence1::type_id::create("s1");
endfunction

//Objection is used to hold the simulator
virtual task run_phase(uvm_phase phase);
phase.raise_objection(this);
s1.start(a.seqr);
phase.drop_objection(this);
endtask

endclass

