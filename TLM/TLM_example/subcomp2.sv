class subcomp2 extends uvm_component;
 `uvm_component_utils(subcomp2)

  function new(string name="subcomp2",uvm_component parent=null);
    super.new("name",parent);
  endfunction

  uvm_blocking_get_port#(packet) m_get_port;
  uvm_blocking_put_port#(packet) m_put_port;
  int m_tx;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_get_port = new("m_get_port",this);
    m_put_port = new("m_put_port",this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    packet pkt;
    repeat(m_tx) begin 
      #100;
      m_get_port.get(pkt);
      `uvm_info("SUBCOMP2","packet recieved from component A",UVM_LOW); 
     pkt.print(uvm_default_line_printer);
      m_put_port.put(pkt);
      `uvm_info("SUBCOMP2","subcomp2 is done",UVM_MEDIUM); 
    end
  endtask

endclass
