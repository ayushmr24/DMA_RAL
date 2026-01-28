class dma_monitor extends uvm_monitor;
  `uvm_component_utils(dma_monitor)

  uvm_analysis_port#(dma_seq_item) ap;
  virtual dma_interfs vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ap = new("ap", this);
    if (!uvm_config_db#(virtual dma_interfs)::get(this, "", "vif", vif))
      `uvm_fatal("MON", "Virtual interface vif not set");
  endfunction

  task run_phase(uvm_phase phase);
    dma_seq_item tx;

    forever begin
      @(posedge vif.clk);

      if(vif.wr_en && !vif.rd_en) begin
        tx = dma_seq_item::type_id::create("tx");
        tx.wr_en  = 1;
        tx.rd_en  = 0;
        tx.addr   = vif.addr;
        tx.wdata  = vif.wdata;
        tx.rdata  = '0;
        ap.write(tx);
        $display($time,"MONITOR wr_en = %0d rd_en = %0d addr = %0d wdata = %0d rdata = %0d",tx.wr_en, tx.rd_en, tx.addr, tx.wdata, tx.rdata);
      end

      else if(vif.rd_en && !vif.wr_en) begin
        tx = dma_seq_item::type_id::create("tx");
        tx.wr_en = 0;
        tx.rd_en = 1;
        tx.addr  = vif.addr;

        @(posedge vif.clk);
        tx.rdata = vif.rdata;
        tx.wdata = '0;
        $display($time,"MONITOR wr_en = %0d rd_en = %0d addr = %0d wdata = %0d rdata = %0d",tx.wr_en, tx.rd_en, tx.addr, tx.wdata, tx.rdata);
        ap.write(tx);
      end
    end
  endtask

endclass

