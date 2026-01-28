class reset_dma_seq extends uvm_sequence;
  `uvm_object_utils(reset_dma_seq)

  dma_reg_block reg_model;
  uvm_status_e status;

  function new(string name="reset_dma_seq");
    super.new(name);
  endfunction

  task body();

    reg_model.reset();
    reg_model.mirror(status, UVM_CHECK);

    `uvm_info(get_type_name(),"RESET CHECK DONE",UVM_LOW)

  endtask
endclass

class intr_reg_sequence extends uvm_sequence #(uvm_reg_item);
  `uvm_object_utils(intr_reg_sequence)

  dma_reg_block reg_model;
  uvm_status_e status;
  uvm_reg_data_t data;
  uvm_reg_data_t des;
  uvm_reg_data_t mir;
  uvm_reg_data_t read_d;

  function new(string name = "intr_reg_sequence");
    super.new(name);
  endfunction

  task body();
            
    reg_model.intr.write(status, 32'hFFFF_FFFF, UVM_FRONTDOOR);
    #20;
    des = reg_model.intr.get();
    mir = reg_model.intr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("INTR write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.intr.read(status, read_d, UVM_BACKDOOR);
    #20;
    des = reg_model.intr.get();
    mir = reg_model.intr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("INTR read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
    reg_model.intr.mirror(status, UVM_CHECK);
    
    reg_model.intr.write(status, 32'h0000_0000, UVM_FRONTDOOR);
    #20;
    des = reg_model.intr.get();
    mir = reg_model.intr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("INTR write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.intr.read(status, read_d, UVM_BACKDOOR);
    #20;
    des = reg_model.intr.get();
    mir = reg_model.intr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("INTR read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
    reg_model.intr.mirror(status, UVM_CHECK);
    
    repeat(50)begin
      reg_model.intr.write(status, $random, UVM_FRONTDOOR);
      #20;
      des = reg_model.intr.get();
      mir = reg_model.intr.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("INTR write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

      reg_model.intr.read(status, read_d, UVM_BACKDOOR);
      #20;
      des = reg_model.intr.get();
      mir = reg_model.intr.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("INTR read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
      reg_model.intr.mirror(status, UVM_CHECK);
    end
    
  endtask
endclass

class ctrl_reg_sequence extends uvm_sequence #(uvm_reg_item);
  `uvm_object_utils(ctrl_reg_sequence)

  dma_reg_block reg_model;
  uvm_status_e status;
  uvm_reg_data_t data;
  uvm_reg_data_t des;
  uvm_reg_data_t mir;
  uvm_reg_data_t read_d;

  function new(string name = "ctrl_reg_sequence");
    super.new(name);
  endfunction

  task body();
    
        
    reg_model.ctrl.write(status, 32'hFFFF_FFFF, UVM_FRONTDOOR);
    #20;
    des = reg_model.ctrl.get();
    mir = reg_model.ctrl.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("CTRL write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.ctrl.read(status, read_d, UVM_BACKDOOR);
    #20;
    des = reg_model.ctrl.get();
    mir = reg_model.ctrl.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("CTRL read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
    reg_model.ctrl.mirror(status, UVM_CHECK);
    
    reg_model.ctrl.write(status, 32'h0000_0000, UVM_FRONTDOOR);
    #20;
    des = reg_model.ctrl.get();
    mir = reg_model.ctrl.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("CTRL write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.ctrl.read(status, read_d, UVM_FRONTDOOR);
    #20;
    des = reg_model.ctrl.get();
    mir = reg_model.ctrl.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("CTRL read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
    reg_model.ctrl.mirror(status, UVM_CHECK);
    
    repeat(50)begin
      reg_model.ctrl.write(status, $random, UVM_FRONTDOOR);
      #20;
      des = reg_model.ctrl.get();
      mir = reg_model.ctrl.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("CTRL write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

      reg_model.ctrl.read(status, read_d, UVM_FRONTDOOR);
      #20;
      des = reg_model.ctrl.get();
      mir = reg_model.ctrl.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("CTRL read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
      reg_model.ctrl.mirror(status, UVM_CHECK);
    end
    
  endtask
endclass

class io_addr_reg_sequence extends uvm_sequence #(uvm_reg_item);
  `uvm_object_utils(io_addr_reg_sequence)

  dma_reg_block reg_model;
  uvm_status_e status;
  uvm_reg_data_t data;
  uvm_reg_data_t des;
  uvm_reg_data_t mir;
  uvm_reg_data_t read_d;

  function new(string name = "io_addr_reg_sequence");
    super.new(name);
  endfunction

  task body();
    
        
    reg_model.io_addr.write(status, 32'hFFFF_FFFF, UVM_FRONTDOOR);
    #20;
    des = reg_model.io_addr.get();
    mir = reg_model.io_addr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("IO_ADDR write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.io_addr.read(status, read_d, UVM_BACKDOOR);
    #20;
    des = reg_model.io_addr.get();
    mir = reg_model.io_addr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("IO_ADDR read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
    reg_model.io_addr.mirror(status, UVM_CHECK);
    
    reg_model.io_addr.write(status, 32'h0000_0000, UVM_FRONTDOOR);
    #20;
    des = reg_model.io_addr.get();
    mir = reg_model.io_addr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("IO_ADDR write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.io_addr.read(status, read_d, UVM_BACKDOOR);
    #20;
    des = reg_model.io_addr.get();
    mir = reg_model.io_addr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("IO_ADDR read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
    reg_model.io_addr.mirror(status, UVM_CHECK);

    reg_model.io_addr.write(status, 32'h0000_1001, UVM_FRONTDOOR);
    #20;
    des = reg_model.io_addr.get();
    mir = reg_model.io_addr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("IO_ADDR write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.io_addr.read(status, read_d, UVM_BACKDOOR);
    #20;
    des = reg_model.io_addr.get();
    mir = reg_model.io_addr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("IO_ADDR read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
    reg_model.io_addr.mirror(status, UVM_CHECK);
    
    repeat(50)begin
      reg_model.io_addr.write(status, $random, UVM_FRONTDOOR);
      #20;
      des = reg_model.io_addr.get();
      mir = reg_model.io_addr.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("IO_ADDR write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

      reg_model.io_addr.read(status, read_d, UVM_BACKDOOR);
      #20;
      des = reg_model.io_addr.get();
      mir = reg_model.io_addr.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("IO_ADDR read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
      reg_model.io_addr.mirror(status, UVM_CHECK);
    end
    
  endtask
endclass

class mem_addr_reg_sequence extends uvm_sequence #(uvm_reg_item);
  `uvm_object_utils(mem_addr_reg_sequence)

  dma_reg_block reg_model;
  uvm_status_e status;
  uvm_reg_data_t data;
  uvm_reg_data_t des;
  uvm_reg_data_t mir;
  uvm_reg_data_t read_d;

  function new(string name = "mem_addr_reg_sequence");
    super.new(name);
  endfunction

  task body();
    
        
    reg_model.mem_addr.write(status, 32'hFFFF_FFFF, UVM_FRONTDOOR);
    #20;
    des = reg_model.mem_addr.get();
    mir = reg_model.mem_addr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("MEM_ADDR write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.mem_addr.read(status, read_d, UVM_BACKDOOR);
    #20;
    des = reg_model.mem_addr.get();
    mir = reg_model.mem_addr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("MEM_ADDR read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
    reg_model.mem_addr.mirror(status, UVM_CHECK);
    
    reg_model.mem_addr.write(status, 32'h0000_0000, UVM_FRONTDOOR);
    #20;
    des = reg_model.mem_addr.get();
    mir = reg_model.mem_addr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("MEM_ADDR write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.mem_addr.read(status, read_d, UVM_BACKDOOR);
    #20;
    des = reg_model.mem_addr.get();
    mir = reg_model.mem_addr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("MEM_ADDR read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
    reg_model.mem_addr.mirror(status, UVM_CHECK);
    
    repeat(50)begin
      reg_model.mem_addr.write(status, $random, UVM_FRONTDOOR);
      #20;
      des = reg_model.mem_addr.get();
      mir = reg_model.mem_addr.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("MEM_ADDR write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

      reg_model.mem_addr.read(status, read_d, UVM_BACKDOOR);
      #20;
      des = reg_model.mem_addr.get();
      mir = reg_model.mem_addr.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("MEM_ADDR read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
      reg_model.mem_addr.mirror(status, UVM_CHECK);
    end    
  endtask
endclass

class  extra_info_reg_sequence extends uvm_sequence #(uvm_reg_item);
  `uvm_object_utils( extra_info_reg_sequence)

  dma_reg_block reg_model;
  uvm_status_e status;
  uvm_reg_data_t data;
  uvm_reg_data_t des;
  uvm_reg_data_t mir;
  uvm_reg_data_t read_d;

  function new(string name = " extra_info_reg_sequence");
    super.new(name);
  endfunction

  task body();
    
        
    reg_model. extra_info.write(status, 32'hFFFF_FFFF, UVM_FRONTDOOR);
    #20;
    des = reg_model. extra_info.get();
    mir = reg_model. extra_info.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("EXTRA_INFO write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model. extra_info.read(status, read_d, UVM_BACKDOOR);
    #20;
    des = reg_model.extra_info.get();
    mir = reg_model.extra_info.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("EXTRA_INFO read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
    reg_model. extra_info.mirror(status, UVM_CHECK);
    
    reg_model.extra_info.write(status, 32'h0000_0000, UVM_FRONTDOOR);
    #20;
    des = reg_model.extra_info.get();
    mir = reg_model.extra_info.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("EXTRA_INFO write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.extra_info.read(status, read_d, UVM_FRONTDOOR);
    #20;
    des = reg_model.extra_info.get();
    mir = reg_model.extra_info.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("EXTRA_INFO read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
    reg_model.extra_info.mirror(status, UVM_CHECK);
    
    repeat(50)begin
      reg_model.extra_info.write(status, $random, UVM_FRONTDOOR);
      #20;
      des = reg_model.extra_info.get();
      mir = reg_model.extra_info.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("EXTRA_INFO write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

      reg_model.extra_info.read(status, read_d, UVM_FRONTDOOR);
      #20;
      des = reg_model.extra_info.get();
      mir = reg_model.extra_info.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("EXTRA_INFO read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
      reg_model.extra_info.mirror(status, UVM_CHECK);
    end
    
  endtask
endclass

class status_reg_sequence extends uvm_sequence #(uvm_reg_item);
  `uvm_object_utils(status_reg_sequence)

  dma_reg_block reg_model;
  uvm_status_e status;
  uvm_reg_data_t data;
  uvm_reg_data_t des;
  uvm_reg_data_t mir;
  uvm_reg_data_t read_d;

  function new(string name = "status_reg_sequence");
    super.new(name);
  endfunction

  task body();
    
    reg_model.status.poke(status, 32'h0);
    #20;
    
    reg_model.status.poke(status, 32'h0);
    #20;
        
    reg_model.status.write(status, 32'hFFFF_FFFF, UVM_FRONTDOOR);
    #20;
    des = reg_model.status.get();
    mir = reg_model.status.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("STATUS write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.status.read(status, read_d, UVM_BACKDOOR);
    #20;
    des = reg_model.status.get();
    mir = reg_model.status.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("STATUS read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
    reg_model.status.mirror(status, UVM_CHECK);
    
    reg_model.status.write(status, 32'h0000_0000, UVM_FRONTDOOR);
    #20;
    des = reg_model.status.get();
    mir = reg_model.status.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("STATUS write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.status.read(status, read_d, UVM_BACKDOOR);
    #20;
    des = reg_model.status.get();
    mir = reg_model.status.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("STATUS read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
    reg_model.status.mirror(status, UVM_CHECK);
    
    repeat(50)begin
      reg_model.status.write(status, $random, UVM_FRONTDOOR);
      #20;
      des = reg_model.status.get();
      mir = reg_model.status.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("STATUS write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

      reg_model.status.read(status, read_d, UVM_BACKDOOR);
      #20;
      des = reg_model.status.get();
      mir = reg_model.status.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("STATUS read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
      reg_model.status.mirror(status, UVM_CHECK);
    end
    
  endtask
endclass

class transfer_count_reg_sequence extends uvm_sequence #(uvm_reg_item);
  `uvm_object_utils(transfer_count_reg_sequence)

  dma_reg_block reg_model;
  uvm_status_e status;
  uvm_reg_data_t data;
  uvm_reg_data_t des;
  uvm_reg_data_t mir;
  uvm_reg_data_t read_d;

  function new(string name = "transfer_count_reg_sequence");
    super.new(name);
  endfunction

  task body();
    
        
    reg_model.transfer_count.write(status, 32'hFFFF_FFFF, UVM_FRONTDOOR);
    #20;
    des = reg_model.transfer_count.get();
    mir = reg_model.transfer_count.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("TRANSFER_COUNT write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.transfer_count.read(status, read_d, UVM_BACKDOOR);
    #20;
    des = reg_model.transfer_count.get();
    mir = reg_model.transfer_count.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("TRANSFER_COUNT read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
    reg_model.transfer_count.mirror(status, UVM_CHECK);
    
    reg_model.transfer_count.write(status, 32'h0000_0000, UVM_FRONTDOOR);
    #20;
    des = reg_model.transfer_count.get();
    mir = reg_model.transfer_count.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("TRANSFER_COUNT write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.transfer_count.read(status, read_d, UVM_BACKDOOR);
    #20;
    des = reg_model.transfer_count.get();
    mir = reg_model.transfer_count.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("TRANSFER_COUNT read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
    reg_model.transfer_count.mirror(status, UVM_CHECK);
    
    repeat(50)begin
      reg_model.transfer_count.write(status, $random, UVM_FRONTDOOR);
      #20;
      des = reg_model.transfer_count.get();
      mir = reg_model.transfer_count.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("TRANSFER_COUNT write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

      reg_model.transfer_count.read(status, read_d, UVM_BACKDOOR);
      #20;
      des = reg_model.transfer_count.get();
      mir = reg_model.transfer_count.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("TRANSFER_COUNT read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
      reg_model.transfer_count.mirror(status, UVM_CHECK);
    end
    
  endtask
endclass

class descriptor_addr_reg_sequence extends uvm_sequence #(uvm_reg_item);
  `uvm_object_utils(descriptor_addr_reg_sequence)

  dma_reg_block reg_model;
  uvm_status_e status;
  uvm_reg_data_t data;
  uvm_reg_data_t des;
  uvm_reg_data_t mir;
  uvm_reg_data_t read_d;

  function new(string name = "descriptor_addr_reg_sequence");
    super.new(name);
  endfunction

  task body();
    
        
    reg_model.descriptor_addr.write(status, 32'hFFFF_FFFF, UVM_FRONTDOOR);
    #20;
    des = reg_model.descriptor_addr.get();
    mir = reg_model.descriptor_addr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("DESCRIPTOR_ADDR write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.descriptor_addr.read(status, read_d, UVM_BACKDOOR);
    #20;
    des = reg_model.descriptor_addr.get();
    mir = reg_model.descriptor_addr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("DESCRIPTOR_ADDR read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
    reg_model.descriptor_addr.mirror(status, UVM_CHECK);
    
    reg_model.descriptor_addr.write(status, 32'h0000_0000, UVM_FRONTDOOR);
    #20;
    des = reg_model.descriptor_addr.get();
    mir = reg_model.descriptor_addr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("DESCRIPTOR_ADDR write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.transfer_count.read(status, read_d, UVM_FRONTDOOR);
    #20;
    des = reg_model.descriptor_addr.get();
    mir = reg_model.descriptor_addr.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("DESCRIPTOR_ADDR read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
    reg_model.descriptor_addr.mirror(status, UVM_CHECK);
    
    repeat(50)begin
      reg_model.descriptor_addr.write(status, $random, UVM_FRONTDOOR);
      #20;
      des = reg_model.descriptor_addr.get();
      mir = reg_model.descriptor_addr.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("DESCRIPTOR_ADDR write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

      reg_model.descriptor_addr.read(status, read_d, UVM_FRONTDOOR);
      #20;
      des = reg_model.descriptor_addr.get();
      mir = reg_model.descriptor_addr.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("DESCRIPTOR_ADDR read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
      reg_model.descriptor_addr.mirror(status, UVM_CHECK);
    end
    
  endtask
endclass


class error_status_reg_sequence extends uvm_sequence #(uvm_reg_item);
  `uvm_object_utils(error_status_reg_sequence)

  dma_reg_block reg_model;
  uvm_status_e status;
  uvm_reg_data_t data;
  uvm_reg_data_t des;
  uvm_reg_data_t mir;
  uvm_reg_data_t read_d;

  function new(string name = "error_status_reg_sequence");
    super.new(name);
  endfunction

  task body();
    
        
    reg_model.error_status.write(status, 32'hFFFF_FFFF, UVM_FRONTDOOR);
    #20;
    des = reg_model.error_status.get();
    mir = reg_model.error_status.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("ERROR_STATUS  write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.descriptor_addr.read(status, read_d, UVM_BACKDOOR);
    #20;
    des = reg_model.error_status.get();
    mir = reg_model.error_status.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("ERROR_STATUS  read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
    reg_model.error_status.mirror(status, UVM_CHECK);
    
    reg_model.error_status.write(status, 32'h0000_0000, UVM_FRONTDOOR);
    #20;
    des = reg_model.error_status.get();
    mir = reg_model.error_status.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("ERROR_STATUS  write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.transfer_count.read(status, read_d, UVM_FRONTDOOR);
    #20;
    des = reg_model.error_status.get();
    mir = reg_model.error_status.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("ERROR_STATUS  read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
    reg_model.error_status.mirror(status, UVM_CHECK);
    
    repeat(50)begin
      reg_model.error_status.write(status, $random, UVM_FRONTDOOR);
      #20;
      des = reg_model.error_status.get();
      mir = reg_model.error_status.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("ERROR_STATUS  write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

      reg_model.error_status.read(status, read_d, UVM_FRONTDOOR);
      #20;
      des = reg_model.error_status.get();
      mir = reg_model.error_status.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("ERROR_STATUS read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
      reg_model.error_status.mirror(status, UVM_CHECK);
    end
    
  endtask
endclass

class config_reg_sequence extends uvm_sequence #(uvm_reg_item);
  `uvm_object_utils(config_reg_sequence)

  dma_reg_block reg_model;
  uvm_status_e status;
  uvm_reg_data_t data;
  uvm_reg_data_t des;
  uvm_reg_data_t mir;
  uvm_reg_data_t read_d;

  function new(string name = "config_reg_sequence");
    super.new(name);
  endfunction

  task body();
    
        
    reg_model.configer.write(status, 32'hFFFF_FFFF, UVM_FRONTDOOR);
    #20;
    des = reg_model.configer.get();
    mir = reg_model.configer.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("CONFIGER  write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.configer.read(status, read_d, UVM_BACKDOOR);
    #20;
    des = reg_model.configer.get();
    mir = reg_model.configer.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("CONFIGER  read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
    reg_model.configer.mirror(status, UVM_CHECK);
    
    reg_model.configer.write(status, 32'h0000_0000, UVM_FRONTDOOR);
    #20;
    des = reg_model.configer.get();
    mir = reg_model.configer.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("CONFIGER  write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.configer.read(status, read_d, UVM_FRONTDOOR);
    #20;
    des = reg_model.configer.get();
    mir = reg_model.configer.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("CONFIGER  read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
    reg_model.configer.mirror(status, UVM_CHECK);
    
    repeat(50)begin
      reg_model.configer.write(status, $random, UVM_FRONTDOOR);
      #20;
      des = reg_model.configer.get();
      mir = reg_model.configer.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("CONFIGER write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

      reg_model.configer.read(status, read_d, UVM_FRONTDOOR);
      #20;
      des = reg_model.configer.get();
      mir = reg_model.configer.get_mirrored_value();
      `uvm_info(get_type_name(),$sformatf("CONFIGER read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)    
      reg_model.configer.mirror(status, UVM_CHECK);
    end
    
  endtask
endclass

class regression_reg_sequence extends uvm_sequence;
  `uvm_object_utils(regression_reg_sequence)

  dma_reg_block reg_model;

  reset_dma_seq             s1;
  intr_reg_sequence         s2;
  ctrl_reg_sequence         s3;
  io_addr_reg_sequence      s4;
  mem_addr_reg_sequence     s5;
  extra_info_reg_sequence   s6;
  status_reg_sequence       s7;
  transfer_count_reg_sequence s8;
  descriptor_addr_reg_sequence s9;
  error_status_reg_sequence s10;
  config_reg_sequence       s11;

  function new(string name="regression_reg_sequence");
    super.new(name);
  endfunction

  task body();


    s1  = reset_dma_seq::type_id::create("s1");
    s2  = intr_reg_sequence::type_id::create("s2");
    s3  = ctrl_reg_sequence::type_id::create("s3");
    s4  = io_addr_reg_sequence::type_id::create("s4");
    s5  = mem_addr_reg_sequence::type_id::create("s5");
    s6  = extra_info_reg_sequence::type_id::create("s6");
    s7  = status_reg_sequence::type_id::create("s7");
    s8  = transfer_count_reg_sequence::type_id::create("s8");
    s9  = descriptor_addr_reg_sequence::type_id::create("s9");
    s10 = error_status_reg_sequence::type_id::create("s10");
    s11 = config_reg_sequence::type_id::create("s11");

    s1.reg_model  = reg_model;
    s2.reg_model  = reg_model;
    s3.reg_model  = reg_model;
    s4.reg_model  = reg_model;
    s5.reg_model  = reg_model;
    s6.reg_model  = reg_model;
    s7.reg_model  = reg_model;
    s8.reg_model  = reg_model;
    s9.reg_model  = reg_model;
    s10.reg_model = reg_model;
    s11.reg_model = reg_model;

    s1.start(m_sequencer);
    s2.start(m_sequencer);
    s3.start(m_sequencer);
    s4.start(m_sequencer);
    s5.start(m_sequencer);
    s6.start(m_sequencer);
    s7.start(m_sequencer);
    s8.start(m_sequencer);
    s9.start(m_sequencer);
    s10.start(m_sequencer);
    s11.start(m_sequencer);

  endtask
endclass
