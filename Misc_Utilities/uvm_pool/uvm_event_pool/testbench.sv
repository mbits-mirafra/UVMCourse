
`include "uvm_macros.svh"
import uvm_pkg::*;

uvm_event_pool e_pool;
//`include "components.sv"

class base_test extends uvm_test;
  `uvm_component_utils(base_test)

  compA comp_a;
  compB comp_b;
  compC comp_c;

  function new(string name = "base_test",uvm_component parent=null);
    super.new(name,parent);
    e_pool = new("e_pool");
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    comp_a = compA::type_id::create("comp_a", this);
    comp_b = compB::type_id::create("comp_b", this);
    comp_c = compC::type_id::create("comp_c", this);
  endfunction : build_phase

  function void end_of_elaboration();
    uvm_top.print_topology();
  endfunction
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    #20;
    phase.drop_objection(this);
  endtask

endclass

