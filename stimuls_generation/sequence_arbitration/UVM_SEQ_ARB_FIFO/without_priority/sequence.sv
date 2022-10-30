class sequence1 extends uvm_sequence#(transaction);

  `uvm_object_utils(sequence1)

  transaction trans;

  function new(input string inst = "seq1");
    super.new(inst);
  endfunction

  virtual task body();
     trans = transaction::type_id::create("trans");
    `uvm_info(get_name(), "SEQUENCE Started" , UVM_NONE); 
     start_item(trans);
     void'(trans.randomize());
     finish_item(trans);
     `uvm_info(get_name(), "SEQUENCE Ended" , UVM_NONE); 
  endtask

endclass
