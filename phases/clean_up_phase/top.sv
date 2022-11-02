`include "uvm_macros.svh"
import uvm_pkg::*;
`include "seq_item.sv"
`include "seq.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "agent.sv"
`include "test.sv"

module top;

  initial begin
    run_test("test");
  end

endmodule
