 
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
  `uvm_info(get_full_name(),$sformatf("in %s phase",phase.get_name()),UVM_MEDIUM);
  endfunction
endclass

class test extends uvm_test;
  `uvm_component_utils(test)
  //extended_comp ec;
  //uvm_phase schedule,s1;
  //uvm_domain udomain;
  function new(string n="test",uvm_component p=null);
    super.new(n,p);
    add_my_phase();
  endfunction
  
  virtual function void add_my_phase();
  //uvm_domain d=uvm_domain::get_common_domain();
  //uvm_phase up=d.find(uvm_build_phase::get());
  uvm_domain::get_common_domain().add(u_phase::get(),uvm_build_phase::get(),null,null);
  //uvm_domain::get_common_domain().add(u_phase::get(),null,uvm_connect_phase::get(),uvm_run_phase::get());
  //uvm_phase::get_phase_type()::get_domain().add(u_phase::get(),null,uvm_build_phase::get(),null);
  endfunction

  
  virtual task run_phase(uvm_phase phase); 
  `uvm_info(get_type_name(),$sformatf("in %s phase",phase.get_name()),UVM_MEDIUM);
   endtask

  virtual function void build_phase(uvm_phase phase);
  //`uvm_info(get_type_name(),$sformatf("in %s phase",phase.get_name()),UVM_LOW);
  //ec =extended_comp::type_id::create("ec",this);
  ////udomain=uvm_domain::get_common_domain();
  //udomain=uvm_domain::get_uvm_domain();
  //schedule = udomain.find(uvm_build_phase::get());
  //s1 = udomain.find(uvm_connect_phase::get());
  //schedule.add(u_phase::get(), .after_phase(uvm_build_phase::get()), .before_phase(uvm_connect_phase::get()));
  ////udomain.add(u_phase::get(),null,uvm_build_phase::get(),null);//,uvm_connect_phase::get());
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


