import uvm_pkg::*;
`include "uvm_object_conv2str.sv"
`include "uvm_macros.svh"

class test extends uvm_test;
   `uvm_component_utils(test)

   function new(string name="test", uvm_component parent=null);
      super.new(name,parent);
   endfunction

   function void build;
      example Ex = example::type_id::create("Ex");
      `uvm_info(get_type_name(),$sformatf("Contents:%s",Ex.convert2string()),UVM_LOW)
   endfunction

endclass

module uvm_object_con2str_tb;
   test t;
   initial begin
      t=test::type_id::create("t",null);
      t.build();
   end
endmodule
