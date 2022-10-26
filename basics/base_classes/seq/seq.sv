`include "uvm_macros.svh"
import uvm_pkg::*;

class my_seq_item extends uvm_sequence_item;

  rand bit [3:0] a;
  constraint c {a>9;}

  function new(string name = "my_seq_item");

    super.new(name);

  endfunction
 
  function void display();

    `uvm_info("Randomize", $sformatf("a = %0d",a),UVM_LOW)

  endfunction

endclass

module tb;

  my_seq_item s;
  
  initial begin

    s=new();
    repeat(3) begin

      void'(s.randomize());
      s.display();

    end
  end
endmodule
