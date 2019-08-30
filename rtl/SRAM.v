`include "SRAM1RW64x21.v"
`include "SRAM1RW64x22.v"


module data_arrays_0_ext(
  input RW0_clk,
  input [8:0] RW0_addr,
  input RW0_en,
  input RW0_wmode,
  input [31:0] RW0_wmask,
  input [255:0] RW0_wdata,
  output [255:0] RW0_rdata
);

  reg reg_RW0_ren;
  reg [8:0] reg_RW0_addr;
  reg [255:0] ram [511:0];
  wire C0, C1, C2, C3;

   decoder_2to4 chipSelect (
			.Y3(C3), 
			.Y2(C2), 
			.Y1(C1),
			.Y0(C0),
			.A(RW0_addr[8]), 
			.B(RW0_addr[7]), 
			.en(1'b1)
			);
  always @(posedge RW0_clk)
    reg_RW0_ren <= RW0_en && !RW0_wmode;

	genvar i; 
    generate
		for (i=0; i<32; i=i+1) begin: data0ext
		SRAM1RW128x8 SRAM128x8d_C0_instance ( //
			.A(RW0_addr[6:0]),
			.CE(RW0_clk),
			.WEB(reg_RW0_ren ? reg_RW0_ren : ~RW0_wmask[i]),
			.OEB(RW0_en),
			.CSB(C0),
			.I(RW0_wdata[i*8 +: 8]),
			.O(RW0_rdata[i*8 +: 8])
		);
		SRAM1RW128x8 SRAM128x8d_C1_instance (
			.A(RW0_addr[6:0]),
			.CE(RW0_clk),
			.WEB(reg_RW0_ren ? reg_RW0_ren : ~RW0_wmask[i]),
			.OEB(RW0_en),
			.CSB(C1),
			.I(RW0_wdata[i*8 +: 8]),
			.O(RW0_rdata[i*8 +: 8])
		);
		SRAM1RW128x8 SRAM128x8d_C2_instance (
			.A(RW0_addr[6:0]),
			.CE(RW0_clk),
			.WEB(reg_RW0_ren ? reg_RW0_ren : ~RW0_wmask[i]),
			.OEB(RW0_en),
			.CSB(C2),
			.I(RW0_wdata[i*8 +: 8]),
			.O(RW0_rdata[i*8 +: 8])
		);
		SRAM1RW128x8 SRAM128x8d_C3_instance (
			.A(RW0_addr[6:0]),
			.CE(RW0_clk),
			.WEB(reg_RW0_ren ? reg_RW0_ren : ~RW0_wmask[i]),
			.OEB(RW0_en),
			.CSB(C3),
			.I(RW0_wdata[i*8 +: 8]),
			.O(RW0_rdata[i*8 +: 8])
		); 	
	//module SRAM128x8d (A,CE,WEB,OEB,CSB,I,O);

      end 
    endgenerate
    //end	
endmodule

module tag_array_ext(
  input RW0_clk,
  input [5:0] RW0_addr,
  input RW0_en,
  input RW0_wmode,
  input [3:0] RW0_wmask,
  input [87:0] RW0_wdata,
  output [87:0] RW0_rdata
);

  reg reg_RW0_ren;
  //reg [5:0] reg_RW0_addr;
  reg [87:0] ram [63:0];

  always @(posedge RW0_clk)
    reg_RW0_ren <= RW0_en && !RW0_wmode;

    genvar i; 
    generate
      for (i=0; i<4; i=i+1) begin: tagarrayext
      SRAM1RW64x22 SRAM1RW64x22d_instance (
        .A(RW0_addr[5:0]),
        .CE(RW0_clk),
        .WEB(reg_RW0_ren ? reg_RW0_ren : ~RW0_wmask[i]),
	    .OEB(RW0_en),
		.CSB(1'b0),
        .I(RW0_wdata[i*22 +: 22]),
        .O(RW0_rdata[i*22 +: 22])
      );
	  
      end
     endgenerate	
	  
endmodule

module tag_array_0_ext(
  input RW0_clk,
  input [5:0] RW0_addr,
  input RW0_en,
  input RW0_wmode,
  input [3:0] RW0_wmask,
  input [83:0] RW0_wdata,
  output [83:0] RW0_rdata
);

  reg reg_RW0_ren;
  //reg [5:0] reg_RW0_addr;
  reg [83:0] ram [63:0];
  
    always @(posedge RW0_clk)
    reg_RW0_ren <= RW0_en && !RW0_wmode;

    genvar i; 
    generate
      for (i=0; i<4; i=i+1) begin: tagarray0ext
      SRAM1RW64x21 SRAM1RW64x21d_instance (
        .A(RW0_addr[5:0]),
        .CE(RW0_clk),
        .WEB(reg_RW0_ren ? reg_RW0_ren : ~RW0_wmask[i]),
	    .OEB(RW0_en),
		.CSB(1'b0),
        .I(RW0_wdata[i*21 +: 21]),
        .O(RW0_rdata[i*21 +: 21])
      );
	  
      end
     endgenerate	

endmodule

module data_arrays_0_0_ext(
  input RW0_clk,
  input [8:0] RW0_addr,
  input RW0_en,
  input RW0_wmode,
  input [3:0] RW0_wmask,
  input [127:0] RW0_wdata,
  output [127:0] RW0_rdata
);

  reg reg_RW0_ren;
  //reg [8:0] reg_RW0_addr;
  reg [127:0] ram [511:0];

 wire C0, C1, C2, C3;

   decoder_2to4 chipSelect (
			.Y3(C3), 
			.Y2(C2), 
			.Y1(C1),
			.Y0(C0),
			.A(RW0_addr[8]), 
			.B(RW0_addr[7]), 
			.en(1'b1)
			);
			
  
  always @(posedge RW0_clk)
    reg_RW0_ren <= RW0_en && !RW0_wmode;
  //always @(posedge RW0_clk)
   // if (RW0_en && !RW0_wmode) reg_RW0_addr <= RW0_addr;
  //always @(posedge RW0_clk)
    //if (RW0_en && RW0_wmode) begin
    genvar i; 
    generate
      for (i=0; i<16; i=i+1) begin: data00ext
      SRAM1RW128x8 SRAM128x8d_C0_instance (
        .A(RW0_addr[6:0]),
        .CE(RW0_clk),
        .WEB(reg_RW0_ren ? reg_RW0_ren : ~RW0_wmask[i]),
	    .OEB(RW0_en),
		.CSB(C0),
        .I(RW0_wdata[i*8 +: 8]),
        .O(RW0_rdata[i*8 +: 8])
      );
      SRAM1RW128x8 SRAM128x8d_C1_instance (
        .A(RW0_addr[6:0]),
        .CE(RW0_clk),
        .WEB(reg_RW0_ren ? reg_RW0_ren : ~RW0_wmask[i]),
	    .OEB(RW0_en),
		.CSB(C1),
        .I(RW0_wdata[i*8 +: 8]),
        .O(RW0_rdata[i*8 +: 8])
      );
      SRAM1RW128x8 SRAM128x8d_C2_instance (
        .A(RW0_addr[6:0]),
        .CE(RW0_clk),
        .WEB(reg_RW0_ren ? reg_RW0_ren : ~RW0_wmask[i]),
	    .OEB(RW0_en),
		.CSB(C2),
        .I(RW0_wdata[i*8 +: 8]),
        .O(RW0_rdata[i*8 +: 8])
      );
      SRAM1RW128x8 SRAM128x8d_C3_instance (
        .A(RW0_addr[6:0]),
        .CE(RW0_clk),
        .WEB(reg_RW0_ren ? reg_RW0_ren : ~RW0_wmask[i]),
	    .OEB(RW0_en),
		.CSB(C3),
        .I(RW0_wdata[i*8 +: 8]),
        .O(RW0_rdata[i*8 +: 8])
      );	  
      end
     endgenerate	
  
endmodule

module mem_ext(
  input W0_clk,
  input [24:0] W0_addr,
  input W0_en,
  input [63:0] W0_data,
  input [7:0] W0_mask,
  input R0_clk,
  input [24:0] R0_addr,
  input R0_en,
  output [63:0] R0_data
);
/*
  reg reg_R0_ren;
  reg [24:0] reg_R0_addr;
  reg [63:0] ram [33554431:0];
  `ifdef RANDOMIZE_MEM_INIT
    integer initvar;
    initial begin
      #`RANDOMIZE_DELAY begin end
      for (initvar = 0; initvar < 33554432; initvar = initvar+1)
        ram[initvar] = {2 {$random}};
      reg_R0_addr = {1 {$random}};
    end
  `endif
  integer i;
  always @(posedge R0_clk)
    reg_R0_ren <= R0_en;
  always @(posedge R0_clk)
    if (R0_en) reg_R0_addr <= R0_addr;
  always @(posedge W0_clk)
    if (W0_en) begin
      if (W0_mask[0]) ram[W0_addr][7:0] <= W0_data[7:0];
      if (W0_mask[1]) ram[W0_addr][15:8] <= W0_data[15:8];
      if (W0_mask[2]) ram[W0_addr][23:16] <= W0_data[23:16];
      if (W0_mask[3]) ram[W0_addr][31:24] <= W0_data[31:24];
      if (W0_mask[4]) ram[W0_addr][39:32] <= W0_data[39:32];
      if (W0_mask[5]) ram[W0_addr][47:40] <= W0_data[47:40];
      if (W0_mask[6]) ram[W0_addr][55:48] <= W0_data[55:48];
      if (W0_mask[7]) ram[W0_addr][63:56] <= W0_data[63:56];
    end
  `ifdef RANDOMIZE_GARBAGE_ASSIGN
  reg [63:0] R0_random;
  `ifdef RANDOMIZE_MEM_INIT
    initial begin
      #`RANDOMIZE_DELAY begin end
      R0_random = {$random, $random};
      reg_R0_ren = R0_random[0];
    end
  `endif
  always @(posedge R0_clk) R0_random <= {$random, $random};
  assign R0_data = reg_R0_ren ? ram[reg_R0_addr] : R0_random[63:0];
  `else
  assign R0_data = ram[reg_R0_addr];
  `endif
*/
endmodule

module mem_0_ext(
  input RW0_clk,
  input [8:0] RW0_addr,
  input RW0_en,
  input RW0_wmode,
  input [63:0] RW0_wdata,
  input [7:0] RW0_mask,
  input R0_en,
  output [63:0] RW0_rdata
);

  reg reg_RW0_ren;
  // reg [8:0] reg_RW0_addr;
  reg [63:0] ram [511:0];

  integer i;
  always @(posedge RW0_clk)
    reg_RW0_ren <=RW0_en && !RW0_wmode;
  //always @(posedge RW0_clk)
  //  if (RW0_en && !RW0_wmode) reg_RW0_addr <= RW0_addr;

 wire C0, C1, C2, C3;

   decoder_2to4 chipSelect (
			.Y3(C3), 
			.Y2(C2), 
			.Y1(C1),
			.Y0(C0),
			.A(RW0_addr[8]), 
			.B(RW0_addr[7]), 
			.en(1'b1)
			);
			
    genvar i; 
    generate
		for (i=0; i<8; i=i+1) begin: mem0ext
			SRAM1RW128x8 SRAM128x8d_C0_instance (
				.A(RW0_addr[6:0]),
				.CE(RW0_clk),
				.WEB(reg_RW0_ren ? reg_RW0_ren : ~RW0_wmask[i]),
				.OEB(RW0_en),
				.CSB(C0),
				.I(RW0_wdata[i*32 +: 32]),
				.O(RW0_rdata[i*32 +: 32])
			);
			SRAM1RW128x8 SRAM128x8d_C1_instance (
				.A(RW0_addr[6:0]),
				.CE(RW0_clk),
				.WEB(reg_RW0_ren ? reg_RW0_ren : ~RW0_wmask[i]),
				.OEB(RW0_en),
				.CSB(C1),
				.I(RW0_wdata[i*32 +: 32]),
				.O(RW0_rdata[i*32 +: 32])
			);
			SRAM1RW128x8 SRAM128x8d_C2_instance (
				.A(RW0_addr[6:0]),
				.CE(RW0_clk),
				.WEB(reg_RW0_ren ? reg_RW0_ren : ~RW0_wmask[i]),
				.OEB(RW0_en),
				.CSB(C2),
				.I(RW0_wdata[i*32 +: 32]),
				.O(RW0_rdata[i*32 +: 32])
			);
			SRAM1RW128x8 SRAM128x8d_C3_instance (
				.A(RW0_addr[6:0]),
				.CE(RW0_clk),
				.WEB(reg_RW0_ren ? reg_RW0_ren : ~RW0_wmask[i]),
				.OEB(RW0_en),
				.CSB(C3),
				.I(RW0_wdata[i*32 +: 32]),
				.O(RW0_rdata[i*32 +: 32])
			);	  
		end
     endgenerate	

endmodule

module decoder_2to4(Y3, Y2, Y1, Y0, A, B, en);
   output Y3, Y2, Y1, Y0;
   input  A, B;
   input  en;
   reg    Y3, Y2, Y1, Y0;
   always @(A or B or en) begin
     if (en == 1'b1) 
       case ( {A,B} )
         2'b00:   {Y3,Y2,Y1,Y0} = 4'b1110;
         2'b01:   {Y3,Y2,Y1,Y0} = 4'b1101;
         2'b10:   {Y3,Y2,Y1,Y0} = 4'b1011;
         2'b11:   {Y3,Y2,Y1,Y0} = 4'b0111;
         default: {Y3,Y2,Y1,Y0} = 4'bxxxx;
       endcase
     if (en == 0) 
       {Y3,Y2,Y1,Y0} = 4'b1111;
   end
endmodule

