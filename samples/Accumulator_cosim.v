module Accumulator_cosim;

reg clock;
reg [0:7] din;
wire [0:7] dout;

initial begin
  $from_myhdl(clock, din);
  $to_myhdl(dout);
end

Accumulator a(clock, din, dout);

endmodule
