class transaction extends uvm_sequence_item;
  rand bit [3:0] a;
  rand bit [3:0] b;

  function new(input string inst = "transaction");
    super.new(inst);
  endfunction

  `uvm_object_utils_begin(transaction)
  `uvm_field_int(a,UVM_DEFAULT)
  `uvm_field_int(b,UVM_DEFAULT)
  `uvm_object_utils_end

endclass
