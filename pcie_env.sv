class pcie_env extends uvm_env;
  pcie_sequencer sequencer;
  pcie_driver driver;
  pcie_monitor monitor;
  pcie_scoreboard scoreboard;
  `uvm_component_utils(pcie_env)

  function new(string name = "pcie_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sequencer = pcie_sequencer::type_id::create("sequencer", this);
    driver    = pcie_driver::type_id::create("driver", this);
    monitor   = pcie_monitor::type_id::create("monitor", this);
    scoreboard = pcie_scoreboard::type_id::create("scoreboard", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    driver.seq_item_port.connect(sequencer.seq_item_export);
    monitor.analysis_port.connect(scoreboard.analysis_export);
  endfunction
endclass
