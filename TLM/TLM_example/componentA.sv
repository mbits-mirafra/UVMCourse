class componentA extends uvm_component;
  `uvm_component_utils(componentA)

  function new(string name="componentA",uvm_component parent=null);
    super.new(name,parent);
  endfunction

  subcomp1 m_comp1;
  int m_tx;

  uvm_tlm_fifo#(packet) m_tlm_fifo;
  uvm_blocking_get_export#(packet) m_get_export;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    m_comp1 = subcomp1::type_id::create("m_comp1",this);
    m_tlm_fifo = new("m_tlm_fifo",this,2);
    m_get_export = new("m_get_export",this);
    m_comp1.m_tx = m_tx;

  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    m_comp1.m_put_port.connect(m_tlm_fifo.put_export);
    this.m_get_export.connect(m_tlm_fifo.get_export);
 endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      #40;
      if(m_tlm_fifo.is_full())
            `uvm_info("COMPA","component A: TLM FIFO is full!",UVM_MEDIUM); 
          end
   endtask

 endclass
