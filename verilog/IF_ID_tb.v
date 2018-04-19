`timescale 1 ns / 1 ns

module IF_ID_tb();

	parameter tck = 10; ///< clock tick

	reg [31:0] InsIn, PC_In;
	reg clk, reset, IFID_write, IF_flush;
	wire [31:0] InsOut, PC_out;

	IF_ID dut(	
				.InsIn(InsIn),
				.PC_In(PC_In),
				.InsOut(InsOut),
				.PC_out(PC_out),
				.IFID_write(IFID_write),
				.IF_flush(IF_flush),
				.clk(clk),
				.reset(reset)
			);
			
	integer num_iter = 0 ;
	integer seed = 1 ;
	always #(tck/2) clk <= ~clk; // clocking device

	initial begin
		$dumpfile("ifid_ah.vcd");
		$dumpvars(-1, dut);
		$monitor("%b", InsOut);
	end
							
	//Initialise registers

	initial begin
		clk = 0 ; 
		reset = 0 ;
		InsIn = 0 ;
		PC_In = 0 ;
		IFID_write = 1 ;
		IF_flush = 0 ;
	end
	
	always @(posedge clk) begin
		PC_In <= $random(seed) ;
		InsIn <= $random(seed) ;
		num_iter = num_iter+1 ;

		if(num_iter == 10) IF_flush <= 1;
		if(num_iter == 11) IF_flush <= 0;
		if(num_iter == 5) IFID_write <= 0;
		if(num_iter == 6) IFID_write <= 1;

		if (num_iter > 999) $finish;
	end

endmodule
