`include "uvm_macros.svh"
import uvm_pkg::*;

class rpting extends uvm_component;

  `uvm_component_utils(rpting)

  function new(string name,uvm_component parent);
    super.new(name, parent);
  endfunction

  task run();

    uvm_report_info(get_full_name(),
    "This is information 1",UVM_NONE,`__FILE__,`__LINE__);

    uvm_report_info(get_full_name(),
    "This is information 2",UVM_LOW);

    uvm_report_info(get_full_name(),
    "This is information 3",150);

    uvm_report_info(get_full_name(),
    "This is information 4",UVM_MEDIUM);

    uvm_report_warning(get_full_name(),
    "Warning Messgae from rpting",UVM_LOW);

    uvm_report_error(get_full_name(),
    "Error Message from rpting \n\n",UVM_LOW);
  endtask

endclass

module top;

rpting rpt1;
rpting rpt2;
rpting rpt3;

initial begin
  rpt1 = new("rpt1",null);
  rpt2 = new("rpt2",null);
  rpt3 = new("rpt3",null);

  //Do nohing when error message occur
  rpt1.set_report_severity_action(UVM_ERROR,UVM_NO_ACTION);
  // capture the message in named file
  rpt2.set_report_id_action("rpt2",UVM_LOG);
  // terminate when error message occur 
  rpt3.set_report_severity_id_action(UVM_ERROR,"rpt3",UVM_EXIT);
          
  run_test();
end
endmodule
