`include "uvm_macros.svh"
import uvm_pkg::*;


class my_object extends uvm_object;

  function new(string name = "my_object");
    super.new(name);
    `uvm_info("NEW", "creating my_object class", UVM_LOW)
  endfunction

  function void display();

    `uvm_info("1", "hi_high", UVM_HIGH)
    `uvm_info("2", "hello_none", UVM_NONE)
    `uvm_info("3", "ciao_deb", UVM_DEBUG)
    `uvm_info("4", "hey_med", UVM_MEDIUM)
    `uvm_info("5", "hola_low", UVM_LOW)
    `uvm_info("6", "bonjour_full", UVM_FULL)

  endfunction:display

endclass:my_object

module tb();

  my_object mb;
  
  initial begin

    mb = new;
    mb.display();
  
  end

endmodule
