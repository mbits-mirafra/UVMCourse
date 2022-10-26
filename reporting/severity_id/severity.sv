
//uvm_marcos.svh is a macros definition file
//importing uvm package

`include "uvm_macros.svh"
import uvm_pkg::*;

//uvm_severity indicates the importance of the message to be displayed.

//UVM Severity are defined as:

//UVM_INFO, UVM_WARNING, UVM_ERROR, UVM_FATAL

//Here creating test class from uvm_test base class

class test extends uvm_test;

//factory registration for component 
`uvm_component_utils(test)

//default new constructor

function new(string name,uvm_component parent);
super.new(name, parent);

//uvm severities

`uvm_info("TEST","inoformation severity--1 (info_none)", UVM_NONE);
`uvm_info(get_name(),"get_name() information severity--3 (info_low)", UVM_LOW);
`uvm_info(get_full_name(),"get_full_name() inoformation severity--1 (info_none)", UVM_NONE);
`uvm_info(get_type_name(),"get_type_name() information severity--2 (info_medium)", UVM_MEDIUM);
endfunction

endclass

module top;
initial 
begin
  run_test("test");
end
endmodule
