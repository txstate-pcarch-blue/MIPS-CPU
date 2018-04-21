module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk, Rst,
regOut0,regOut1,regOut2,regOut3,regOut4,regOut5,regOut6,regOut7,
regOut8,regOut9,regOut10,regOut11,regOut12,regOut13,regOut14,regOut15,
regOut16,regOut17,regOut18,regOut19,regOut20,regOut21,regOut22,regOut23,
regOut24,regOut25,regOut26,regOut27,regOut28,regOut29,regOut30,regOut31
);

//Inputs: Read Register 1, Read Register 2, Write Register (5bits), Write Data (32bits), Write Control
	output reg [31:0] BusA, BusB;  //data to read
	input [4:0] RA, RB, RW;  //read addr A, read addr B, write addr
	input [31:0] BusW;  //data to write
	input RegWr;  //write ctrl
	input Clk, Rst;
	
	reg [31:0] registers [31:0];

	output [31:0] regOut0;
	output [31:0] regOut1;
	output [31:0] regOut2;
	output [31:0] regOut3;
	output [31:0] regOut4;
	output [31:0] regOut5;
	output [31:0] regOut6;
	output [31:0] regOut7;
	output [31:0] regOut8;
	output [31:0] regOut9;
	output [31:0] regOut10;
	output [31:0] regOut11;
	output [31:0] regOut12;
	output [31:0] regOut13;
	output [31:0] regOut14;
	output [31:0] regOut15;
	output [31:0] regOut16;
	output [31:0] regOut17;
	output [31:0] regOut18;
	output [31:0] regOut19;
	output [31:0] regOut20;
	output [31:0] regOut21;
	output [31:0] regOut22;
	output [31:0] regOut23;
	output [31:0] regOut24;
	output [31:0] regOut25;
	output [31:0] regOut26;
	output [31:0] regOut27;
	output [31:0] regOut28;
	output [31:0] regOut29;
	output [31:0] regOut30;
	output [31:0] regOut31;

	assign regOut0 = registers[0];
	assign regOut1 = registers[1];
	assign regOut2 = registers[2];
	assign regOut3 = registers[3];
	assign regOut4 = registers[4];
	assign regOut5 = registers[5];
	assign regOut6 = registers[6];
	assign regOut7 = registers[7];
	assign regOut8 = registers[8];
	assign regOut9 = registers[9];
	assign regOut10 = registers[10];
	assign regOut11 = registers[11];
	assign regOut12 = registers[12];
	assign regOut13 = registers[13];
	assign regOut14 = registers[14];
	assign regOut15 = registers[15];
	assign regOut16 = registers[16];
	assign regOut17 = registers[17];
	assign regOut18 = registers[18];
	assign regOut19 = registers[19];
	assign regOut20 = registers[20];
	assign regOut21 = registers[21];
	assign regOut22 = registers[22];
	assign regOut23 = registers[23];
	assign regOut24 = registers[24];
	assign regOut25 = registers[25];
	assign regOut26 = registers[26];
	assign regOut27 = registers[27];
	assign regOut28 = registers[28];
	assign regOut29 = registers[29];
	assign regOut30 = registers[30];
	assign regOut31 = registers[31];
	
	integer i, j;
	
	initial begin 
		for(j = 0; j < 32; j = j + 1) begin
				registers[j] <= 0;
		end
	end
	
	always begin
		@(posedge Clk) begin
			if (RegWr)
				registers[RW] <= BusW;
			else if (Rst) begin
				for(i = 0; i < 32; i = i + 1) 
					registers[i] <= 0;
			end
		end
		
		@(negedge Clk) begin
			BusA <= registers[RA];
			BusB <= registers[RB];
		end
	end
	
endmodule
