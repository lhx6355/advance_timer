`timescale 1 ns / 100 ps
module tb_tb;
reg timx_int0;
reg timx_int1;
reg timx_int2;
reg timx_int3;
reg css_ck_fail;
reg debug_mode;
reg timx_dbg_stop;
reg timx_etr;//极性选择，边沿检测和预分频器
reg timx_bkin;//刹车信号
reg [6:0] timx_dma_ack;
reg apb_clk;
reg apb_rst_n;
reg timx_psel;
reg timx_penable;
reg timx_pwrite;
reg [15:0] timx_paddr;
reg [31:0] timx_pwdata;
reg timx_ch1_in;
reg timx_ch2_in;
reg timx_ch3_in;
reg timx_ch4_in;
reg scan_mode;
reg scan_enable;
reg cfg_timx_break_ossi0_disout;

wire [7:0] tim_dbg_sigs;
wire timx_trgo;
wire timx_int;
wire timx_int_cc4of;
wire timx_int_cc3of;
wire timx_int_cc2of;
wire timx_int_cc1of;
wire timx_int_bk;
wire timx_int_trigger;
wire timx_int_com;
wire timx_int_cc4;
wire timx_int_cc3;
wire timx_int_cc2;
wire timx_int_cc1;
wire timx_int_ud;
wire [31:0] timx_prdata;
wire [6:0] timx_dma_req;
wire [6:0] timx_dma_single;
wire cc1_event;
wire cc2_event;
wire cc3_event;
wire cc4_event;
wire timx_ch1_out;
wire timx_ch1_out_en;
wire timx_ch1n_out;
wire timx_ch1n_out_en;
wire timx_ch2_out;
wire timx_ch2_out_en;
wire timx_ch2n_out;
wire timx_ch2n_out_en;
wire timx_ch3_out;
wire timx_ch3_out_en;
wire timx_ch3n_out;
wire timx_ch3n_out_en;
wire timx_ch4_out;
wire timx_ch4_out_en;




apoip_timer u1(
	//regs
	.timx_int0(timx_int0), 
	.timx_int1(timx_int1), 
	.timx_int2(timx_int2), 
	.timx_int3(timx_int3), 
	.css_ck_fail(css_ck_fail),
	.debug_mode(debug_mode), 
	.timx_dbg_stop(timx_dbg_stop), 
	.timx_etr(timx_etr), 
	.timx_bkin(timx_bkin), 
	.timx_dma_ack(timx_dma_ack),

	.apb_clk(apb_clk), 
	.apb_rst_n(apb_rst_n), 
	.timx_psel(timx_psel), 
	.timx_penable(timx_penable), 
	.timx_pwrite(timx_pwrite), 
	.timx_paddr(timx_paddr), 
	.timx_pwdata(timx_pwdata), 
	.timx_ch1_in(timx_ch1_in),
	.timx_ch2_in(timx_ch2_in), 
	.timx_ch3_in(timx_ch3_in), 
	.timx_ch4_in(timx_ch4_in), 
	.scan_mode(scan_mode), 
	.scan_enable(scan_enable),
	.cfg_timx_break_ossi0_disout(cfg_timx_break_ossi0_disout), 

	//wires
	.tim_dbg_sigs(tim_dbg_sigs), 
	.timx_trgo(timx_trgo), 
	.timx_int(timx_int), 
	.timx_int_cc4of(timx_int_cc4of),
	.timx_int_cc3of(timx_int_cc3of),
	.timx_int_cc2of(timx_int_cc2of),
	.timx_int_cc1of(timx_int_cc1of),
	.timx_int_bk(timx_int_bk), 
	.timx_int_trigger(timx_int_trigger),
	.timx_int_com(timx_int_com),
	.timx_int_cc4(timx_int_cc4), 
	.timx_int_cc3(timx_int_cc3), 
	.timx_int_cc2(timx_int_cc2), 
	.timx_int_cc1(timx_int_cc1),
	.timx_int_ud(timx_int_ud), 
	.timx_prdata(timx_prdata), 
	.timx_dma_req(timx_dma_req), 
	.timx_dma_single(timx_dma_single), 
	.cc1_event(cc1_event), 
	.cc2_event(cc2_event),
	.cc3_event(cc3_event), 
	.cc4_event(cc4_event), 
	.timx_ch1_out(timx_ch1_out),
	.timx_ch1_out_en(timx_ch1_out_en), 
	.timx_ch1n_out(timx_ch1n_out),
	.timx_ch1n_out_en(timx_ch1n_out_en), 
	.timx_ch2_out(timx_ch2_out), 
	.timx_ch2_out_en(timx_ch2_out_en), 
	.timx_ch2n_out(timx_ch2n_out), 
	.timx_ch2n_out_en(timx_ch2n_out_en), 
	.timx_ch3_out(timx_ch3_out), 
	.timx_ch3_out_en(timx_ch3_out_en), 
	.timx_ch3n_out(timx_ch3n_out), 
	.timx_ch3n_out_en(timx_ch3n_out_en), 
	.timx_ch4_out(timx_ch4_out),
	.timx_ch4_out_en(timx_ch4_out_en)
	);


always #5 apb_clk=~apb_clk;


initial begin
  apb_clk=0;
  apb_rst_n=0;
  timx_bkin=0;
  


  #100
  apb_rst_n=1;
  timx_psel=1;
  timx_penable=0;
  timx_pwrite=1;
  //timx_paddr=16'h002c;//自动重装载寄存器
  //timx_pwdata=32'h0000ffff;
  timx_paddr=16'h002c;//自动重装载寄存器
  timx_pwdata=32'h00000008;
  #10000
  timx_paddr=16'h0034;//CCR1
  timx_pwdata=32'h00000004;
  #10000
  timx_paddr=16'h000C;//中断使能
  timx_pwdata=32'h00000003;
  #10000
  timx_paddr=16'h0018;//CCMR1
  timx_pwdata=32'h00000068;
  #10000
  timx_paddr=16'h0014;//EGR
  timx_pwdata=32'h00000001;
  #10000
  timx_paddr=16'h0020;//CCER
  timx_pwdata=32'h00000005;
  #10000
  timx_paddr=16'h0044;//BDTR
  timx_pwdata=32'h0000BC00;
  #10000
  timx_paddr=16'b0;//控制寄存器1
  timx_pwdata=32'h000000A1;
  #100
  timx_pwrite=0;
  timx_paddr=16'h0044;

  #100000
  timx_bkin=1;

  #100000
  timx_bkin=0;


  #1000000
  
 
  $stop;
end

endmodule