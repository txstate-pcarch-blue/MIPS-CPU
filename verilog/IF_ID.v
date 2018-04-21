module IF_ID(InsIn, PC_In, InsOut, PC_out, IFID_write, IF_flush, clk, reset);

output reg [31:0] InsOut, PC_out;
input [31:0] InsIn, PC_In;
input clk, reset;
input IFID_write, IF_flush;

always@(posedge clk)
    begin

      if(reset == 1) begin
        InsOut <= 32'b0;
        PC_out <= 32'b0;
      end

      else begin
        if(IFID_write == 1) begin
        	InsOut <= InsIn;
        	PC_out <= PC_In;
        end

        if(IF_flush == 1) begin
        	InsOut <= 32'b0;
        	PC_out <= 32'b0;
        end
      end
    end

endmodule