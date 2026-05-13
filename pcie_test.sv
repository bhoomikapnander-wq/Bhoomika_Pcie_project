class pcie_test extends uvm_test;
  pcie_env env;
  `uvm_component_utils(pcie_test)

  function new(string name = "pcie_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = pcie_env::type_id::create("env", this);
  endfunction

  task run_phase(uvm_phase phase);
    pcie_sequence seq;
    phase.raise_objection(this);
    seq = pcie_sequence::type_id::create("seq");
    seq.start(env.sequencer);
    #1000ns;
    phase.drop_objection(this);
  endtask
endclass
