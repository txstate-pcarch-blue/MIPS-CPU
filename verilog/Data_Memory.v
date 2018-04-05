
module DataMemory (MW, MR, Addr, WD, Clk, RD);

input MW, MR;
input [31:0] Addr;  // memory address
input [31:0] WD;  // memory address contents
input Clk;
output reg [31:0] RD;  // output of memory address contents

reg [31:0] MEM[0:255];  // 256 words of 32-bit memory

integer i;

initial begin
  RD <= 0;
  for (i = 0; i < 256; i = i + 1) begin
    MEM[i] = i;
  end
end

always @(posedge Clk) begin
  //if MemRead high, load value from memory into a register (e.g., lw instruction)
  if (MR == 1'b1) begin
    RD <= MEM[Addr];
  end
  //if MemWrite high, write from a reg to memory (e.g., sw instruction)
  if (MW == 1'b1) begin
    MEM[Addr] <= WD;
  end
end

endmodule