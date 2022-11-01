
`include "uvm_macros.svh"

import uvm_pkg::*;
//test class

class test extends uvm_test;
`uvm_component_utils(test)

env e;

function new(string name = "test", uvm_component parent = null);
super.new(name, parent); 
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
e = env::type_id::create("e", this);  
endfunction
endclass

