import uvm_pkg::*;
`include "uvm_macros.svh"
class example extends uvm_object;
  int a[3];
  string b;
  bit [2:0]c;

  `uvm_object_utils_begin(example)
    `uvm_field_sarray_int(a, UVM_DEFAULT)
    `uvm_field_string(b, UVM_DEFAULT)
    `uvm_field_int(c, UVM_DEFAULT)
  `uvm_object_utils_end



  function new(string name="example");
    super.new(name);
    this.a={1,2,3};
    this.b="HELLO";
    this.c=4;

  endfunction
endclass
