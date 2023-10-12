`include "uvm_macros.svh"
import uvm_pkg::*;

class component1 extends uvm_component;
  `uvm_component_utils(component1)

  int data = 20;

  uvm_blocking_put_port #(int) port;

  function new(input string path = "Component A", uvm_component parent = null);
    super.new(path, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    port  = new("port", this);
  endfunction

  task main_phase(uvm_phase phase);

    phase.raise_objection(this);
    port.put(data);
    `uvm_info("PROD" , $sformatf("Data Sent : %0d", data), UVM_NONE);
    phase.drop_objection(this);

  endtask

endclass
////////////////////////////////////////////////

class component2 extends uvm_component;
  `uvm_component_utils(component2)


  uvm_blocking_put_export #(int) expo;
  uvm_blocking_put_imp #(int, component2) imp;
  function new(input string path = "Component B", uvm_component parent = null);
    super.new(path, parent);

  endfunction

 virtual function void  build_phase(uvm_phase phase);
 super.build_phase(phase);
    expo  = new("expo", this);
    imp = new("imp", this);
  endfunction
    
    task put(int datar);
    `uvm_info("CONS" , $sformatf("Data Rcvd : %0d", datar), UVM_NONE);
  endtask

endclass

//////////////////////////////////////////////////////////////////////////////////

class env extends uvm_env;
  `uvm_component_utils(env)

  component1 c1;;
  component2 c2;


  function new(input string path = "env", uvm_component parent = null);
    super.new(path, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  c1 = component1::type_id::create("c1",this);
  c2 = component2::type_id::create("c2", this);
endfunction

  virtual function void connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   c1.port.connect(c2.expo); 
   c2.expo.connect(c2.imp);
  endfunction

endclass

///////////////////////////////////////////////////

class test extends uvm_test;
  `uvm_component_utils(test)

  env e;

  function new(input string path = "test", uvm_component parent = null);
    super.new(path, parent);
  endfunction


  virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  e = env::type_id::create("e",this);
endfunction

endclass

//////////////////////////////////////////////
module tb;

initial begin
  run_test("test");
end

endmodule


