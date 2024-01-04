//Access the uvm macros
`include "uvm_macros.svh"
// Access the uvm package i.e uvm class
import uvm_pkg::*;

//component class
class driver extends uvm_driver;

//factory registration
`uvm_component_utils(driver); 

//All component in the uvm base class as default constructor expecting two arguments
  function new(string name = "", uvm_component parent);
    super.new(name,parent);
  endfunction

//Build phase responsible for building all the lower level components, execute in bottom-up manner
 virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
 endfunction 

//run phase execute in the parallel run phase comes under task
 task run_phase(uvm_phase phase);
 super.run_phase(phase);

  //start of test sequence
   phase.raise_objection(this);
  $display("");
  #1;
  //The verbosite level lower then UVM_DEFAULT VERBOSITY will be printed
  `uvm_info("DRV", "verbosity level is uvm none i.e 0", UVM_NONE); 
  $display("");
  #2;
  //The verbosite level lower then UVM_DEFAULT VERBOSITY will be printed
  `uvm_info("DRV", "verbosity level is uvm low i.e 100", UVM_LOW); 
  $display("");
  #3;
  //The verbosite level lower then or equal to  UVM_DEFAULT VERBOSITY will be printed
  `uvm_info("DRV", "verbosity level is uvm medium i.e 200", UVM_MEDIUM);  
  $display("");
  #4;
  //The verbosity level higher then the UVM_DEFAULT VERBOSITY then it will not printed
  `uvm_info("DRV", "verbosity level is uvm high i.e 300", UVM_HIGH); 
  $display("");
  #5;
  //The verbosity level higher then the UVM_DEFAULT VERBOSITY then it will not printed
  `uvm_info("DRV", "verbosity level is uvm full i.e 400", UVM_FULL); 
  $display("");
  #6;
  //The verbosity level higher then the UVM_DEFAULT VERBOSITY then it will not printed
  `uvm_info("DRV", "verbosity level is uvm  Debug i.e 500", UVM_DEBUG); 
  $display("");
  
  //end of test sequence
  phase.drop_objection(this);

  endtask 
        
endclass

                
        
 
module tb;
       
//class handle
driver drv;

  initial begin:B1

   //Here we creating the object, using factory overriding
   drv = driver::type_id::create("drv",null);

   //TO SET THE UVM VERBOSITY LEVEL
  drv.set_report_verbosity_level(UVM_DEBUG); 

  //run tb module
  run_test();
  end:B1

endmodule:tb
