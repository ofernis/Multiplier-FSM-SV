// 32X32 Multiplier arithmetic unit template
module mult32x32_arith (
    input logic clk,             // Clock
    input logic reset,           // Reset
    input logic [31:0] a,        // Input a
    input logic [31:0] b,        // Input b
    input logic a_sel,           // Select one 2-byte word from A
    input logic b_sel,           // Select one 2-byte word from B
    input logic [1:0] shift_sel, // Select output from shifters
    input logic upd_prod,        // Update the product register
    input logic clr_prod,        // Clear the product register
    output logic [63:0] product  // Miltiplication product
);

// Put your code here
// ------------------
	logic [31:0] product_16x16 ;
	logic [63:0] product_shifter;
	logic [15:0] mux2_1; 
	logic [15:0] mux2_2;
	
	always_comb begin 
		if ( a_sel==1'b0 && b_sel==1'b0) begin
		mux2_2 = b[15:0] ;
		mux2_1 = a[15:0] ;
		end
		else if ( a_sel==1'b1 && b_sel==1'b0) begin
		mux2_2 = b[15:0] ;
		mux2_1 = a[31:16];
		end
		else if ( a_sel==1'b0 && b_sel==1'b1) begin
		mux2_2 = b[31:16] ;
		mux2_1 = a[15:0];
		end
		else if ( a_sel==1'b1 && b_sel==1'b1) begin
		mux2_2 = b[31:16];
		mux2_1 = a[31:16];
		end
	end
	
	always_comb begin 
		product_16x16= mux2_1 * mux2_2;
		product_shifter = product_16x16;
		
		if ( shift_sel == 2'b01 ) begin
		product_shifter = product_16x16 * (2**16);
		end
		else if ( shift_sel == 2'b10 ) begin
		product_shifter = product_16x16 * (2**32);
		end
	end
	
	always_ff @(posedge clk, posedge reset) begin 
        if (reset == 1'b1) begin
            product <= 0;
        end
		else if ( clr_prod == 1'b1 ) begin
			product <= 0;
		end
        else if ( upd_prod == 1'b1 ) begin
            product += product_shifter ;
        end
		else begin
		product += 0;
		end
    end

// End of your code

endmodule
