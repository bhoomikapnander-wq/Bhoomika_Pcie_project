class pcie_scoreboard extends uvm_component;
  uvm_analysis_imp#(pcie_seq_item, pcie_scoreboard) analysis_export;
  `uvm_component_utils(pcie_scoreboard)

  function new(string name = "pcie_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    analysis_export = new("analysis_export", this);
  endfunction

  function void write(pcie_seq_item t);
    `uvm_info("SCORE", $sformatf("Observed DUT output: pl_valid=%h pl_data=%h", t.lp_valid, t.lp_data), UVM_MEDIUM)
  endfunction
endclass
