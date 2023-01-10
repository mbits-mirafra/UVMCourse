`include "uvm_macros.svh"
import uvm_pkg::*;

class transaction extends uvm_sequence_item;
  rand bit [2:0] a;
  rand bit [2:0] b;
  rand bit [2:0] c;

  `uvm_object_utils_begin(transaction)
  `uvm_field_int(a,UVM_DEFAULT)
  `uvm_field_int(b,UVM_DEFAULT)
  `uvm_field_int(c,UVM_DEFAULT)
  `uvm_object_utils_end

  function new(input string name="transaction");
       super.new(name);
     endfunction

   endclass

class seq1 extends uvm_sequence#(transaction);
  `uvm_object_utils(seq1)

  function new(input string name="sequence1");
    super.new(name);
  endfunction

  virtual task body();
      req=transaction::type_id::create("req");
      `uvm_info("SEQ1","SEQ1_Started",UVM_MEDIUM); 
      start_item(req);
      void'(req.randomize());
      req.print(uvm_default_tree_printer);
      finish_item(req);
      `uvm_info("SEQ1","SEQ1_Ended",UVM_MEDIUM); 
  endtask


endclass

class seq2 extends uvm_sequence#(transaction);
  `uvm_object_utils(seq2)

  function new(input string name="sequence2");
    super.new(name);
  endfunction

  virtual task body();
      req=transaction::type_id::create("req");
      `uvm_info("SEQ2","SEQ2_Started",UVM_MEDIUM); 
      start_item(req);
    void'(req.randomize());
      req.print(uvm_default_tree_printer);
      finish_item(req);
      `uvm_info("SEQ2","SEQ2_Ended",UVM_MEDIUM); 
  endtask


endclass

class my_seq_lib extends uvm_sequence_library#(transaction);
     `uvm_object_utils(my_seq_lib)
     `uvm_sequence_library_utils(my_seq_lib)
     seq1 s1;
     seq2 s2;
     function new(string name="my_seq_lib");
       super.new(name);
    selection_mode=UVM_SEQ_LIB_RANDC;
    min_random_count=5;
    max_random_count=10;
       
    s1=seq1::type_id::create("s1");
    s2=seq2::type_id::create("s2");
    add_typewide_sequence(s1.get_type());
    add_typewide_sequence(s2.get_type());

       init_sequence_library();
     endfunction
      
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
  my_seq_lib seq_lib;
  environment env;

  function new(string name="test",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = environment::type_id::create("env",this);
    seq_lib=my_seq_lib::type_id::create("seq_lib");
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    uvm_config_db#(uvm_sequence_base)::set(this,"env.a.seqr.main_phase","default_sequence",seq_lib);
   seq_lib.print();
    phase.drop_objection(this);
  endtask
endclass

module tb;
   initial begin
       run_test("test");  
   end
endmodule
