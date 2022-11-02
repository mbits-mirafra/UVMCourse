`include "uvm_macros.svh"
package pkg;
import uvm_pkg::*;
class extended_component extends uvm_component;

function new (string name, uvm_component parent);
  super.new(name, parent);
endfunction

virtual task training_phase(uvm_phase phase);
endtask

endclass
//typedef class test;
class uvm_user_phase extends uvm_topdown_phase;
  function new (string n="post_run");
    super.new(n);
  endfunction
  static const string phase_name="uvm_user_phase";

  virtual function string get_type_name();
  return phase_name;
 endfunction
virtual function exec_func(uvm_component c,uvm_phase u);
test t;
if($cast(t,c))
  t.post_run_phase(phase);
endtask

static uvm_user_phase p_inst;
 static function uvm_user_phase get();
 if(p_inst==null)
  p_inst=new;
  return p_inst;
 endfunction
endclass

class test extends uvm_test;
  `uvm_component_utils(test)
  virtual function void add_phase();
  uvm_domain ud=uvm_domain::get_common_domain();
  //uvm_domain ud=uvm_domain::get_uvm_domain();//to insert bw run_phase
  uvm_phase a_p=ud.find(uvm_build_phase::get());//inserted after build phase
  ud.add(uvm_user_phase::get(),null,a_p,null);
  endfunction

 function new(string n="test",uvm_component p=null);
  super.new(n,p);
 endfunction
 virtual task user_phase(uvm_phase phase);
  `uvm_info("group",$sformatf("in %s phase",phase.get_name()),UVM_MEDIUM);
 endtask
endclass

module one;
//a_phase a;
initial begin
  //a=new();
  //$display(a.get_type_name());
  run_test("test");

end endmodule                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
