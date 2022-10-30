`include "uvm_macros.svh"
import uvm_pkg::*;

class transaction extends uvm_sequence_item;
  rand bit [3:0] a;
  rand bit [3:0] b;
  rand  bit [3:0] y;

  `uvm_object_utils_begin(transaction)
  `uvm_field_int(a,UVM_ALL_ON)
  `uvm_field_int(b,UVM_ALL_ON)
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
transaction trans1;
transaction trans2;
//transaction trans3;

virtual task body();
`uvm_create(trans1)   // create the trans1 object 

`uvm_info("Trans1","Trans1 is created",UVM_NONE);
void'(trans1.randomize());
`uvm_info("Trans1","Trans1 is randomize",UVM_NONE);
`uvm_send(trans1) // sending the trans1
trans1.print();
`uvm_info("Trans1", "Create , Randomization and send all done for trans1 ",UVM_NONE);

`uvm_create(trans2)
`uvm_info("Trans2","Trans2 is created",UVM_NONE)
`uvm_rand_send(trans2)   // Randomization and send of data in one step 
`uvm_info("Trans","Trans2 is randomize and the send data",UVM_NONE)
trans2.print();
`uvm_info("Trans2","using with ",UVM_NONE)
`uvm_rand_send_with(trans2,{trans2.a==2;
                            trans2.b==4;})    // using inline constraint 
trans2.print();
`uvm_info("Trans2","Create , randomization and send is done for trans2",UVM_NONE)



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
