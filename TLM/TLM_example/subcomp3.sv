class subcomp3 extends uvm_component;
  `uvm_component_utils(subcomp3)

  function new(string name="subcomp3",uvm_component parent);
    super.new(name,parent);
  endfunction

  uvm_blocking_get_port#(packet) m_get_port;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_get_port = new("m_get_port",this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    packet pkt;
    forever begin
      #200;
      m_get_port.get(pkt);
      `uvm_info("SUBCOMP3","packet recieved from component B of tlm fifo",UVM_MEDIUM); 
      pkt.print(uvm_default_line_printer);
      `uvm_info("SUBCOMP3","subcomp3 is done",UVM_MEDIUM); 
    end
  endtask

endclass
