
//uvm_marcos.svh is a macros definition file
//importing uvm package

`include "uvm_macros.svh"
import uvm_pkg::*;

//uvm_severity indicates the importance of the message to be displayed.

//UVM Severity methods are defined as:

//uvm_report_info, uvm_report_warning, uvm_report_error, uvm_report_fatal

//Here creating test class from uvm_test base class

class test extends uvm_test;

//factory registration for component 
`uvm_component_utils(test)

//default new constructor

function new(string name,uvm_component parent);
super.new(name, parent);

//uvm severities

uvm_report_info("TEST","inoformation severity--1 (info_none)", UVM_NONE);
uvm_report_info("TEST","inoformation severity--1 (info_none)", UVM_NONE,`__FILE__,`__LINE__);
uvm_report_error("TEST", "Error 1",UVM_NONE,`__FILE__,`__LINE__); 
uvm_report_warning("TEST", "Warning occured", UVM_NONE,`__FILE__,`__LINE__);
uvm_report_fatal("TEST", "A fatal error has occurred",UVM_NONE,`__FILE__,`__LINE__); 
endfunction

endclass

module top;
initial 
begin
  run_test("test");
end
endmodule
