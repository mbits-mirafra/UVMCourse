//Access the uvm macros
`include "uvm_macros.svh"
// Access the uvm package i.e uvm class
import uvm_pkg::*;

//component class
class dilip extends uvm_driver;

        rand bit[3:0] d;
//factory registration
`uvm_component_utils(dilip); 

//All component in the uvm base class as default constructor expecting two arguments
  function new(string name = "", uvm_component parent);
    super.new(name,parent);
  endfunction

task display();
  
  //start of test sequence
  $display("");
  #1;
  //The verbosity level lowest then UVM_DEFAULT VERBOSITY will be printed
  `uvm_info("DILIP", $sformatf("[UVM_NONE]value of d is %0d",d), UVM_NONE); 
  $display("");
  #2;
  //The verbosity level lowest then UVM_DEFAULT VERBOSITY will be printed
  `uvm_info("DILIP", $sformatf("[UVM_LOW]value of d is %0d",d), UVM_LOW); 
  $display("");
  #3;

  //The verbosity level lowest then UVM_DEFAULT VERBOSITY will be printed
  `uvm_info("DILIP", $sformatf("[UVM_MEDIUM]value of d is %0d", d),UVM_MEDIUM);  
  $display("");
  #4;
  //The verbosity level higher then the UVM_DEFAULT VERBOSITY then it will not printed
  `uvm_info("DILIP", $sformatf("[UVM_HIGH]value of d is %0d",d), UVM_HIGH); 
  $display("");
  #5;
  //The verbosity level higher then the UVM_DEFAULT VERBOSITY then it will not printed
  `uvm_info("DILIP", $sformatf("[UVM_FULL]value of d is %0d",d), UVM_FULL); 
  $display("");
  #6;
  //The verbosity level higher then the UVM_DEFAULT VERBOSITY then it will not printed
  `uvm_info("DILIP", $sformatf("[UVM_DEBUG]value of d is %0d",d), UVM_DEBUG); 
  $display("");
  
  //end of test sequence

  endtask 
        
endclass

                
        
 
module tb;
       
//class handle
dilip dk;

  initial begin:B1

   //Here we creating the object, using factory overriding
   dk = dilip::type_id::create("dk",null);

   //TO SET THE UVM VEROSITY LEVEL
   dk.set_report_verbosity_level(UVM_DEBUG);
   //object.randomize();
   void'(dk.randomize());
   //object.method
   dk.display();
  end:B1

endmodule:tb
