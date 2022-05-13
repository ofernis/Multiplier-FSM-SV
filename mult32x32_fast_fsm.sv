// 32X32 Multiplier FSM
module mult32x32_fast_fsm (
    input logic clk,              // Clock
    input logic reset,            // Reset
    input logic start,            // Start signal
    input logic a_msw_is_0,       // Indicates MSW of operand A is 0
    input logic b_msw_is_0,       // Indicates MSW of operand B is 0
    output logic busy,            // Multiplier busy indication
    output logic a_sel,           // Select one 2-byte word from A
    output logic b_sel,           // Select one 2-byte word from B
    output logic [1:0] shift_sel, // Select output from shifters
    output logic upd_prod,        // Update the product register
    output logic clr_prod         // Clear the product register
);

// Put your code here
// ------------------

typedef enum { idle, multi_state_1, multi_state_2, 
				multi_state_3, multi_state_4 } st_type;
				
	st_type current_state;
	st_type next_state;
	
// procedural block
always_ff @(posedge clk, posedge reset) begin
	if (reset == 1'b1) begin
		current_state <= idle;
	end
	else begin
		current_state <= next_state;
	end
end
	
//outputs
always_comb begin
	busy = 1'b0;
	a_sel = 1'b0;
	b_sel = 1'b0;
	shift_sel = 2'b00;
	upd_prod = 1'b0;
	clr_prod = 1'b0;
	
	case (current_state)
		idle: begin
			if (start == 1'b1) begin
				next_state = multi_state_1;
				busy = 1'b0;
				upd_prod = 1'b0;
				clr_prod =1'b1;
			end
			else if (start == 1'b0) begin
				next_state = idle;
				busy = 1'b0;
				upd_prod = 1'b0;
				clr_prod =1'b0;
			end
		end
		multi_state_1: begin
			if (a_msw_is_0 == 1'b1 && b_msw_is_0 == 1'b1) begin
				next_state = idle;
				busy = 1'b1;
				a_sel = 1'b0;
				b_sel = 1'b0;
				shift_sel = 2'b00;
				upd_prod = 1'b1;
				clr_prod = 1'b0;
			end
			else if (a_msw_is_0 == 1'b1 && b_msw_is_0 == 1'b0) begin
				next_state = multi_state_3;
				busy = 1'b1;
				a_sel = 1'b0;
				b_sel = 1'b0;
				shift_sel = 2'b00;
				upd_prod = 1'b1;
				clr_prod = 1'b0;
			end
			else begin
				next_state = multi_state_2;
				busy = 1'b1;
				a_sel = 1'b0;
				b_sel = 1'b0;
				shift_sel = 2'b00;
				upd_prod = 1'b1;
				clr_prod = 1'b0;
			end
		end
		multi_state_2: begin
			if (a_msw_is_0 == 1'b0 && b_msw_is_0 == 1'b1) begin
				next_state = idle;
				busy = 1'b1;
				a_sel = 1'b1;
				b_sel = 1'b0;
				shift_sel = 2'b01;
				upd_prod = 1'b1;
				clr_prod = 1'b0;
			end
			else begin
				next_state = multi_state_3;
				busy = 1'b1;
				a_sel = 1'b1;
				b_sel = 1'b0;
				shift_sel = 2'b01;
				upd_prod = 1'b1;
				clr_prod = 1'b0;
			end
		end
		multi_state_3: begin
			if (a_msw_is_0 == 1'b1 && b_msw_is_0 == 1'b0) begin
				next_state = idle;
				busy = 1'b1;
				a_sel = 1'b0;
				b_sel = 1'b1;
				shift_sel = 2'b01;
				upd_prod = 1'b1;
				clr_prod = 1'b0;
			end
			else begin
				next_state = multi_state_4;
				busy = 1'b1;
				a_sel = 1'b0;
				b_sel = 1'b1;
				shift_sel = 2'b01;
				upd_prod = 1'b1;
				clr_prod = 1'b0;
			end
		end
		multi_state_4: begin
			next_state = idle;
			busy = 1'b1;
			a_sel = 1'b1;
			b_sel = 1'b1;
			shift_sel = 2'b10;
			upd_prod = 1'b1;
			clr_prod = 1'b0;
		end
	endcase
end


// End of your code

endmodule
