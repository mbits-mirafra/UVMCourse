`include "uvm_macros.svh"
import uvm_pkg::*;

class bjt extends uvm_object;

  rand int a;
  rand int b;


  `uvm_object_utils_begin(bjt)
  `uvm_field_int(a, UVM_DEFAULT)
  `uvm_field_int(b, UVM_DEFAULT)
  `uvm_object_utils_end

  function new(string name = "bjt");
    super.new(name);
  endfunction
endclass

class test extends uvm_test;

  `uvm_component_utils(test)

  bjt jhon;

  function new(string name = "bjt_1",uvm_component parent = null);
    super.new(name,parent);
    jhon = new("bjt");
  endfunction

  function void build_phase(uvm_phase phase);

    bjt jhon = bjt::type_id::create("jhon");
    jhon.print();

  endfunction



 task pre_reset_phase(uvm_phase phase);

   `uvm_info(get_full_name(), {" Inside pre_reset__phase ", get_full_name()}, UVM_LOW);

 endtask:pre_reset_phase




 task reset_phase(uvm_phase phase);

   `uvm_info(get_full_name(), {" Inside reset__phase ", get_full_name()}, UVM_LOW);

 endtask:reset_phase


 task  post_reset_phase(uvm_phase phase);

   `uvm_info(get_full_name(), {" Inside post_reset__phase ", get_full_name()}, UVM_LOW);

 endtask: post_reset_phase


 task  pre_configure_phase(uvm_phase phase);

   `uvm_info(get_full_name(), {" Inside pre_configure__phase ", get_full_name()}, UVM_LOW);


 endtask: pre_configure_phase


 task  configure_phase(uvm_phase phase);


   `uvm_info(get_full_name(), {" Inside configure__phase ", get_full_name()}, UVM_LOW);

 endtask: configure_phase


 task  post_configure_phase(uvm_phase phase);

   `uvm_info(get_full_name(), {" Inside Post_configure__phase ", get_full_name()}, UVM_LOW);

 endtask: post_configure_phase

 task  pre_main_phase(uvm_phase phase);

   `uvm_info(get_full_name(), {" Inside Pre_main__phase ", get_full_name()}, UVM_LOW);

 endtask: pre_main_phase


 task main_phase(uvm_phase phase);

   `uvm_info(get_full_name(), {" Inside main__phase ", get_full_name()}, UVM_LOW);

 endtask: main_phase


 task post_main_phase(uvm_phase phase);

   `uvm_info(get_full_name(), {" Inside Post_main__phase ", get_full_name()}, UVM_LOW);

 endtask: post_main_phase



 task  pre_shut_down_phase(uvm_phase phase);

   `uvm_info(get_full_name(), {" Inside Pre_shutdown_phase ", get_full_name()}, UVM_LOW);

 endtask: pre_shut_down_phase


 task  shut_down_phase(uvm_phase phase);

   `uvm_info(get_full_name(), {" Inside shutdown_phase ", get_full_name()}, UVM_LOW);

 endtask: shut_down_phase



 task  Post_shut_down_phase(uvm_phase phase);

   `uvm_info(get_full_name(), {" Inside shutdown_phase ", get_full_name()}, UVM_LOW);

 endtask: Post_shut_down_phase


 endclass

 module black_squad();
  initial begin

  run_test("test");

  end

 endmodule:black_squad
