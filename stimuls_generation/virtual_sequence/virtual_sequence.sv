`include "uvm_macros.svh"
import uvm_pkg::*;

class transaction extends uvm_sequence_item;

  rand bit [3:0] a;
  rand bit [3:0] b;
       bit [4:0] y;
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
/*
  virtual task pre_body();
  `uvm_info("SEQ1","Pre-Body",UVM_MEDIUM)
endtask
*/
virtual task body();
`uvm_info("SEQ1","Body",UVM_MEDIUM)
`uvm_do(req)
req.print();
endtask
/*
virtual task post_body();
`uvm_info("SEQ1","Post-Body",UVM_MEDIUM)
endtask
*/
endclass

class sequence2 extends uvm_sequence#(transaction);
  `uvm_object_utils(sequence2)

  function new(input string name="sequence2");
    super.new(name);
  endfunction
/*
  virtual task pre_body();
  `uvm_info("SEQ2","Pre-Body",UVM_MEDIUM)
endtask
*/
virtual task body();
`uvm_info("SEQ2","Body",UVM_MEDIUM)
`uvm_do(req)
req.print();
endtask
/*
virtual task post_body();
`uvm_info("SEQ2","Post-Body",UVM_MEDIUM)
endtask
*/
endclass

class virtual_sequencer extends uvm_sequencer#(uvm_sequence_item);
    `uvm_component_utils(virtual_sequencer)
    uvm_sequencer#(transaction) seq1_h;
    uvm_sequencer#(transaction) seq2_h;

  function new(string name="virtual_sequencer",uvm_component parent=null);
      super.new(name,parent);
    endfunction
     
endclass


class virtual_sequence extends uvm_sequence#(uvm_sequence_item);
     
  `uvm_object_utils(virtual_sequence)
  virtual_sequencer v_seqr_h;
  
  function new(input string name="virtual_sequence");
    super.new(name);
  endfunction

  uvm_sequencer#(transaction) seqr1_h;
  uvm_sequencer#(transaction) seqr2_h;
  
  sequence1 s1;
  sequence2 s2;
  task body();
    if(!$cast(v_seqr_h,m_sequencer)) 
      `uvm_error(get_full_name(),"Virtual sequencer pointer casting failed")

    seqr1_h = v_seqr_h.seq1_h;
    seqr2_h = v_seqr_h.seq2_h;
    s1=sequence1::type_id::create("s1");
    s2=sequence2::type_id::create("s2");
    repeat(2) begin
      s1.start(seqr1_h);
      s2.start(seqr2_h);
    end

  endtask
      
endclass
/*
class virtual_sequence extends virtual_sequence_base;
  sequence1 s1;
  sequence2 s2;

  task body();
    super.body;
    s1=sequence1::type_id::create("s1");
    s2=sequence2::type_id::create("s2");
    repeat(2) begin
      s1.start(seqr1_h);
      s2.start(seqr2_h);
    end
  endtask

endclass
*/

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

   seq_item_port.item_done();
    end
  endtask

endclass :driver 

class agent extends uvm_agent;

  `uvm_component_utils(agent)
  driver d;

  uvm_sequencer #(transaction) s_h;
  //uvm_sequencer #(transaction) s2_h;

  function new(string name="agent",uvm_component parent=null);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  d=driver::type_id::create("d",this);
  s_h=uvm_sequencer#(transaction)::type_id::create("s_h",this);
  //s2_h=uvm_sequencer#(transaction)::type_id::create("s2_h",this);
endfunction

virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
d.seq_item_port.connect(s_h.seq_item_export);
//d.seq_item_port.connect(s2_h.seq_item_export);
endfunction

endclass


class environment extends uvm_env;

   `uvm_component_utils(environment)
   agent a1,a2;
   virtual_sequencer v_seqr_h;
   function new(string name="environment",uvm_component parent=null);
     super.new(name,parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    a1=agent::type_id::create("a1",this);
    a2=agent::type_id::create("a2",this);
    v_seqr_h=virtual_sequencer::type_id::create("v_seqr_h",this);
   endfunction

   virtual function void connect_phase(uvm_phase phase);
      v_seqr_h.seq1_h=a1.s_h;
      v_seqr_h.seq2_h=a2.s_h;
   endfunction

 endclass

 class test extends uvm_test;
   `uvm_component_utils(test)

  // sequence1 s1;
  // sequence2 s2;
   environment env;
   virtual_sequence v_seq_h;
   function new(string name="test",uvm_component parent=null);
     super.new(name,parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   env = environment::type_id::create("env",this);
   //s=sequence1::type_id::create("s");
   v_seq_h=virtual_sequence::type_id::create("v_seq_h");
 endfunction

 virtual task run_phase(uvm_phase phase);
 phase.raise_objection(this);

 v_seq_h.start(env.v_seqr_h);

 phase.drop_objection(this);
 endtask

 endclass

 module tb;
 initial begin
   run_test("test");  
 end
 endmodule


