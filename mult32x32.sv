// 32X32 Iterative Multiplier template
module mult32x32 (
    input logic clk,            // Clock
    input logic reset,          // Reset
    input logic start,          // Start signal
    input logic [31:0] a,       // Input a
    input logic [31:0] b,       // Input b
    output logic busy,          // Multiplier busy indication
    output logic [63:0] product // Miltiplication product
);

// Put your code here
// ------------------
	logic inner_a_sel ;
    logic inner_b_sel ;          
    logic [1:0] inner_shift_sel ;
    logic inner_upd_prod ;      
    logic inner_clr_prod ;      

	mult32x32_fsm inst_1 ( 
	.clk(clk),
	.reset(reset),
	.start(start),
	.busy(busy),
	.a_sel(inner_a_sel),
	.b_sel(inner_b_sel),
	.shift_sel(inner_shift_sel),
	.upd_prod(inner_upd_prod),
	.clr_prod(inner_clr_prod)
	);
	
	mult32x32_arith inst_2 (
	.clk(clk),
	.reset(reset),
	.a(a),
	.b(b),
	.a_sel(inner_a_sel),
	.b_sel(inner_b_sel),
	.shift_sel(inner_shift_sel),
	.upd_prod(inner_upd_prod),
	.clr_prod(inner_clr_prod),
	.product(product)
	);

// End of your code

endmodule
