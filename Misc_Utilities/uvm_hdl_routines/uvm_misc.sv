//-------------------------------------------------------
// module 1-bit full adder
//-------------------------------------------------------
module fulladder(a,b,c,sum,carry);
//-------------------------------------------------------
// Declaration of input and output signals 
// of 1-bit full adder
//-------------------------------------------------------
  input a;
  input b;
  input c;
  output sum;
  output carry;

//continuous assignment statement
  assign sum = a^b^c;
  assign carry = (a&b) | (b&c) | (c&a);
endmodule:fulladder

//-------------------------------------------------------
//module 4-bit Ripple carry adder using the 1-bit Fulladder 
//-------------------------------------------------------
module bit4adder(input [3:0]A,
//-------------------------------------------------------
//Decalration of input and output signals
//of 4-bit Ripple carry adder
//-------------------------------------------------------
  input [3:0]B,
  input C0,
  output [3:0]S,
  output C4);

 //To connect between two 1-bit full adder  
  wire C1,C2,C3;
  
  fulladder fa0(.a(A[0]),.b(B[0]),.c(C0),.sum(S[0]),.carry(C1));
  fulladder fa1(.a(A[1]),.b(B[1]),.c(C1),.sum(S[1]),.carry(C2));
  fulladder fa2(.a(A[2]),.b(B[2]),.c(C2),.sum(S[2]),.carry(C3));
  fulladder fa3(.a(A[3]),.b(B[3]),.c(C3),.sum(S[3]),.carry(C4));

endmodule:bit4adder 

//Access for class uvm package
import uvm_pkg::*;
//Acess for uvm_macros
`include "uvm_macros.svh"

//-------------------------------------------------------
// Interface module
//-------------------------------------------------------
interface inter();
    logic [3:0]A;
    logic [3:0]B;
    logic C0;
    logic [3:0]S;
    logic C4;

endinterface
module top();
//class test
class test extends uvm_test;
    
  `uvm_component_utils(test)
  logic [3:0]val;

  function new(string name="test",uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
      
    phase.raise_objection(this);

    //Check specified HDL path exist
      if(uvm_hdl_check_path("top.Ripple.A")) begin
      `uvm_info("checking",$sformatf(" 1.check the path exist top.Ripple.intf.A = %0d",top.Ripple.A),UVM_LOW)
      end  
      else begin
      `uvm_info("checking",$sformatf(" 1.The path does not exist top.Ripple.A = %0d",top.Ripple.A),UVM_LOW)
      end
      $display("");
      #15;


      `uvm_info("checking",$sformatf(" Before Depositing a specified value top.Ripple.B = %0d",top.Ripple.B),UVM_LOW)
      //set the given HDL path to a specified value 
      if(uvm_hdl_deposit("top.Ripple.B",2)) begin
      `uvm_info("checking",$sformatf(" After Deposit of specified value top.Ripple.B = %0d",top.Ripple.B),UVM_LOW)
      end  else begin
      `uvm_info("checking",$sformatf(" Value is not Deposited to the Specified path top.Ripple.B = %0d",top.Ripple.B),UVM_LOW)
      end
      $display("");
      #15;  //30ns 
      
      //get the value in the given path
      uvm_hdl_read("top.Ripple.B",val);
      `uvm_info("checking",$sformatf(" Reading the value in the specified path top.Ripple.B = %0d",val),UVM_LOW)
      $display("");
      #15;  //45ns

      //force the value to the specified path
      if(uvm_hdl_force("top.Ripple.B",7)) begin
      `uvm_info("checking",$sformatf(" Forced value of the specified path top.Ripple.B= %0d",top.Ripple.B),UVM_LOW)
      end 
      else begin
      `uvm_info("checking",$sformatf("value is not forced to the specified path top.Ripple.B= %0d",top.Ripple.B),UVM_LOW)
      end
      $display("");
      #15;  //60ns

      //Release the value previous set by uvm_hdl_force
      if(uvm_hdl_release("top.Ripple.B"))begin
      `uvm_info("checking",$sformatf("After release the previous forced value it is able to take other values top.Ripple.B = %0d",top.Ripple.B),UVM_LOW)
      end 
      else begin
      `uvm_info("checking",$sformatf("forced value not released top.Ripple.B = %0d",top.Ripple.B),UVM_LOW)
      end
      $display("");
      #5;  //65ns

      //Read the value from specified HDL path
      uvm_hdl_read("top.Ripple.A",val);
      `uvm_info("checking",$sformatf(" Reading the value in the specified path top.Ripple.A = %0d",val),UVM_LOW)
      $display("");
      
      #75 $finish; 
      
      phase.drop_objection(this);  

  endtask 

endclass

//-------------------------------------------------------
// Top Module
//-------------------------------------------------------


//run the test
  initial run_test("test");

//instantiation of interface
  inter intf();

//instatiation of 4bit Ripple carry adder
  bit4adder Ripple(.A(intf.A), .B(intf.B), .C0(intf.C0), .S(intf.S), .C4(intf.C4));

  initial begin
    intf.A = 6;
    intf.B = 5;
    intf.C0 = 1;

    #15 
    intf.A=9;
    intf.C0=1;
    

    #15  //30ns
    intf.A = 1;
    intf.B = 3;

    #15; //45ns
    intf.A =4;

    #10; //55ns
    intf.B=5;
    intf.A=2;

    #10; //65ns
    intf.B =3;
    intf.A=1;
    
    #1; //66ns 
    `uvm_info("checking","Ending Simualtion now........",UVM_LOW)
 end
    
endmodule:top



