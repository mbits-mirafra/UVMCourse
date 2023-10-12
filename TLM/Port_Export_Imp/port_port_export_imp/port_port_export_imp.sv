`include "uvm_macros.svh"
import uvm_pkg::*;
 
class sub_component1 extends uvm_component;
  int a=5;
     `uvm_component_utils(sub_component1)
     uvm_blocking_put_port#(int) sub_port;

     function new(string name="sub_component1",uvm_component parent=null);
       super.new(name,parent);
     endfunction
    
     virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        sub_port= new("sub_port",this);
     endfunction 

     task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        `uvm_info("s_c1",$sformatf("a: %0d",a),UVM_MEDIUM); 
        sub_port.put(a);
        phase.drop_objection(this);
     endtask

endclass

class component1 extends uvm_component;
     
  `uvm_component_utils(component1)
     uvm_blocking_put_port#(int) port;
     sub_component1 s_c1;

     function new(string name="component1",uvm_component parent=null);
       super.new(name,parent);
     endfunction
    
     virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        s_c1=sub_component1::type_id::create("s_c1",this);
        port= new("port",this);
     endfunction 

     virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        s_c1.sub_port.connect(this.port);
     endfunction

endclass

class sub_component2 extends uvm_component;
  `uvm_component_utils(sub_component2)
  uvm_blocking_put_imp#(int,sub_component2) imp;


  function new(string name="sub_component2",uvm_component parent=null);
    super.new(name,parent);
  endfunction
   
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    imp=new("imp",this);
  endfunction 
  
  virtual task put(int b);
    #15 `uvm_info("s_c2",$sformatf("b: %0d",b),UVM_MEDIUM); 
  endtask
endclass

class component2 extends uvm_component;
    `uvm_component_utils(component2)
    uvm_blocking_put_export#(int) ex_port;
    sub_component2 s_c2;
    function new(string name="component2",uvm_component parent=null);
      super.new(name,parent);
    endfunction
     
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ex_port=new("ex_port",this);
    s_c2=sub_component2::type_id::create("s_c2",this);
  endfunction 
  
  virtual function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  ex_port.connect(s_c2.imp);
  endfunction

endclass

class environment extends uvm_env;

  `uvm_component_utils(environment)
  component1 c1;
  component2 c2;
  function new(input string name="environment",uvm_component parent = null);
    super.new(name,parent);
  endfunction

  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    c1=component1::type_id::create("c1",this);
    c2=component2::type_id::create("c2",this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    c1.port.connect(c2.ex_port);
  endfunction
endclass
    

class test extends uvm_test;
     `uvm_component_utils(test)

     environment env;

     function new(string name="environment",uvm_component parent=null);
       super.new(name,parent);
     endfunction
      
     
     virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env=environment::type_id::create("env",this);
     endfunction 


virtual function void end_of_elaboration_phase (uvm_phase phase);
super.end_of_elaboration_phase(phase);
uvm_top.print_topology();
endfunction

endclass

module tb;
   initial begin
       run_test("test");  
   end
endmodule
