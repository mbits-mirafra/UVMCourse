`include "uvm_macros.svh"
//package pkg;
import uvm_pkg::*;


class a_phase extends uvm_topdown_phase;
  
  function new (string n="a_phase");
    super.new(n);
  endfunction
  static const string phase_name="a_phase";

  virtual function string get_type_name();
  return phase_name;
 endfunction

 static a_phase p_inst;
 
 static function a_phase get();
 if(p_inst==null)
  p_inst=new;
  return p_inst;
 endfunction

 virtual function void exec_func(uvm_component comp,uvm_phase phase);
 $display("hi in %s ",get_type_name()); 

 endfunction
endclass

class test extends uvm_test;
  `uvm_component_utils(test)
  virtual function void add_phase();
  uvm_domain ud=uvm_domain::get_common_domain();
  //uvm_domain ud=uvm_domain::get_uvm_domain();//to insert bw run_phase
  uvm_phase ap=ud.find(uvm_build_phase::get());//inserted after build phase
  ud.add(a_phase::get());
 endfunction

 function new(string n="test",uvm_component p=null);
  super.new(n,p);
 endfunction
 virtual function void build_phase(uvm_phase phase);
  add_phase();
  `uvm_info("group",$sformatf("in %s phase",phase.get_name()),UVM_MEDIUM);
 endfunction
endclass

module one;
//a_phase a;
initial begin
  //a=new();
  //$display(a.get_type_name());
  run_test("test");
end endmodule
