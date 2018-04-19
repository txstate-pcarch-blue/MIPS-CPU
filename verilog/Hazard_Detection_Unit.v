module hazard_unit(
	// Inputs
	RsD, RtD, Branch, RsE, RtE, WriteRegE, MemtoRegE, RegWriteE, WriteRegM, 
	MemtoRegM, RegWriteM, WriteRegW, RegWriteW, syscallD,

	// Outputs
	StallF, StallD, FlushE, ForwardAE, ForwardBE
);

	//1st source reg from Decode 
	input [4:0] RsD;
	//2nd source reg from Decode
	input [4:0] RtD;
	// Whether a branch instruction is executing, as determined by the EX stage.
	input BranchEX;
	//1st source reg from Execute
	input [4:0] RsE;
	//2nd source reg from Execute
	input [4:0] RtE;
	// The register that will be written to, as determined by the Execute stage.
	input [4:0] WriteRegE;
	// Whether data is being written from M->E, as determined by the Execute stage.
	input MemtoRegE;
	// Whether a register is written to, as determined by the Execute stage.
	input RegWriteE;
	// The register that will be written to, as determined by the Mem stage.
	input [4:0] WriteRegM;
	// Whether data is being written from M->E, as determined by the Mem stage.
	input MemtoRegM;
	// Whether a register is written to, as determined by the Mem stage.
	input RegWriteM;
	// The register that will be written to, as determined by the Writeback stage.
	input [4:0] WriteRegW;
	// Whether a register is written to, as determined by the Writeback stage.
	input RegWriteW;
	// Whether the decode stage is trying to do a syscall.
	input syscallD;


	// This flag is high when the Fetch stage needs to stall.
	output StallF;
	// This flag is high when the Decode stage needs to stall.
	output StallD;
	// True when the Execute stage needs to be flushed.
	output wire FlushE;
	// 1 for MEM/EX forwarding; 2 for EX/EX forwarding of Rs.
	output wire [1:0] ForwardAE;
	// 1 for MEM/EX forwarding; 2 for EX/EX forwarding of Rt.
	output wire [1:0] ForwardBE;
	// 1 if we need to stall for the syscall.
	wire stallSyscall;
	// Branch stall when a branch is taken (so the next PC is still decoding)
	wire branchStall;
	// Additional stall while we wait for load word's WB stage
	wire lwStall;
	// branchStall is high if we're branching and currently writing to a source reg
	assign branchStall = (BranchD && RegWriteE && 
						  (WriteRegE == RsD || WriteRegE == RtD))
					  || (BranchD && MemtoRegM && 
						  (WriteRegM == RsD || WriteRegM == RtD));

	// lwStall is high when we're writing from memory to a reg
	assign lwStall = ((RsD == RtE) || (RtD == RtE)) && MemtoRegE;

	// Stall when either stall signal has been set 
	assign StallF = (branchStall || lwStall );
	assign StallD = (branchStall || lwStall );

	// Flush when either stall signal has been set
	assign FlushE = (branchStall || lwStall );

	// Assign EX/EX or MEM/EX forwarding of Rs as appropriate
	assign ForwardAE = ((RsE != 0) && (RsE == WriteRegM) && RegWriteM)  ? 2'b10 : // EX/EX
					   (((RsE != 0) && (RsE == WriteRegW) && RegWriteW) ? 2'b01 : // MEM/EX
					   0);

	// Assign EX/EX or MEM/EX forwarding of Rt as appropriate
	assign ForwardBE = ((RtE != 0) && (RtE == WriteRegM) && RegWriteM)  ? 2'b10 : // EX/EX
					   (((RtE != 0) && (RtE == WriteRegW) && RegWriteW) ? 2'b01 : // MEM/EX
					   0);

endmodule
