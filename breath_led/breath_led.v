module breath_led(clk_in, rst_n, pwm_out);
	input clk_in;
	input rst_n;
	output reg pwm_out;
	
	parameter DIV_FACTOR = 2400; // 10kHz
	parameter PWM_PERIOD = 100;  // so the pwm frequency would be 10kHz / 100 = 100Hz
	integer pwm_thrs;
	integer clk_div_cnt;
	integer pwm_cnt;
	reg clk_1khz;
	
	initial
		begin
			pwm_thrs = 0;
			clk_div_cnt = 0;
			pwm_cnt = 0;
			clk_1khz = 0;
		end
	
	// Divide the clocl to 100Hz
	always @ (posedge clk_in)
		if (~rst_n)
			begin
				clk_div_cnt <= 0;
			end
		else
			begin
				if (clk_div_cnt == DIV_FACTOR)
					begin
						clk_div_cnt = 0;
						clk_1khz = ~clk_1khz;
					end
				else
					clk_div_cnt = clk_div_cnt + 1;
			end
	// PWM threshold control	
	always @ (posedge clk_1khz)
		if (~rst_n)
			pwm_thrs = 0;
		else 
			if (pwm_cnt == PWM_PERIOD)
				begin
					pwm_cnt = 0;
					pwm_thrs = pwm_thrs + 1;
					if (pwm_thrs == PWM_PERIOD)
						pwm_thrs = 0;
				end
			else
				pwm_cnt = pwm_cnt + 1;
	// Output control
	always @ (posedge clk_in)
		if (pwm_cnt < pwm_thrs)
			pwm_out = 1'b1;
		else
			pwm_out = 1'b0;
	
endmodule