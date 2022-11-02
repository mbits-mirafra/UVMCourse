`include "uvm_macros.svh"
import uvm_pkg::*;

class test extends uvm_test;

  `uvm_component_utils(test);
  seq se;
  agent a;

  function new(string name = "test", uvm_component parent=null);
    super.new(name,parent);
  endfunction
                              
//build phase

  virtual function void build_phase(uvm_phase phase);

    super.build_phase(phase);
    se = seq::type_id::create("seq");
    a = agent::type_id::create("agent",this);

  endfunction
                              
//run phase

  virtual task run_phase(uvm_phase phase);

    super.run_phase(phase);
    phase.raise_objection(this);
    se.start(a.s);
    phase.drop_objection(this);

  endtask:run_phase
                                                                  
endclass:test
