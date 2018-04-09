module Accumulator_tb;

reg clock;
reg [0:7] din;
wire [0:7] dout;
integer seed = 1;
integer cycles = 1;
integer tb_length = 1000;

Accumulator a(clock, din, dout);

always #1 clock <= ~clock;

always @(posedge clock)
begin
  din <= $random(seed);
  cycles = cycles + 1;
end

always @(negedge clock)
  if (cycles > tb_length)
    $finish;

initial
begin
  clock <= 0;
  $dumpfile("output/accu.vcd");
  $dumpvars(-1, a);
  $monitor("din: %b dout: %b", din, dout);
end

endmodule
