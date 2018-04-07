module Accumulator(input clock, input [0:7] din, output reg [0:7] dout);

always @(posedge clock)
  if (!(din === 8'bxxxxxxxx))
  begin
    dout <= dout + din;
  end

initial
  dout <= 0;

endmodule
