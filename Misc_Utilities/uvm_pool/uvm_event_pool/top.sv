
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "components.sv"
`include "testbench.sv"

module top;

initial begin
  run_test("base_test");
end
endmodule
