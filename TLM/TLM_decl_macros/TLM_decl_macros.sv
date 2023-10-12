`include "uvm_macros.svh"
import uvm_pkg::*;

//Packet

class packet extends uvm_sequence_item;
rand bit[3:0]a;
rand bit[3:0]b;
    bit c;

//Factory Registration

`uvm_object_utils_begin(packet)

//Field Registration

  `uvm_field_int(a,UVM_ALL_ON);
  `uvm_field_int(b,UVM_ALL_ON);
  `uvm_field_int(c,UVM_DEFAULT);
  `uvm_object_utils_end

function new(input string name="packet");
  super.new(name);
endfunction

endclass

//Producer A

class prodA extends uvm_component;
`uvm_component_utils(prodA)

uvm_blocking_put_port #(packet) send;
packet pkt;

function new(string name = "prodA", uvm_component parent = null);
super.new(name, parent);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
send=new("send",this);
endfunction

virtual task run_phase(uvm_phase phase);
phase.raise_objection(this);
repeat(2) begin

  pkt=packet::type_id::create("pkt");
  assert(pkt.randomize());
  `uvm_info("prodA", "packet sent to consumer", UVM_LOW)
  pkt.print();
  send.put(pkt);
end
phase.drop_objection(this);
endtask
endclass

//Producer B

class prodB extends uvm_component;
`uvm_component_utils(prodB)

uvm_blocking_put_port #(packet) send;
packet pkt;

function new(string name = "prodB", uvm_component parent = null);
super.new(name, parent);
endfunction

virtual function void build_phase(uvm_phase phase);
 super.build_phase(phase);
send=new("send",this);
endfunction

virtual task run_phase(uvm_phase phase);
phase.raise_objection(this);
repeat(2) begin
  pkt=packet::type_id::create("pkt");
#1;
  assert(pkt.randomize());
  `uvm_info("prodB", "packet sent to consumer", UVM_LOW)
  pkt.print();
  send.put(pkt);
end
phase.drop_objection(this);
endtask
endclass

`uvm_blocking_put_imp_decl (_1)  //should be  outside the class
`uvm_blocking_put_imp_decl (_2)

//Consumer

class consumer extends uvm_component;
`uvm_component_utils(consumer)
    
uvm_blocking_put_imp_1 #(packet, consumer) put_imp1;
uvm_blocking_put_imp_2 #(packet, consumer) put_imp2;

function new(string name = "consumer", uvm_component parent = null);
  super.new(name, parent);
endfunction 

virtual function void build_phase(uvm_phase phase);
 super.build_phase(phase);
put_imp1=new("put_imp1", this);
put_imp2=new("put_imp2", this);
endfunction

function void put_1(packet pkt);
`uvm_info("CONS" , "packet received from put_1", UVM_LOW)
pkt.print();
endfunction

function void put_2(packet pkt);
`uvm_info("CONS" , "packet received from put_2", UVM_LOW)
pkt.print();
endfunction
endclass

//Environment

class environment extends uvm_env;
`uvm_component_utils(environment)

prodA pA;
prodB pB;
consumer c;

function new(string name = "environment", uvm_component parent = null);
 super.new(name, parent);
endfunction

virtual function void build_phase(uvm_phase phase);
 super.build_phase(phase);
pA = prodA::type_id::create("pA",this);
pB = prodB::type_id::create("pB",this);
c = consumer::type_id::create("c", this);
endfunction

virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
pA.send.connect(c.put_imp1);
pB.send.connect(c.put_imp2);
endfunction
endclass

//Test

class test extends uvm_test;
  `uvm_component_utils(test)

environment e;

function new(string name = "test", uvm_component parent = null);
 super.new(name, parent);
endfunction

virtual function void build_phase(uvm_phase phase);
 super.build_phase(phase);
e = environment::type_id::create("e",this);
endfunction
endclass


module tb;
initial begin
  run_test("test");
end
endmodule 


