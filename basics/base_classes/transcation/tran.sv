`include "uvm_macros.svh"
import uvm_pkg::*;

class my_tran extends uvm_transaction;

  randc bit [3:0] a;
  constraint c {a>9;}

  function new(string name = "my_seq_item");

    super.new(name);

  endfunction
 
  task display();

   #1 `uvm_info("Randomize", $sformatf("[%0t]a = %0d",$time,a),UVM_LOW)

 endtask

endclass

module tb;

  my_tran t;
  
  initial begin

    t=new();
    repeat(3) begin

      void'(t.randomize());
      t.display();

    end
  end
endmodule
