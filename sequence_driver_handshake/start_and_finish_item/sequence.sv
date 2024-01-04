`include "uvm_macros.svh"
import uvm_pkg::*;
//Sequence class

class sequence1 extends uvm_sequence#(transaction);
`uvm_object_utils(sequence1)
transaction trans;

function new(string name = "sequence1");
super.new(name);    
endfunction

virtual task body();
 begin

//creating an item 

trans = transaction::type_id::create("trans");

//call the start_item task which will send the object to driver
start_item(trans);

`uvm_info("Sequence","start_item() function call done",UVM_NONE);

//randomizing
assert(trans.randomize());
`uvm_info("Sequence",$sformatf("randomised value, a:%0d , b:%0d" ,trans.a,trans.b), UVM_NONE);

//call finish_item method so that sequence waits untill the driver
//lets the sequencer know that this item has finished

finish_item(trans);
`uvm_info("Sequence","finish_item() function call done",UVM_NONE);
end
endtask

endclass

