`include "uvm_macros.svh"
import uvm_pkg::*;

class driver extends uvm_driver#(seq_item);

  `uvm_component_utils(driver)
  seq_item st1;
  int q[$];
  int count_for_randomization;
  int file;
                      
  function new(string name = "driver", uvm_component parent=null);
    super.new(name,parent);
  endfunction:new
                                      
//build phase
//
  virtual function void build_phase(uvm_phase phase);

    super.build_phase(phase);
    req = seq_item::type_id::create("seq_item");

  endfunction:build_phase
                        
//run phase

  virtual task run_phase(uvm_phase phase);

    super.run_phase(phase);
    forever
    begin

      seq_item_port.get_next_item(req);
      `uvm_info(get_type_name(),$sformatf(" value of a:%0d , b:%0d" ,req.a,req.b),UVM_LOW)
      count_for_randomization++;
      req.y = (req.a)+(req.b);
      q.push_back(req.y);
      `uvm_info(get_type_name(),$sformatf(" value of y:%0d" ,req.y),UVM_LOW)
      seq_item_port.item_done();
      end

  endtask:run_phase
                                                                                                                               
//Extract phase
                                                                                                                                                                    
  virtual function void extract_phase (uvm_phase phase);

    super.extract_phase(phase);
    `uvm_info("extract",$sformatf("All values of y in queue q are %0p",q),UVM_LOW)

  endfunction
                                                                                                                                                                            
//check phase

  virtual function void check_phase(uvm_phase phase);

    super.check_phase(phase);
    if(count_for_randomization == req.value)
      `uvm_info("check","All randomized values recieved",UVM_LOW)
    else
      `uvm_info("check","Some randomized values are missing",UVM_LOW)

endfunction:check_phase

//report phase

  virtual function void report_phase(uvm_phase phase);

    super.report_phase(phase);
    file = $fopen("report_for_driver","w");
    $fdisplay(file,"Total no of randomizations happend are %0d",count_for_randomization);
    $fdisplay(file,"All randomized values of a are %0d",req.a);
    $fdisplay(file,"All randomized values of b are %0d",req.b);
    $fdisplay(file,"Outputs of y are %0p",q);
    $fclose(file);

  endfunction:report_phase

// final phase

  virtual function void final_phase(uvm_phase phase);

    super.final_phase(phase);
    `uvm_info("final","final phase is working",UVM_LOW)

  endfunction:final_phase

endclass:driver
