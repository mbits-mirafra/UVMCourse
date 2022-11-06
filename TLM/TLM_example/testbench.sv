`include "uvm_macros.svh"
import uvm_pkg::*;

`include "packet.sv"
`include "subcomp1.sv"
`include "componentA.sv"
`include "subcomp2.sv"
`include "subcomp3.sv"
`include "componentB.sv"
`include "environment.sv"

module tb;
initial begin
  run_test("env");
end
endmodule
