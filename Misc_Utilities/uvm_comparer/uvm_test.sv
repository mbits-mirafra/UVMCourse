`include "uvm_macros.svh"
import uvm_pkg::*;

class base_test extends uvm_test;
  
  //object diclaration
  transaction object1, object2;
  uvm_comparer comp;

  `uvm_component_utils(base_test)

  //default constructor
  function new(string name = "base_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //creating object
    object1 = transaction::type_id::create("object1", this);
    object2 = transaction::type_id::create("object2", this);
    comp = new();
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    // randomizing object
    assert(object1.randomize());
    assert(object2.randomize());


    //set policy
    comp.policy = UVM_SHALLOW;
    //set verbosity
    comp.verbosity = UVM_LOW;
    //set severity
    //comp.sev = UVM_WARNING;
    //total number of miscompares to be printed
    comp.show_max = 10;
    
    `uvm_info(get_full_name(), "Comparing objects", UVM_LOW)
    //comparing two object
    void'(comp.compare_object("tr_compare", object1, object2));
    object2.copy(object1);
    //comparing objects after copy 
    void'(comp.compare_object("tr_compare", object1, object2));
    //printing result of miscompares
    `uvm_info(get_full_name(), $sformatf("Comparing objects: result = %0d", comp.result), UVM_LOW)
        
    //comparing two integer
    void'(comp.compare_field_int("int_compare", 4'h2, 4'h4, 4));
    //comparing strings
    void'(comp.compare_string("string_compare", "team", "kachori"));
    //comparing real 
    void'(comp.compare_field_real("real compare", 4.5,4.5));
   
   `uvm_info(get_full_name(), $sformatf("Comparing objects: result = %0d", comp.result), UVM_LOW)
   
    void'(comp.compare_field_int("int_compare", 4'h4, 4'h4, 4));
    void'(comp.compare_string("string_compare", "kachori", "kachori")); 
    void'(comp.compare_field_real("real compare", 4.5,6.5));

    `uvm_info(get_full_name(), $sformatf("Comparing objects: result = %0d", comp.result), UVM_LOW)

  endtask
endclass
