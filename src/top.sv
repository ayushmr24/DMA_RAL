`include "design.sv"
`include "dma_interfs.sv"
`include "dma_pkg.sv"

import uvm_pkg::*;
import dma_pkg::*;

module tb;

  bit clk;
  bit rst_n;

  initial clk = 0;
  always #5 clk = ~clk;

  dma_interfs vif(clk, rst_n);

  dma_design DUT(.clk(clk), .rst_n(rst_n), .addr(vif.addr), .wr_en(vif.wr_en), .rd_en(vif.rd_en), .wdata(vif.wdata), .rdata(vif.rdata));

  initial begin
    uvm_config_db#(virtual dma_interfs)::set(null, "*", "vif", vif);

    rst_n = 0;
    repeat(5) @(posedge clk);
    rst_n = 1;
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end

  initial begin
    run_test("regression_dma_test");
  end

endmodule
