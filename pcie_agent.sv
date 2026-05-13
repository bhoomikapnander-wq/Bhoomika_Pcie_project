class pcie_sequencer extends uvm_sequencer#(pcie_seq_item);
  `uvm_component_utils(pcie_sequencer)

  function new(string name = "pcie_sequencer", uvm_component parent = null);
    super.new(name, parent);
  endfunction
endclass

class pcie_driver extends uvm_driver#(pcie_seq_item);
  virtual pcie_if vif;
  `uvm_component_utils(pcie_driver)

  function new(string name = "pcie_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual pcie_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("DRV/NOIF", "Virtual interface not set for driver")
    end
  endfunction

  task run_phase(uvm_phase phase);
    pcie_seq_item req;
    forever begin
      seq_item_port.get_next_item(req);
      vif.lp_data <= req.lp_data;
      vif.lp_valid <= req.lp_valid;
      vif.lp_dlpstart <= req.lp_dlpstart;
      vif.lp_dlpend <= req.lp_dlpend;
      vif.lp_tlpstart <= req.lp_tlpstart;
      vif.lp_tlpend <= req.lp_tlpend;
      vif.lp_state_req <= req.lp_state_req;
      vif.lp_force_detect <= req.lp_force_detect;
      vif.lp_irdy <= 1'b1;
      @(posedge vif.clk);
      vif.lp_irdy <= 1'b0;
      vif.lp_data <= '0;
      vif.lp_valid <= '0;
      vif.lp_dlpstart <= '0;
      vif.lp_dlpend <= '0;
      vif.lp_tlpstart <= '0;
      vif.lp_tlpend <= '0;
      vif.lp_state_req <= '0;
      vif.lp_force_detect <= 1'b0;
      seq_item_port.item_done();
    end
  endtask
endclass

class pcie_monitor extends uvm_monitor;
  virtual pcie_if vif;
  uvm_analysis_port#(pcie_seq_item) analysis_port;
  `uvm_component_utils(pcie_monitor)

  function new(string name = "pcie_monitor", uvm_component parent = null);
    super.new(name, parent);
    analysis_port = new("analysis_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual pcie_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("MON/NOIF", "Virtual interface not set for monitor")
    end
  endfunction

  task run_phase(uvm_phase phase);
    pcie_seq_item item;
    item = pcie_seq_item::type_id::create("item");
    forever begin
      @(posedge vif.clk);
      if (vif.pl_valid != 64'h0) begin
        item.lp_data = vif.pl_data;
        item.lp_valid = vif.pl_valid;
        item.lp_dlpstart = vif.pl_dlpstart;
        item.lp_dlpend = vif.pl_dlpend;
        item.lp_tlpstart = vif.pl_tlpstart;
        item.lp_tlpend = vif.pl_tlpend;
        item.lp_state_req = vif.pl_state_sts;
        analysis_port.write(item);
      end
    end
  endtask
endclass
