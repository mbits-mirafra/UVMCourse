
`include "uvm_macros.svh"

import uvm_pkg::*;
//Driver class

class driver extends uvm_driver#(transaction);
`uvm_component_utils(driver)
transaction trans;

function new(input string name = "DRV", uvm_component parent);
super.new(name,parent);
endfunction

virtual task run_phase(uvm_phase phase); 
trans = transaction::type_id::create("trans");
forever begin
`uvm_info("Driver", "Waiting for data from sequencer", UVM_NONE);

//get an item from sequencer using get_next method
//Instead of get_next_item, we can use get(req)
seq_item_port.get_next_item(req);
`uvm_info("Driver", $sformatf("Start driving data, a : %0d b:%0d", req.a, req.b), UVM_NONE);

//call the item_done method to send the request item back to sequencer
//Instead of item_done, we can use put(req)
seq_item_port.item_done();     
`uvm_info("Driver", $sformatf("Finish driving data, a : %0d b:%0d", req.a, req.b), UVM_NONE);

end
endtask

endclass
