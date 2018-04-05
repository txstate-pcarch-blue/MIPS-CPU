
module InstructionMemory(Addr, Clk, Inst);

input Clk;
input [31:0] Addr;  //instruction address supplied from PC
output [31:0] Inst;  //instruction to output

reg [31:0] MEM[0:256];

initial begin
$readmemh("fileExample.txt",MEM);
end 

always @(posedge Clk) begin
	Inst <= MEM[Addr[31:2]];
end

endmodule