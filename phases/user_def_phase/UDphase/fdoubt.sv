
`include "uvm_macros.svh"
import uvm_pkg::*;


class u_phase extends uvm_topdown_phase;
  static local u_phase up;
  function new(string n="u_phase");
    super.new(n);
  endfunction

  virtual function string get_type_name();
  return "user_defined_phase";
  endfunction

  static function u_phase get();
  if (up==null) begin
   up=new();
  end
  return up; 
  endfunction

  virtual function void exec_func(uvm_component comp,uvm_phase phase);
  //display("in the function");
  uvm_sequencer seq;
  $cast(comp,seq);
  `uvm_info(get_type_name(),$sformatf("in %s",phase.get_name()),UVM_MEDIUM);
  endfunction
endclass
class ecomp extends uvm_component;
  `uvm_component_utils(ecomp)
  function new(string n="ecomp",uvm_component p);
    super.new(n,p);
  endfunction
endclass

class test extends uvm_test;
  `uvm_component_utils(test)
  ecomp e;
  function new(string n="test",uvm_component p=null);
    super.new(n,p);
  e=ecomp::type_id::create("e",this);
  uvm_domain::get_common_domain().add(u_phase::get(),null,uvm_build_phase::get(),null);
  endfunction
  
  virtual task run_phase(uvm_phase phase); 
  `uvm_info(get_type_name(),$sformatf("in %s phase",phase.get_name()),UVM_MEDIUM);
   endtask

  virtual function void build_phase(uvm_phase phase);
  //uvm_domain u=uvm_domain::get_common_domain();
  //uvm_phase up=u.find(uvm_build_phase::get());
  //u.add(u_phase::get(),null,up,null);
  //e=ecomp::type_id::create("e",this);
  //uvm_domain::get_common_domain().add(u_phase::get(),null,uvm_build_phase::get(),null);
  `uvm_info(get_type_name(),$sformatf("in %s phase",phase.get_name()),UVM_LOW);
  endfunction
  
 virtual function void connect_phase(uvm_phase phase);
  `uvm_info(get_type_name(),$sformatf("in %s phase",phase.get_name()),UVM_LOW);
  endfunction

endclass

module one;
import uvm_pkg::*;

initial begin
  run_test("test");
end endmodule
