`include "uvm_macros.svh"
import uvm_pkg::*;

//Extend seq from uvm_sequence_item
class seq extends uvm_sequence_item;

  //a is rand variable and bit data type
  rand int a;

  //UVM Factory Registration Macro
  `uvm_object_utils_begin(seq)
  `uvm_field_int(a,UVM_DEFAULT)
  `uvm_object_utils_end

  //constructor Method
  function new(input string name = "seq");
    super.new(name);
  endfunction
  
  //constraint Method
  constraint cons1{a inside {[5:10]};}
endclass


//Extend extend_seq from seq;
class extend_seq extends seq;
  //UVM Factory Registration 
  `uvm_object_utils(extend_seq);
  
  //constructor Method
  function new (input string name="extend_seq");
    super.new(name);
  endfunction

  //constraint method
  constraint cons2 {a inside {9};}
endclass

module top;
  seq s1;
  extend_seq s2;
  //Within initial
  initial 
          begin
          //create an instance of seq using factory create method
         s1=seq::type_id::create("s1");  
 //         s1=new();
            //repeating 5 time using repeat
            repeat(5)  begin
                //usimg `uvm_info to displaying
                `uvm_info("A_INFO","1...before global_overriding ",UVM_NONE);
                void'(s1.randomize());
                s1.print();
            end
                factory.set_type_override_by_type(seq::get_type(),extend_seq::get_type());
         s1=seq::type_id::create("s1");  
        // s1=new();
            repeat(5)  begin
                //usimg `uvm_info to displaying
                `uvm_info("B_INFO","2...after factory overriding by using global_override ",UVM_NONE);
                void'(s1.randomize());
                s1.print();
            end
  end
  endmodule
