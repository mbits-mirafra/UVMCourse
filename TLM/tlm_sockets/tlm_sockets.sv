`include "uvm_macros.svh"
import uvm_pkg::*;

class seq_item extends uvm_sequence_item;
  rand bit [31:0] a;
  rand bit [31:0] b;
  rand bit  c;

  `uvm_object_utils_begin(seq_item)
  `uvm_field_int(a, UVM_PRINT+ UVM_DEC)
  `uvm_field_int(b, UVM_PRINT)  
  `uvm_field_int(c, UVM_DEFAULT)
  `uvm_object_utils_end

  function new(string name = "seq_item");
    super.new(name);
  endfunction
endclass


//initiator code
class initiator extends uvm_component;

  `uvm_component_utils(initiator)

  uvm_tlm_time delay;
  seq_item req;

  // Declare a blocking initiator socket
  uvm_tlm_b_initiator_socket #(seq_item) socket_i;


  function new(string name = "initiator", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    //Create an instance of the socket
    socket_i = new("socket_i", this);

    delay = new("delay");

  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    repeat(2) begin
      req = seq_item::type_id::create("req");
      assert(req.randomize());
      `uvm_info(get_name(), $sformatf("Send req =\n%0s", req.sprint() ), UVM_NONE);

      // Use the socket to sent data
      socket_i.b_transport(req,delay);
    end
  endtask

endclass



   // target code
class target extends uvm_component;

  `uvm_component_utils(target)

  // Declare a blocking target socket
  uvm_tlm_b_target_socket #(target, seq_item) socket_t;


  function new(string name = "target", uvm_component parent = null);
    super.new(name, parent);

    //Create an instance of the target socket
    socket_t = new("socket_t", this);
  endfunction

  virtual task b_transport(seq_item req, uvm_tlm_time tlm_delay);
  `uvm_info(get_type_name(), $sformatf("Received payload =\n%s", req.sprint()), UVM_NONE);
endtask
endclass



class env extends uvm_env;
  initiator init;
  target tgt;

  `uvm_component_utils(env)

  function new(string name = "env", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    //Create an object of the both components
    init = initiator::type_id::create("init", this);
    tgt = target::type_id::create("tgt", this);
  endfunction

  //Connect both sockets in the connect_phase
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    init.socket_i.connect(tgt.socket_t);
  endfunction
endclass

class test extends uvm_test;
  env e;
  `uvm_component_utils(test)

  function new(string name = "test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    e = env::type_id::create("e", this);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
   // #50;
    phase.drop_objection(this);
  endtask
endclass

module tb_top;
initial begin
  run_test("test");
end
endmodule
