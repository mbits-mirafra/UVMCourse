class transaction extends uvm_object;
  rand bit[15:0] addr;
  rand bit[15:0] data;
  `uvm_object_utils_begin(transaction)
  `uvm_field_int(addr, UVM_PRINT);
  `uvm_field_int(data, UVM_PRINT);
  `uvm_object_utils_end

  function new(string name = "transaction");
    super.new(name);
  endfunction
endclass
