`include "uvm_macros.svh"
import uvm_pkg::*;

class agent extends uvm_agent;
  
  `uvm_component_utils(agent)
  sequencer s;
  driver d;
              
  function new(string name = "agent", uvm_component parent=null);
    super.new(name,parent);
  endfunction:new
                             
//build phase

  virtual function void build_phase(uvm_phase phase);

    super.build_phase(phase);
    s = sequencer::type_id::create("sequencer",this);
    d = driver::type_id::create("driver",this);

  endfunction:build_phase

//connect phase - No other classes or files in driver so no use

  function void connect_phase(uvm_phase phase);

    super.connect_phase(phase);
    d.seq_item_port.connect(s.seq_item_export);

  endfunction:connect_phase

endclass:agent
