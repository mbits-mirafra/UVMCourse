`include "uvm_macros.svh"
import uvm_pkg::*;

class transaction extends uvm_sequence_item;
  rand bit [3:0] a;
  rand bit [3:0] b;
  bit [3:0] y;

  `uvm_object_utils_begin(transaction)
  `uvm_field_int(a,UVM_DEFAULT)
  `uvm_field_int(b,UVM_DEFAULT)
  `uvm_field_int(y,UVM_DEFAULT)
  `uvm_object_utils_end

  function new(input string name="transaction");
    super.new(name);
  endfunction

endclass : transaction

class sequence1 extends uvm_sequence#(transaction);
  `uvm_object_utils(sequence1)

  function new(input string name="sequence1");
    super.new(name);
  endfunction

  virtual task pre_start();
  `uvm_info("SEQ1","Pre-Start",UVM_MEDIUM)
endtask

virtual task pre_body();
`uvm_info("SEQ1","Pre-Body",UVM_MEDIUM)
   endtask

   virtual task pre_do(bit is_item);
   `uvm_info("SEQ1","Pre-Do",UVM_MEDIUM)
 endtask

 virtual function void mid_do(uvm_sequence_item this_item);
 `uvm_info("SEQ1","Mid-Do",UVM_MEDIUM)
    endfunction

    virtual task body();
    `uvm_info("SEQ1","Body",UVM_MEDIUM)
    repeat(2) begin
      req=transaction::type_id::create("req");
      start_item(req);
      assert(req.randomize());
      // req.print();
      finish_item(req);

  end
endtask

virtual function void post_do(uvm_sequence_item this_item);
`uvm_info("SEQ1","Post-Do",UVM_MEDIUM)
endfunction

virtual task post_body();
`uvm_info("SEQ1","Post-Body",UVM_MEDIUM)
      endtask

      virtual task post_start();
      `uvm_info("SEQ1","Post-Start",UVM_MEDIUM)
    endtask
  endclass

  class driver extends uvm_driver#(transaction);

    `uvm_component_utils(driver)

    transaction t;

    function new(input string name="driver",uvm_component parent = null);
      super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    t=transaction::type_id::create("t");
  endfunction

  virtual task run_phase(uvm_phase phase);
  forever begin
    seq_item_port.get_next_item(t);
    /////////////////
    seq_item_port.item_done();
  end
endtask

endclass :driver

class agent extends uvm_agent;

  `uvm_component_utils(agent)
  driver d;
  uvm_sequencer #(transaction) seqr;

  function new(string name="agent",uvm_component parent=null);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  d=driver::type_id::create("d",this);
  seqr=uvm_sequencer#(transaction)::type_id::create("seqr",this);
endfunction

virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
d.seq_item_port.connect(seqr.seq_item_export);
   endfunction

 endclass


 class environment extends uvm_env;

   `uvm_component_utils(environment)
   agent a;
   function new(string name="environment",uvm_component parent=null);
     super.new(name,parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   a=agent::type_id::create("a",this);
 endfunction

  endclass

  class test extends uvm_test;
    `uvm_component_utils(test)

    sequence1 s;
    environment env;
    function new(string name="test",uvm_component parent=null);
      super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = environment::type_id::create("env",this);
    s=sequence1::type_id::create("s");
  endfunction

  virtual task run_phase(uvm_phase phase);
 // phase.raise_objection(this);

  //s.start(env.a.seqr,null,0,1);  //call_pre_post = 1
  s.start(env.a.seqr,null,0,0);//call_pre_post = 0

  //phase.drop_objection(this);
endtask

  endclass

  module tb;
  initial begin
    run_test("test");
  end
  endmodule

