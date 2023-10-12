`include "uvm_macros.svh"
import uvm_pkg::*;
///packet

class packet extends uvm_sequence_item;
  rand bit[2:0]a;
  rand bit[3:0]b;
  `uvm_object_utils_begin(packet)
  `uvm_field_int(a,UVM_ALL_ON)
  `uvm_field_int(b,UVM_ALL_ON)
  `uvm_object_utils_end
//as this is an object it do not has phases
//object is dynamic in nature and has body
  function new(input string name="packet");
    super.new(name);
  endfunction
endclass



    class componentA extends uvm_component;
      `uvm_component_utils(componentA)
      packet p;
       uvm_blocking_put_port #(packet) port;

       function new(input string name="componentA",uvm_component parent=null);
         super.new(name,parent);
       endfunction

       virtual function void build_phase(uvm_phase phase);
       super.build_phase(phase);
       port=new("port",this);
       endfunction

       virtual task run_phase(uvm_phase phase);
       phase.raise_objection(this);
       repeat(2) begin
          p=packet::type_id::create("p");
          assert(p.randomize());
          #1 port.put(p);

          p.print ();
          `uvm_info("componentA","packet sent to componentB",UVM_MEDIUM)

        end
        phase.drop_objection(this);
      endtask
    endclass

    class componentB extends uvm_component;
      `uvm_component_utils(componentB)
      packet p;
      uvm_blocking_get_port #(packet) port1;
    
      

      function new(input string name="componentB",uvm_component  parent=null);
        super.new(name,parent);
      endfunction

      virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      port1=new("port1",this);
      endfunction

      virtual task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      repeat(2) begin
      
        #4 port1.get(p);

        p.print();
        `uvm_info("componentB", "received packet from componentA", UVM_MEDIUM)
      end
      phase.drop_objection(this);
    endtask
  endclass

  class my_test extends uvm_test;
    `uvm_component_utils(my_test)
    componentA compA;
    componentB compB;
    
    

    uvm_tlm_fifo #(packet) m_tlm_fifo;

    function new(input string name="my_test",uvm_component parent=null);
    super.new(name,parent);
    endfunction

   virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   compA=componentA::type_id::create("compA",this);
   compB=componentB::type_id::create("compB",this);
   m_tlm_fifo=new("uvm_tlm_fifo",this,2);
   endfunction

   virtual function void connect_phase(uvm_phase phase);
   compA.port.connect(m_tlm_fifo.put_export);
   compB.port1.connect(m_tlm_fifo.get_export);
   endfunction

   virtual task run_phase(uvm_phase phase);
   forever
    begin
//#4;
     if(m_tlm_fifo.is_full())
     begin
    #1   `uvm_info("tlm_fifo","fifo is full",UVM_MEDIUM)
     end
     else
     begin
     #1  `uvm_info("tlm_fifo","fifo is empty",UVM_MEDIUM)
     end
    end
   
   endtask
 endclass


    module tb;
    initial
     begin
      run_test("my_test");
     end
    endmodule
