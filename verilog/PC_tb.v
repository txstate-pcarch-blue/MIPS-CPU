// PC Test Bench
// Branches to address "cafef00c" when counter = 11
// Else, PC = PC + 4

`timescale 1 ns / 1 ns

module pc_tb();

	parameter tck = 10; ///< clock tick

	reg [31:0] addrIn ;
	reg clk, reset, branch;
	wire [31:0] addrOut;


	pc dut(		.addrIn(addrIn),
				.clk(clk),
				.reset(reset),
				.branch(branch),
				.addrOut(addrOut)
			);
			
	integer num_iter = 0 ;
	integer seed = 1 ;
	always #(tck/2) clk <= ~clk; // clocking device

	initial begin
		$dumpfile("pc_ah.vcd");
		$dumpvars(-1, dut);
		$monitor("%b", addrOut);
	end
							
	//Initialise registers

	initial begin
		clk = 0 ; 
		reset = 1 ;
		addrIn = 0 ;
		branch = 0 ;
		#(tck);
		reset = 0 ;
	end
	
	always @(posedge clk) begin
		addrIn <= addrOut;

		if (num_iter == 11) begin
			branch <= 1 ;
			addrIn <= 32'hcafef00c;
		end

		else begin
			branch <= 0 ;
		end

		num_iter = num_iter+1 ;
		if (num_iter > 999) $finish;
	end


endmodule
