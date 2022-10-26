`include "uvm_macros.svh"
import uvm_pkg::*;

typedef enum{RED, GREEN, BLUE} color_type;

class my_object extends uvm_object;

  color_type c;

  function  new(string name="my_object");

    super.new(name);
    `uvm_info("NEW", "creating my_object", UVM_LOW)

  endfunction

  function void display();
    for(int i = 0;i<3;i++)begin

    `uvm_info("my_object created", $sformatf("colour: %0s", c.name()), UVM_LOW)
    
    `uvm_info("ID", $sformatf("id: %0d",c), UVM_LOW)
    c=c.next();
    end

  endfunction:display

endclass:my_object

my_object mb;
module tb();

  initial begin
    mb = new();
   // run_test("test");
    mb.display();
  end

endmodule
