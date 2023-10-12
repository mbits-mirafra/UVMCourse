`include "uvm_macros.svh"
import uvm_pkg::*;

//Extend seq from uvm_sequence_item
class seq extends uvm_sequence_item;

  //a is rand variable and bit data type
  rand bit a;

  //UVM Factory Registration Macro
  `uvm_object_utils_begin(seq)
  `uvm_field_int(a,UVM_DEFAULT)
  `uvm_object_utils_end

  //constructor Method
  function new(input string name = "seq");
    super.new(name);
  endfunction

endclass

module top;
  seq s1;

  //Within initial
  initial 
          begin
          //create an instance of seq using factory creat()
            s1= seq::type_id::create("s1");
            //repeating 5 time using repeat
            repeat(5) 
                begin
            //usimg `uvm_info to displaying
                `uvm_info("INFO","factory is created by using create method",UVM_NONE);
       void'(s1.randomize());
    
       s1.print();
    end
  end
endmodule
