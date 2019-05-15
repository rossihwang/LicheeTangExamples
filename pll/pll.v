`timescale 1ns / 100fs

// 100MHz
module pll_1_channel(refclk, rst_n, extlock, clk_out);

	input refclk;
	input rst_n;
	output extlock;
	output clk_out;
	
	wire clk_buf;
	parameter M = 1;
	parameter N = 4;
	
	EG_LOGIC_BUFG buf_feedback(.i(clk_buf), .o(clk_out));
	
	EG_PHY_PLL #(
		.DYNCFG("DISABLE"),
		.FIN("25.000"),
		.FEEDBK_PATH("CLKC0_EXT"),
		.STDBY_ENABLE("DISABLE"),
		.PLLRST_ENA("ENABLE"),
		.SYNC_ENABLE("ENABLE"),
		.DERIVE_PLL_CLOCKS("DISABLE"),
		.GEN_BASIC_CLOCK("DISABLE"),
		.GMC_GAIN(6),
		.ICP_CURRENT(3),
		.KVCO(6),
		.LPF_CAPACITOR(3),
		.LPF_RESISTOR(2),
		.REFCLK_DIV(M),
		.FBCLK_DIV(N),
		.CLKC0_ENABLE("ENABLE"),
		.CLKC0_DIV(1),
		.CLKC0_CPHASE(1),
		.CLKC0_FPHASE(0))
	pll_inst(
		.refclk(refclk),
		.reset(rst_n),
		.stdby(1'b0),
		.extlock(extlock),
		.psclk(1'b0),
		.psdown(1'b0),
		.psstep(1'b0),
		.psclksel(3'b000),
		.psdone(open),
		.dclk(1'b0),
		.dcs(1'b0),
		.dwe(1'b0),
		.di(8'b0000_0000),
		.daddr(6'b00_0000),
		.do({open, open, open, open, open, open, open, open}),
		.fbclk(clk_out),
		.clkc({open, open, open, open, clk_buf}));



endmodule
