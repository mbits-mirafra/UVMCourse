`include "uvm_macros.svh"
import uvm_pkg::*;

class test extends uvm_test;

  int a;

  `uvm_component_utils_begin(test)
    `uvm_field_int(a,UVM_DEFAULT)
  `uvm_component_utils_end
  
  function new(string name = "test", uvm_component parent = null);
    super.new(name,parent);
    a = 10;
    `uvm_info("new",$sformatf("a = %0d",a),UVM_LOW)
  endfunction:new
                                      
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    a = 20;
    `uvm_info("build",$sformatf("a = %0d",a),UVM_LOW)
  endfunction:build_phase

  virtual function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    a = 30;
    `uvm_info("EOE",$sformatf("a = %0d",a),UVM_LOW)
  endfunction:end_of_elaboration_phase
                        
  virtual function void start_of_simulation_phase(uvm_phase phase);
    super.start_of_simulation_phase(phase);
    `uvm_info("SOS","now i am in start of simulation phase",UVM_LOW)
    `uvm_info("SOS","next going to run phase",UVM_LOW)
  endfunction:start_of_simulation_phase
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
      phase.raise_objection(this);
      `uvm_info("run",$sformatf("a = %0d",a),UVM_LOW)
      phase.drop_objection(this);
  endtask:run_phase 

endclass:test

module top;

  initial begin

    run_test("test");

  end

endmodule:top
