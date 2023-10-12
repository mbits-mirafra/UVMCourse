
`include "uvm_macros.svh"
import uvm_pkg::*;

class transaction extends uvm_sequence_item;
  rand bit [6:0] a;
  rand bit [3:0] b;
  rand  bit [3:0] y;

  `uvm_object_utils_begin(transaction)
  `uvm_field_int(a,UVM_DEC)
  `uvm_field_int(b,UVM_HEX)
  `uvm_field_int(y,UVM_ALL_ON)
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
transaction trans;
  virtual task pre_body();
    `uvm_info("SEQ1","Pre-Body",UVM_MEDIUM)
  endtask

  virtual task body();

    `uvm_info("SEQ1","Body",UVM_MEDIUM)

 `uvm_info("SEQ1","Sequence item is created",UVM_NONE)
 trans= transaction::type_id::create("trans");
 `uvm_info("SEQ1","Waiting for the Grant from Driver",UVM_NONE)
 wait_for_grant();
 `uvm_info("SEQ1","Grant received now randomizing the data",UVM_NONE)
 assert(trans.randomize());
 trans.print();
 `uvm_info("SEQ1","Randmization done and now sent request to driver",UVM_NONE)
 send_request(trans);
`uvm_info("SEQ1","Waiting for item done response from driver",UVM_NONE)
wait_for_item_done();
`uvm_info("SEQ1","SEQ ended",UVM_NONE)
endtask

  virtual task post_body();
    `uvm_info("SEQ1","Post-Body",UVM_NONE)
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
    phase.raise_objection(this);
    
    s.start(env.a.seqr);

    phase.drop_objection(this);
  endtask
   
endclass

module tb;

   initial begin
       run_test("test");
   end
endmodule
