`include "uvm_macros.svh"
import uvm_pkg::*;

class transaction extends uvm_sequence_item;
  rand bit[2:0]a;
  rand bit[2:0]b;

  `uvm_object_utils_begin(transaction)
      `uvm_field_int(a,UVM_DEFAULT+UVM_DEC)
      `uvm_field_int(b,UVM_DEFAULT+UVM_DEC)
  `uvm_object_utils_end


  function new (string name = "transaction");
    super.new(name);
  endfunction

endclass 

class componentB extends uvm_component;

   `uvm_component_utils(componentB)

   transaction trans;
   uvm_analysis_port #(transaction) ap;

   function new (string name = "componentB" , uvm_component parent);
     super.new (name,parent);
     ap = new("WRITE",this);
   endfunction
    
   virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        trans = transaction::type_id::create("trans",this);
    endfunction

  virtual task run_phase(uvm_phase phase);
       repeat(3) begin
         `uvm_info(get_type_name(),"sending Data to subscribers.......",UVM_NONE)
         void'(trans.randomize());
         ap.write(trans);
         trans.print();
       end
     endtask 
   endclass


   class sub1 extends uvm_component;
     transaction trans;

     `uvm_component_utils(sub1)
       uvm_analysis_imp #(transaction , sub1) aimp;

   function new (string name = "sub1" , uvm_component parent);
     super.new (name,parent);
     aimp = new("READ",this);
   endfunction

   virtual function void write (input transaction t);
    t.print();
    `uvm_info(get_type_name(),"Data Received to sub1!!",UVM_NONE)
  endfunction
endclass

   class sub2 extends uvm_component;
     transaction trans;
     `uvm_component_utils(sub2)
     uvm_analysis_imp #(transaction , sub2) aimp;
       
   function new (string name = "sub2" , uvm_component parent);
     super.new (name,parent);
     aimp = new("READ",this);
   endfunction

   virtual function void write (input transaction t);
    t.print();
    `uvm_info(get_type_name(),"Data Received to sub2!!",UVM_NONE)
  endfunction
endclass


   class sub3 extends uvm_component;
     transaction trans;
     `uvm_component_utils(sub3)
     uvm_analysis_imp #(transaction , sub3) aimp;
       
   function new (string name = "sub2" , uvm_component parent);
     super.new (name,parent);
     aimp = new("READ",this);
   endfunction

   virtual function void write (input transaction t);
    t.print();
    `uvm_info(get_type_name(),"Data Received to sub3!!",UVM_NONE)
  endfunction
endclass
   
class my_env extends uvm_env;
      componentB  comB;
      sub1 s1;
      sub2 s2;
      sub3 s3;
      `uvm_component_utils(my_env)
      

   function new (string name = "my_env" , uvm_component parent);
     super.new (name,parent);
        endfunction

        virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        comB = componentB::type_id::create("comB",this);
        s1 = sub1::type_id::create("s1",this);
        s2 = sub2::type_id::create("s2",this);
        s3 = sub3::type_id::create("s3",this);
      endfunction

      virtual function void connect_phase (uvm_phase phase);
      super.connect_phase(phase);
      comB.ap.connect(s1.aimp);
      comB.ap.connect(s2.aimp);
      comB.ap.connect(s3.aimp);
    endfunction
  endclass

  class test extends uvm_test;
    my_env env;
    `uvm_component_utils(test)
   
    function new (string name = "test" , uvm_component parent);
     super.new (name,parent);
        endfunction

        virtual function void build_phase(uvm_phase phase);
          super.build_phase(phase);
        env = my_env::type_id::create("env",this);
      endfunction

      virtual function void end_of_elaboration_phase(uvm_phase phase);
      super.end_of_elaboration_phase(phase);
      `uvm_info(get_type_name(),"end_of_elaboration_phase",UVM_NONE)
      //uvm_top.print();
       uvm_top.print_topology();
    endfunction
  endclass 


  module tb;
  initial begin
    run_test("test");
  end
  endmodule
