`include "uvm_macros.svh"
import uvm_pkg::*;

class object extends uvm_sequence_item;

  rand int a;

  `uvm_object_utils_begin(object)
    `uvm_field_int(a,UVM_DEFAULT)
  `uvm_object_utils_end

  function new(string name = "object");
    super.new(name);
  endfunction

endclass

class object1 extends uvm_sequence#(object);

  `uvm_object_utils(object1)

  object obj;

  function new(string name = "object1");
    super.new(name);
  endfunction

  task body();
    obj = object::type_id::create("obj");
    start_item(obj);
    assert(obj.randomize() with {a inside {1,2,3,4,5};});
    `uvm_info(get_type_name(),$sformatf("a = %0d",obj.a),UVM_NONE)
    finish_item(obj);
  endtask

endclass

class transmitter extends uvm_sequencer#(object);

  `uvm_component_utils(transmitter)

  object obj;
  
  // This function is called a constructor.
  function new(string name = "transmitter",uvm_component parent = null);
    super.new(name,parent); 
  endfunction
endclass

class reciever extends uvm_driver#(object);

  `uvm_component_utils(reciever)

  object obj;

  function new(string name = "reciever",uvm_component parent = null);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    obj = object::type_id::create("obj");
  endfunction

  task run_phase(uvm_phase phase);
  forever
  begin
    seq_item_port.get_next_item(obj);
      `uvm_info(get_type_name(),$sformatf("a = %0d",obj.a),UVM_NONE)
    seq_item_port.item_done();
  end
  endtask

endclass

class agent extends uvm_agent;

  `uvm_component_utils(agent)
  
  transmitter trans;
  reciever rec;
  
  function new(string name = "agent",uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    
    super.build_phase(phase);
    
    trans = transmitter::type_id::create("trans",this);
    rec = reciever::type_id::create("rec",this);

  endfunction
  
  function void connect_phase(uvm_phase phase);
    rec.seq_item_port.connect(trans.seq_item_export);
  endfunction
  
endclass
/*
class environment extends uvm_env;
  
  `uvm_component_utils(environment)
  agent a;
  
  function new(string name = "component",uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    a = agent::type_id::create("a",this);
  endfunction
endclass
*/
class test extends uvm_test;
  
  `uvm_component_utils(test)
  
  object1 obj1;
  agent a;
  
  function new(string name = "test",uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    obj1 = object1::type_id::create("obj1");
    a = agent::type_id::create("a",this);
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    obj1.start(a.trans);
    phase.drop_objection(this);
  endtask
endclass

module top;

initial begin

  run_test("test");

end

endmodule
