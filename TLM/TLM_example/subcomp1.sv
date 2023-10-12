class subcomp1 extends uvm_component;
  `uvm_component_utils(subcomp1)

  uvm_blocking_put_port#(packet) m_put_port;
  int m_tx;

  function new(string name="subcomp1",uvm_component parent=null);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_put_port=new("m_put_port",this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    
    repeat(m_tx) begin
      packet pkt=packet::type_id::create("pkt");
      void'(pkt.randomize());
      #50;
      `uvm_info("subcomp1","Packet sent to ComponentA of TLM FIFO",UVM_LOW);
      pkt.print(uvm_default_line_printer);
      m_put_port.put(pkt);
      `uvm_info("subcomp1","done",UVM_LOW); 
    end
  
  endtask
endclass
