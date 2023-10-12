class packet extends uvm_object;
  rand bit[3:0] a;
  rand bit[2:0] b;

  `uvm_object_utils_begin(packet)
  `uvm_field_int(a,UVM_ALL_ON)
  `uvm_field_int(b,UVM_ALL_ON)
  `uvm_object_utils_end
  
  function new(string name="packet");
    super.new(name);
  endfunction

endclass
