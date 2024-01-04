
`include "uvm_macros.svh"
import uvm_pkg::*;
//Agent class

class agent extends uvm_agent;
`uvm_component_utils(agent)

//Inbuilt uvm_sequencer class is used directly
sequencer seqr;
driver d;

function new(string name = "agent", uvm_component parent = null);
super.new(name, parent); 
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
d = driver::type_id::create("DRV",this);
seqr = sequencer::type_id::create("seqr", this);
endfunction

//Connecting driver and sequencer

virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
d.seq_item_port.connect(seqr.seq_item_export);
endfunction

endclass

