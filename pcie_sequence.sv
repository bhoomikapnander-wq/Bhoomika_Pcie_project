class pcie_sequence extends uvm_sequence#(pcie_seq_item);
  `uvm_object_utils(pcie_sequence)

  function new(string name = "pcie_sequence");
    super.new(name);
  endfunction

  task body();
    pcie_seq_item req;
    req = pcie_seq_item::type_id::create("req");
    assert(req.randomize() with {
      lp_valid == 64'hFFFFFFFFFFFFFFFF;
      lp_data != '0;
    });
    start_item(req);
    finish_item(req);
  endtask
endclass
