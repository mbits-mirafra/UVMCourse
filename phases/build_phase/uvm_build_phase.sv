`include "uvm_macros.svh"
import uvm_pkg::*;

//-------------------------------------------------------
// This is a class extends using uvm_object.
// 
// uvm_object:
// This is a uvm base_class which is used for creating 
// an object class in testbench.
//-------------------------------------------------------
class object extends uvm_object;

  // This is a pre-defined uvm macros used to register 
  // the class name inside a factory as object.
  `uvm_object_utils(object)

  // These are some rand variables which will get 
  // random values during randomization.
  rand int a;
  rand int b;
  
  // This function is called a constructor.
  function new(string name = "object");
    super.new(name);
  endfunction

endclass

//-------------------------------------------------------
// This is a class extends using uvm_test.
//
// uvm_test:
// This is a uvm base_class which is derived from another
// uvm base_class uvm_component to create components in 
// testbench.
//-------------------------------------------------------
class test extends uvm_test;

  // This is a pre-defined uvm macros used to register 
  // the class name inside a factory as component.
  `uvm_component_utils(test)

  // This is a handle for the above created class.
  object obj;

  // This function is called a constructor.
  function new(string name = "test",uvm_component parent = null);
    super.new(name,parent);
  endfunction

  //-------------------------------------------------------
  // build_phase:
  //
  // This is a build phase function used to create objects 
  // of uvm_object and uvm_components classes.
  // Which works in top_bottom approach.
  //-------------------------------------------------------
  function void build_phase(uvm_phase phase);
    
    // This is used to call the parent class build phase 
    // where the backward call for build() method happens
    // to configure the fields which already registerd.
    super.build_phase(phase);
    
    if(obj == null)
      `uvm_info(get_type_name(),"object for the class was not created",UVM_NONE)
    else
      `uvm_info(get_type_name(),"object for the class was created",UVM_NONE)

    // This is used to create an object for a class
    obj = object::type_id::create("obj");
    
    if(obj == null)
      `uvm_info(get_type_name(),"object for the class was not created",UVM_NONE)
    else
      `uvm_info(get_type_name(),"object for the class was created",UVM_NONE)
  endfunction

endclass

module top;

initial begin

  //--------------------------------------------------------------------------------------
  // run_test:
  //
  // This is a pre-defined virtual task inside uvm_root class. It can have an argument as 
  // string test_name where we can pass uvm_test classes name as argumets.
  // or if a command-line plusarg, +UVM_TESTNAME=TEST_NAME, is found, then the specified 
  // component is created just prior to phasing.
  // 
  // The test may contain new verification components or the entire testbench, in which 
  // case the test and testbench can be chosen from the command line without forcing 
  // recompilation. If the global (package) variable, finish_on_completion, is set,
  // then $finish is called after phasing completes.
  //--------------------------------------------------------------------------------------

  run_test("test");

end

endmodule
