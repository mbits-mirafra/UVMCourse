class driver extends uvm_driver#(transaction);
  `uvm_component_utils(driver)

  transaction t;


  function new(input string inst = "DRV", uvm_component c);
    super.new(inst,c);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    t = transaction::type_id::create("TRANS");
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(t);
      `uvm_info(get_name, $sformatf("a = %0d, b = %0d",t.a,t.b), UVM_LOW);
      seq_item_port.item_done();
    end    
  endtask

endclass
