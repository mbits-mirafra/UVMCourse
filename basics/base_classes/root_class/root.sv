`include "uvm_macros.svh"
import uvm_pkg::*;


class my_comp extends uvm_component;

  bit [3:0]a;

  function  new(string name="my_comp", uvm_component parent);

    super.new(name, null);
    `uvm_info("NEW", "creating my_comp", UVM_LOW)

  endfunction

  function void display();

    for(int i = 0;i<3;i++)
    begin
      `uvm_info("Randamaizing", $sformatf("a: %0d", a), UVM_LOW)
      `uvm_info("STAT", $sformatf("Randamaize successful"), UVM_LOW)   
      a = $urandom();
    end

  endfunction:display

endclass:my_comp
/*
class test extends uvm_test;
  function new(string name = "test",uvm_component parent);
    super.new(name,parent);
  endfunction

    my_comp cp = new("cp",null);
  function disp();
    uvm_top.cp.display();
  endfunction
endclass
*/
module tb();

  my_comp cp;

  initial begin
   // uvm_top = cp;
   
  cp= new("cp",null);
    cp.display();
  end

endmodule
