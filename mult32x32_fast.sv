// 32X32 Iterative Multiplier template
module mult32x32_fast (
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
	logic a_sel_inner ;
    logic b_sel_inner ;          
    logic [1:0] shift_sel_inner ;
    logic upd_prod_inner ;      
    logic clr_prod_inner ;  
	logic a_msw_is_0_inner;
	logic b_msw_is_0_inner;

	mult32x32_fast_fsm inst1 ( 
	.clk(clk),
	.reset(reset),
	.start(start),
	.busy(busy),
	.a_sel(a_sel_inner),
	.b_sel(b_sel_inner),
	.shift_sel(shift_sel_inner),
	.upd_prod(upd_prod_inner),
	.clr_prod(clr_prod_inner),
	.a_msw_is_0(a_msw_is_0_inner),
	.b_msw_is_0(b_msw_is_0_inner)
	);
	
	mult32x32_fast_arith inst2 (
	.clk(clk),
	.reset(reset),
	.a(a),
	.b(b),
	.a_sel(a_sel_inner),
	.b_sel(b_sel_inner),
	.shift_sel(shift_sel_inner),
	.upd_prod(upd_prod_inner),
	.clr_prod(clr_prod_inner),
	.product(product),
	.a_msw_is_0(a_msw_is_0_inner),
	.b_msw_is_0(b_msw_is_0_inner)
	);

// End of your code

endmodule
