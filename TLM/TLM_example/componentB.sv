class componentB extends uvm_component;
  `uvm_component_utils(componentB)

  function new(string name = "componentB",uvm_component parent = null);
    super.new(name,parent);
  endfunction

  uvm_tlm_fifo#(packet) m_tlm_fifo;
  uvm_blocking_get_port#(packet) m_get_port;
  subcomp2 comp2;
  subcomp3 comp3;
  int m_tx;

  virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  comp2 = subcomp2::type_id::create("comp2",this);
  comp3 = subcomp3::type_id::create("comp3",this);
  m_tlm_fifo = new("m_tlm_fifo",this,2);
  m_get_port = new("m_get_port",this);
  comp2.m_tx = m_tx;
endfunction

virtual function void connect_phase(uvm_phase phase); 
  super.connect_phase(phase);
  comp2.m_get_port.connect(this.m_get_port);
  comp2.m_put_port.connect(m_tlm_fifo.put_export);
  comp3.m_get_port.connect(m_tlm_fifo.get_export);
endfunction

  virtual task run_phase(uvm_phase phase);
  
  forever begin
    #50 if(m_tlm_fifo.is_full())
      `uvm_info("COMPB","COMPONENT B: TLM FIFO is full!",UVM_MEDIUM);
    end
    
  endtask
endclass

