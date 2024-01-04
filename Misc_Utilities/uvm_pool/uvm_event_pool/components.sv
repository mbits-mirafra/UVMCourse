
class compA extends uvm_component;
  `uvm_component_utils(compA)
  uvm_event e1;

  function new(string name = "compA", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    e1 = uvm_event_pool::get_global("myevent");

    `uvm_info(get_type_name(),$sformatf("%0t: Before triggering the event", $time),UVM_LOW)
    #5;
    e1.trigger();
    `uvm_info(get_type_name(),$sformatf("%0t: After triggering the event", $time),UVM_LOW)
  endtask
endclass

class compB extends uvm_component;
  `uvm_component_utils(compB)
  uvm_event e1;

  function new(string name = "compB", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    e1 = uvm_event_pool::get_global("myevent");

    `uvm_info(get_type_name(),$sformatf("%0t: waiting for the event", $time),UVM_LOW)
    e1.wait_trigger();
    `uvm_info(get_type_name(),$sformatf("%0t: event is triggered", $time),UVM_LOW)
  endtask
endclass

class compC extends uvm_component;
  `uvm_component_utils(compC)
  uvm_event e2;

  function new(string name = "compC", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    e2 = uvm_event_pool::get_global("myevent");

    `uvm_info(get_type_name(),$sformatf("%0t: waiting for the event", $time),UVM_LOW)
    e2.wait_trigger();
    `uvm_info(get_type_name(),$sformatf("%0t: event is triggered", $time),UVM_LOW)
  endtask
endclass

