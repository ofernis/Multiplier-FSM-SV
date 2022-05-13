// 32X32 Multiplier test template
module mult32x32_fast_test;

    logic clk;            // Clock
    logic reset;          // Reset
    logic start;          // Start signal
    logic [31:0] a;       // Input a
    logic [31:0] b;       // Input b
    logic busy;           // Multiplier busy indication
    logic [63:0] product; // Miltiplication product

// Put your code here
// ------------------
mult32x32_fast uut(
	.clk(clk),
	.reset(reset),
	.start(start),
	.a(a),
	.b(b),
	.busy(busy),
	.product(product));
	
	always begin
		#1 clk = ~clk;
	end
	
	initial begin
		clk = 1'b1;
		reset = 1'b1;
		start = 1'b0;
		a = 32'b0;
		b = 32'b0;
		repeat(4) begin
			@(posedge clk);
		end
		reset = 1'b0;
		@(posedge clk);
		a = 32'd312367576;
		b = 32'd315073163;
		start = 1'b1;		
		@(posedge clk);
		start = 1'b0;
		repeat(4) begin
			@(posedge clk);
		end
		//@(negedge busy);
		@(posedge clk);
		a = {{16{1'b0}}, a[15:0]};
		b = {{16{1'b0}}, b[15:0]};
		start = 1'b1;
		@(posedge clk);
		start = 1'b0;
		@(negedge busy);
		
	end


// End of your code

endmodule
