`include "uvm_macros.svh"
import uvm_pkg::*;
`include "transaction.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "agent.sv"
`include "env.sv"
`include "test.sv"

module tb;

initial begin
  run_test("test");
end

endmodule
