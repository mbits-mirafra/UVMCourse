`include "uvm_macros.svh"
import uvm_pkg::*;

class component1 extends uvm_component;
  `uvm_component_utils(component1)

  int data = 12;

  uvm_nonblocking_put_port #(int) port;

  function new(input string path = "component1", uvm_component parent = null);
    super.new(path, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  port  = new("port", this);
endfunction

task main_phase(uvm_phase phase);

  phase.raise_objection(this);
  repeat(2)begin
     int trans;
     trans = port.try_put(data);
    `uvm_info("PROD" , $sformatf("Data Sent : %0d", data), UVM_NONE);
    if(trans)
      `uvm_info("non blocking",$sformatf("transaction completed"), UVM_MEDIUM)
      else 
        `uvm_info("non blocking",$sformatf("transaction failed"), UVM_MEDIUM)
      end
      phase.drop_objection(this);
     endtask

   endclass
   ////////////////////////////////////////////////

   class component2 extends uvm_component;
     `uvm_component_utils(component2)


     //  uvm_nonblocking_put_export #(int) recv;
     uvm_nonblocking_put_imp #(int, component2) imp;
     function new(input string path = "component2", uvm_component parent = null);
       super.new(path, parent);
     endfunction

     virtual function void build_phase(uvm_phase phase);
     super.build_phase(phase); 
     //recv  = new("recv", this);
     imp = new("imp", this);
   endfunction

   virtual function try_put(int datar);
   `uvm_info("CONS" , $sformatf("Data Rcvd : %0d", datar), UVM_NONE);
   return 1;
 endfunction

 virtual function bit can_put();
 `uvm_info(get_type_name(),$sformatf(" Inside can_put method"),UVM_LOW)
 `uvm_info(get_type_name(),$sformatf(" Sending can_put status as 1"),UVM_LOW)
 return 0 ; 

 endfunction 

endclass

//////////////////////////////////////////////////////////////////////////////////

class env extends uvm_env;
  `uvm_component_utils(env)

  component1 c1;
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

c1.port.connect(c2.imp);
//c.recv.connect(c.imp);
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

virtual function void end_of_elaboration_phase(uvm_phase phase);
super.end_of_elaboration_phase(phase);
uvm_top.print_topology();
 endfunction

endclass

//////////////////////////////////////////////
module tb;


initial begin
  run_test("test");
end


endmodule


