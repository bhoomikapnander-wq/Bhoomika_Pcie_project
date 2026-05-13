class pcie_seq_item extends uvm_sequence_item;
  rand bit [511:0] lp_data;
  rand bit [63:0] lp_valid;
  rand bit [63:0] lp_dlpstart;
  rand bit [63:0] lp_dlpend;
  rand bit [63:0] lp_tlpstart;
  rand bit [63:0] lp_tlpend;
  rand bit [3:0] lp_state_req;
  rand bit lp_force_detect;

  `uvm_object_utils(pcie_seq_item)

  function new(string name = "pcie_seq_item");
    super.new(name);
  endfunction
endclass
