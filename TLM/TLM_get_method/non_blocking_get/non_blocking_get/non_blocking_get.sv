
`include "uvm_macros.svh"
import uvm_pkg::*;


// Creating a transaction class 
class transaction extends uvm_object;
 // `uvm_object_utils(transaction)
  rand bit [3:0] a;
  rand bit [4:0] b;

`uvm_object_utils_begin(transaction)
`uvm_field_int(a,UVM_DEFAULT)
`uvm_field_int(b,UVM_BIN)
`uvm_object_utils_end 

  function new (string st="transaction");
    super.new(st);
  endfunction 
endclass 
  

// Creating a sender class which is extends uvm_component class 
 class sender extends uvm_component;
   `uvm_component_utils(sender);
   uvm_nonblocking_get_imp #(transaction,sender) get_imp;
   transaction trans;
   function new ( string name ="sender",uvm_component parent = null);
     super.new(name,parent);
   endfunction 
  
   
   virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
   get_imp=new("get_imp",this);
 endfunction 

 virtual function bit try_get(output transaction trans);
 trans=new();  // create new packet 
 
 void'(trans.randomize());
 `uvm_info("Sender","Reciever has requested for transaction",UVM_NONE);
 trans.print(uvm_default_table_printer);
 return 1;
 endfunction

 virtual function bit can_get();
 endfunction 

 endclass 

// Creating a reciever class
class reciever extends uvm_component;
  `uvm_component_utils(reciever)
uvm_nonblocking_get_port #(transaction) get_port;

function new (string name ="reciever",uvm_component parent=null);
  super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
get_port=new("get_port",this);
endfunction 

virtual task run_phase(uvm_phase phase);
transaction trans;
phase.raise_objection(this);
for(int i=0;i<=1;i++)begin
  if(get_port.try_get(trans)) 
  `uvm_info("Reciever","Just now recieved transaction from reciever",UVM_NONE)
 
  //`uvm_info("Reciever","DONE",UVM_NONE) 
else 
  `uvm_info("Reciever","Transaction not recieved",UVM_NONE)

  phase.print(uvm_default_table_printer);
  `uvm_info("Reciever","DONE",UVM_NONE)
end 
phase.drop_objection(this);
endtask

endclass 

// creating a test clas extends from uvm_test class for higher implementation and conne ction 

class my_test extends uvm_test;
  `uvm_component_utils(my_test)
 sender sndr;
 reciever rcvr;
  function new(string name = "my_test",uvm_component parent =null);
    super.new(name,parent);
  endfunction 

    virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    sndr=sender::type_id::create("sndr",this);
    rcvr=reciever::type_id::create("rcvr",this);
  endfunction 

//Connection between sender to reciever
virtual function void connect_phase(uvm_phase phase);
//super.connect_phase(phase);
rcvr.get_port.connect(sndr.get_imp);
endfunction 

endclass 

module mod;
initial begin 
  run_test("my_test");
end 
endmodule 











