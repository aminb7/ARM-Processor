`include "defines.v"

module SRAM(clk, rst, SRAM_we_n, SRAM_addr, SRAM_dq);
    input clk, rst, SRAM_we_n;
    input [16:0] SRAM_addr;
    inout [63:0] SRAM_dq;

    reg [31:0]memory[0:511];

    assign #30 SRAM_dq = SRAM_we_n ? {memory[{SRAM_addr[16:1], 1'b1}], memory[{SRAM_addr[16:1], 1'b0}]} : 64'bz;

    always @(posedge clk) begin
        if (~SRAM_we_n) begin
            memory[SRAM_addr] = SRAM_dq;
        end
    end
endmodule
