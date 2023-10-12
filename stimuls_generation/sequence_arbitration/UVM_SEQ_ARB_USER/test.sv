class test extends uvm_test;
  `uvm_component_utils(test)

  function new(input string inst = "TEST", uvm_component c);
    super.new(inst,c);
  endfunction

  sequence1 s[5];

  env e;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    foreach(s[i]) begin
      s[i] = sequence1::type_id::create($sformatf("s[%0d]",i));
    end  
    e = env::type_id::create("ENV",this);
  endfunction

  virtual task run_phase(uvm_phase phase);

    phase.raise_objection(this);

    e.a.seq.set_arbitration(SEQ_ARB_USER); 
    fork  

      s[0].start(e.a.seq); 
      s[1].start(e.a.seq);
      s[2].start(e.a.seq);
      s[3].start(e.a.seq);
      s[4].start(e.a.seq);

    join 

    phase.drop_objection(this);
  endtask

endclass
