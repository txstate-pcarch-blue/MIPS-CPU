module Accumulator_tb;

reg clock;
reg [0:7] din;
wire [0:7] dout;
integer seed = 1;

Accumulator a(clock, din, dout);

always #1 clock <= ~clock;

always @(posedge clock)
  din <= $random(seed);

initial
begin
  clock <= 0;
  $dumpfile("output/accu.vcd");
  $dumpvars(-1, a);
  $monitor("din: %b dout: %b", din, dout);
  #1024 $finish;
end

endmodule
