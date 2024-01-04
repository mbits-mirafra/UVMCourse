
import uvm_pkg::*;
`include "uvm_macros.svh"
  `include "transaction.sv"
  `include "sequence.sv"
  `include "sequencer.sv"
  `include "driver.sv"
  `include "agent.sv"
  `include "environment.sv"
  `include "test.sv"
  //`include "top.sv"

module top;

initial begin
run_test("test");
end
endmodule
