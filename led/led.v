module led(clk_in, rst_n, led_out);
	input clk_in;
	input rst_n;
	output reg [2:0]led_out;
	
	parameter DIV_FCTR = 25'd24_000_000;
	integer div_cnt;
	
	initial
		begin
			div_cnt = 0;
			led_out[2:0] = 3'b001;
		end
		 
	always @ (posedge clk_in)
		if (~rst_n )
			begin
				div_cnt <= 0;
				led_out[2:0] = 3'b001;
			end
		else
			begin
				if (div_cnt == DIV_FCTR)
					begin
						div_cnt <= 0;
						led_out[2:0] = {led_out[0], led_out[2:1]};
					end
				else
					div_cnt <= div_cnt + 1;
			end	
endmodule
