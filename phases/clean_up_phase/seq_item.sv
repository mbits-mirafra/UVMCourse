`include "uvm_macros.svh"
import uvm_pkg::*;

class seq_item extends uvm_sequence_item;

  rand bit [2:0] a;
  rand bit [2:0] b;
  bit [3:0] y;
  int value = 5;
                
  function new (string name = "seq_item");
    super.new(name);
  endfunction
                                    
  `uvm_object_utils_begin(seq_item)
  `uvm_field_int(a,UVM_DEFAULT)
  `uvm_field_int(b,UVM_DEFAULT)
  `uvm_field_int(y,UVM_DEFAULT)
  `uvm_object_utils_end

endclass:seq_item
