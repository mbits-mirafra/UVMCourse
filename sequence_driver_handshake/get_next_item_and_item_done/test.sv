
`include "uvm_macros.svh"

import uvm_pkg::*;
//test class

class test extends uvm_test;
`uvm_component_utils(test)

sequence1 s1;
env e;

function new(string name = "test", uvm_component parent = null);
super.new(name, parent); 
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
s1= sequence1::type_id::create("s1");
e = env::type_id::create("e", this);  
endfunction

virtual task run_phase(uvm_phase phase);
phase.raise_objection(this);
s1.start(e.a.seqr);
phase.drop_objection(this);
endtask

endclass

