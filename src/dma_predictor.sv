class dma_predictor#(type BUSTYPE = int) extends uvm_reg_predictor#(dma_seq_item);
  `uvm_component_param_utils(dma_predictor#(BUSTYPE))
  
  function new(string name = "dma_predictor", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  virtual function void write(dma_seq_item tr);
    uvm_reg rg;
    uvm_reg_bus_op rw;
    
    super.write(tr);
    
    adapter.bus2reg(tr, rw);
    rg = map.get_reg_by_offset(rw.addr, (rw.kind == UVM_READ));
    
    rg.sample_values();
  endfunction
  
endclass
    
