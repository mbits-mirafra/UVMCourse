class sequencer extends uvm_sequencer#(transaction);
  `uvm_component_utils(sequencer)

  function new(input string inst= "SEQUENCER", uvm_component c);
    super.new(inst,c);
  endfunction

endclass
