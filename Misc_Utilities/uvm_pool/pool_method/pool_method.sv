`include "uvm_macros.svh"
import uvm_pkg::*;

class pool extends uvm_test;
`uvm_component_utils(pool);

//uvm_pool declaration
uvm_pool #(string, int) pool_name; 
string team;
int T;

//Default constructor
function new(string name="pool",uvm_component parent=null);
super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
pool_name = new("id");
endfunction

virtual task run_phase(uvm_phase phase);

// add method
pool_name.add("BJT",1);
pool_name.add("kachori", 2);
pool_name.add("silicon_crew", 3);

$display("BJT:1 , kachori:2 , silicon_crew:3");

//Exists
`uvm_info("test", $sformatf("team kachori is present = %0d",pool_name.exists("kachori")), UVM_LOW);
`uvm_info("test", $sformatf("team five is not present = %0d",pool_name.exists("five")), UVM_LOW);


//num method
`uvm_info("test", $sformatf("Number of teams = %0d",pool_name.num()), UVM_LOW);

//get method
`uvm_info("test", $sformatf("ID for silicon_crew = %0d",pool_name.get("silicon_crew")), UVM_LOW);


// prev method
team= "silicon_crew";
assert(pool_name.prev(team));
`uvm_info("test", $sformatf("previous team of silicon_crew = %s", team), UVM_LOW);

//next method
team= "kachori";
assert(pool_name.next(team));
`uvm_info("test", $sformatf("next team after kachori  = %s", team), UVM_LOW);

// first method
assert(pool_name.first(team));
`uvm_info("test", $sformatf("first team = %s", team), UVM_LOW);

//last method
assert(pool_name.last(team));
`uvm_info("test", $sformatf("last team = %s", team), UVM_LOW);                                                                                                         
//get 
`uvm_info("test", $sformatf("get: pool_name[\"kachori\"] = %0d", pool_name.get("kachori")), UVM_LOW);                            

//num
`uvm_info("test", $sformatf("Number of entries in pool_name = %0d", pool_name.num()), UVM_LOW);

// delete
pool_name.delete("kachori");
`uvm_info("test", $sformatf("After delete method: Number of entries in pool_name = %0d", pool_name.num()), UVM_LOW);
endtask
endclass


module top;
initial begin
run_test("pool");
end
endmodule
