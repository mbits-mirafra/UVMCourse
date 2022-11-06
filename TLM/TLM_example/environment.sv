class env extends uvm_env;
  `uvm_component_utils(env)

  function new(string name = "env",uvm_component parent = null);
    super.new(name,parent);
  endfunction 
  
  componentA compA;
  componentB compB; 
  int m_tx;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    compA = componentA::type_id::create("compA",this);
    compB = componentB::type_id::create("compB",this);
    std::randomize(m_tx) with {m_tx inside {3};};
    `uvm_info("ENV",$sformatf("created %0d packets in total",m_tx),UVM_LOW); 
    compA.m_tx = m_tx;
    compB.m_tx = m_tx;
  endfunction

  virtual function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);  
compB.m_get_port.connect(compA.m_get_export);
// compB.m_get_export.connect(compA.m_get_port);
endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    #5000;
    phase.drop_objection(this);
  endtask

endclass
