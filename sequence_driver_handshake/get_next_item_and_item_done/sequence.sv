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
   repeat(2) begin
//creating an item 

trans = transaction::type_id::create("trans");

`uvm_info("Sequence","Sequence item is created",UVM_NONE)

wait_for_grant();
`uvm_info("Sequence","Grant received now randomizing the data",UVM_NONE)
assert(trans.randomize());
`uvm_info("Sequence",$sformatf("randomised value, a:%0d , b:%0d" ,trans.a,trans.b), UVM_NONE);
`uvm_info("Sequence","Randmization done and now sent request to driver",UVM_NONE)
send_request(trans);
`uvm_info("Sequence","Waiting for item done response from driver",UVM_NONE);
wait_for_item_done();
`uvm_info("Sequence","Ack.recieved from driver,Sequence ended",UVM_NONE)
end
end
endtask

endclass

