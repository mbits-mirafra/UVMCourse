`include "uvm_macros.svh"
import uvm_pkg::*;

class object extends uvm_object;
  rand bit [3:0]a;
  rand bit [2:0]b;

  `uvm_object_utils_begin(object)
    `uvm_field_int(a,UVM_DEFAULT)
    `uvm_field_int(b,UVM_DEFAULT)
  `uvm_object_utils_end

  function new(string name = "object");
    super.new(name);
  endfunction:new

endclass:object

class sample;

  object obj_1,obj_2;

  function void creating();
    obj_1 = object::type_id::create("obj_1");
    obj_2 = object::type_id::create("obj_2");
  endfunction:creating

  function void randomization();
    void'(obj_1.randomize() with {a inside {1,2,3};});
    void'(obj_2.randomize() with {a inside {4,5,6};});
  endfunction:randomization

  function void comparing();
    if(obj_1.compare(obj_2))
    begin
      `uvm_info("v","obj_1 matching with obj_2",UVM_LOW)
      obj_1.print();
      obj_2.print();
    end
    else
    begin
      `uvm_error("v","obj_1 is not matching with obj_2")
      obj_1.print();
      obj_2.print();
    end
  endfunction:comparing

  function void copying();
    obj_2.copy(obj_1);
  endfunction:copying

endclass:sample

module top;

  sample s = new;

  initial begin:BEGIN_I
    
    s.creating();
    s.randomization();
    s.comparing();
    s.copying();
    s.comparing();
    $display("");

  end:BEGIN_I

endmodule:top
