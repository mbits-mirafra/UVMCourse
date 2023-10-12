class sequencer extends uvm_sequencer#(transaction);
  `uvm_component_utils(sequencer)

  function new(input string inst= "SEQUENCER", uvm_component c);
    super.new(inst,c);
  endfunction

 virtual function integer user_priority_arbitration(integer avail_sequences[$]);
    int end_index;
    end_index=avail_sequences.size()-1;
    return(avail_sequences[end_index]);
  endfunction

endclass
