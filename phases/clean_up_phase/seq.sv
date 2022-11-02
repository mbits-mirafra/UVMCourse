`include "uvm_macros.svh"
import uvm_pkg::*;

class seq extends uvm_sequence#(seq_item);
  `uvm_object_utils(seq);
  seq_item st;
          
  function new(string name = "seq");
    super.new(name);
  endfunction
                        
  virtual task body();

    st = seq_item::type_id::create("seq_item");
    `uvm_info(get_type_name(), "Randomizing the values", UVM_MEDIUM)

    repeat(st.value)
    begin

      `uvm_do(st);

    end

    `uvm_info(get_type_name(), "Randomization done", UVM_MEDIUM)

  endtask:body
                                                                                    
endclass:seq
