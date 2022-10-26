//Access to all uvm macros
`include "uvm_macros.svh"
//Access to all uvm pkg i.e all uvm class
import uvm_pkg::*;

module top;
 initial begin:B1
  $display("");
  //UVM_NONE is LOWER THEN UVM_DEFAULT IT IS PRINTED  
  `uvm_info("TOP", "verbosity level is uvm none i.e 0", 0);
  #5;  
  $display("");
  //UVM_LOW is LOWER THEN UVM_DEFAULT IT IS PRINTED  
  `uvm_info("TOP", "verbosity level is uvm low i.e 100", 100);
  #5;  
  $display("");
  //UVM_MEDIUM is LOWER THEN UVM_DEFAULT IT IS PRINTED
  `uvm_info("TOP", "verbosity level is uvm medium i.e 200", 200);
  #5;  
  $display("");
  //UVM_LOW is LOWER THEN UVM_DEFAULT IT IS PRINTED  
  `uvm_info("TOP", "verbosity level is uvm low i.e 100", 100);
  #5;  
  $display("");
  //UVM_LOW is LOWER THEN UVM_DEFAULT IT IS PRINTED  
  `uvm_info("TOP", "verbosity level is uvm low i.e 100", 100);
  #5;  
  $display("");
  //UVM_NONE is LOWER THEN UVM_DEFAULT IT IS PRINTED  
  `uvm_info("TOP", "verbosity level is uvm none i.e 0", 0);
 end:B1  
endmodule      
