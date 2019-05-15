module top(clk_in, rst_n, led_out);
	input clk_in;
	input rst_n;
	output wire[2:0] led_out;
	wire pll_clk;
	
//	defparam pll_inst.M = 1;
//	defparam pll_inst.N = 4;
	pll_1_channel #(.M(1), .N(4)) // pll_clk = clk_in / M * N
		pll_inst (
		.refclk(clk_in),
		.rst_n(~rst_n),
		.extlock(open),
		.clk_out(pll_clk));
	
	led led_inst(
		.clk_in(pll_clk),
		.rst_n(rst_n),
		.led_out(led_out));
	
endmodule
