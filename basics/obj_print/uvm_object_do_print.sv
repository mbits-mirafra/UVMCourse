import uvm_pkg::*;
`include "uvm_macros.svh"

class example extends uvm_object;
string b;
bit [2:0]c;

`uvm_object_utils(example)

function new(string name="example");
  super.new(name);
  this.b="HELLO";
  this.c=4;

endfunction

function void do_print(uvm_printer printer);
  super.do_print(printer);
  printer.print_string("b",b);
  printer.print_int("c",c,$bits(c));
endfunction

endclass
