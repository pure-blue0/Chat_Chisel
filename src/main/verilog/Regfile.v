module Regfile(
  input         clock,
  input         reset,
  input  [4:0]  io_id_rs1,
  input  [4:0]  io_id_rs2,
  input  [4:0]  io_wb_rd,
  input  [31:0] io_writedata,
  input         io_wb_regwrite,
  output [31:0] io_rs1_data,
  output [31:0] io_rs2_data
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] registers_0; // @[cmd5.sc 17:26]
  reg [31:0] registers_1; // @[cmd5.sc 17:26]
  reg [31:0] registers_2; // @[cmd5.sc 17:26]
  reg [31:0] registers_3; // @[cmd5.sc 17:26]
  reg [31:0] registers_4; // @[cmd5.sc 17:26]
  reg [31:0] registers_5; // @[cmd5.sc 17:26]
  reg [31:0] registers_6; // @[cmd5.sc 17:26]
  reg [31:0] registers_7; // @[cmd5.sc 17:26]
  reg [31:0] registers_8; // @[cmd5.sc 17:26]
  reg [31:0] registers_9; // @[cmd5.sc 17:26]
  reg [31:0] registers_10; // @[cmd5.sc 17:26]
  reg [31:0] registers_11; // @[cmd5.sc 17:26]
  reg [31:0] registers_12; // @[cmd5.sc 17:26]
  reg [31:0] registers_13; // @[cmd5.sc 17:26]
  reg [31:0] registers_14; // @[cmd5.sc 17:26]
  reg [31:0] registers_15; // @[cmd5.sc 17:26]
  reg [31:0] registers_16; // @[cmd5.sc 17:26]
  reg [31:0] registers_17; // @[cmd5.sc 17:26]
  reg [31:0] registers_18; // @[cmd5.sc 17:26]
  reg [31:0] registers_19; // @[cmd5.sc 17:26]
  reg [31:0] registers_20; // @[cmd5.sc 17:26]
  reg [31:0] registers_21; // @[cmd5.sc 17:26]
  reg [31:0] registers_22; // @[cmd5.sc 17:26]
  reg [31:0] registers_23; // @[cmd5.sc 17:26]
  reg [31:0] registers_24; // @[cmd5.sc 17:26]
  reg [31:0] registers_25; // @[cmd5.sc 17:26]
  reg [31:0] registers_26; // @[cmd5.sc 17:26]
  reg [31:0] registers_27; // @[cmd5.sc 17:26]
  reg [31:0] registers_28; // @[cmd5.sc 17:26]
  reg [31:0] registers_29; // @[cmd5.sc 17:26]
  reg [31:0] registers_30; // @[cmd5.sc 17:26]
  reg [31:0] registers_31; // @[cmd5.sc 17:26]
  wire [31:0] _GEN_1 = 5'h1 == io_id_rs1 ? registers_1 : registers_0; // @[cmd5.sc 20:21 cmd5.sc 20:21]
  wire [31:0] _GEN_2 = 5'h2 == io_id_rs1 ? registers_2 : _GEN_1; // @[cmd5.sc 20:21 cmd5.sc 20:21]
  wire [31:0] _GEN_3 = 5'h3 == io_id_rs1 ? registers_3 : _GEN_2; // @[cmd5.sc 20:21 cmd5.sc 20:21]
  wire [31:0] _GEN_4 = 5'h4 == io_id_rs1 ? registers_4 : _GEN_3; // @[cmd5.sc 20:21 cmd5.sc 20:21]
  wire [31:0] _GEN_5 = 5'h5 == io_id_rs1 ? registers_5 : _GEN_4; // @[cmd5.sc 20:21 cmd5.sc 20:21]
  wire [31:0] _GEN_6 = 5'h6 == io_id_rs1 ? registers_6 : _GEN_5; // @[cmd5.sc 20:21 cmd5.sc 20:21]
  wire [31:0] _GEN_7 = 5'h7 == io_id_rs1 ? registers_7 : _GEN_6; // @[cmd5.sc 20:21 cmd5.sc 20:21]
  wire [31:0] _GEN_8 = 5'h8 == io_id_rs1 ? registers_8 : _GEN_7; // @[cmd5.sc 20:21 cmd5.sc 20:21]
  wire [31:0] _GEN_9 = 5'h9 == io_id_rs1 ? registers_9 : _GEN_8; // @[cmd5.sc 20:21 cmd5.sc 20:21]
  wire [31:0] _GEN_10 = 5'ha == io_id_rs1 ? registers_10 : _GEN_9; // @[cmd5.sc 20:21 cmd5.sc 20:21]
  wire [31:0] _GEN_11 = 5'hb == io_id_rs1 ? registers_11 : _GEN_10; // @[cmd5.sc 20:21 cmd5.sc 20:21]
  wire [31:0] _GEN_12 = 5'hc == io_id_rs1 ? registers_12 : _GEN_11; // @[cmd5.sc 20:21 cmd5.sc 20:21]
  wire [31:0] _GEN_13 = 5'hd == io_id_rs1 ? registers_13 : _GEN_12; // @[cmd5.sc 20:21 cmd5.sc 20:21]
  wire [31:0] _GEN_14 = 5'he == io_id_rs1 ? registers_14 : _GEN_13; // @[cmd5.sc 20:21 cmd5.sc 20:21]
  wire [31:0] _GEN_15 = 5'hf == io_id_rs1 ? registers_15 : _GEN_14; // @[cmd5.sc 20:21 cmd5.sc 20:21]
  wire [31:0] _GEN_16 = 5'h10 == io_id_rs1 ? registers_16 : _GEN_15; // @[cmd5.sc 20:21 cmd5.sc 20:21]
  wire [31:0] _GEN_17 = 5'h11 == io_id_rs1 ? registers_17 : _GEN_16; // @[cmd5.sc 20:21 cmd5.sc 20:21]
  wire [31:0] _GEN_18 = 5'h12 == io_id_rs1 ? registers_18 : _GEN_17; // @[cmd5.sc 20:21 cmd5.sc 20:21]
  wire [31:0] _GEN_19 = 5'h13 == io_id_rs1 ? registers_19 : _GEN_18; // @[cmd5.sc 20:21 cmd5.sc 20:21]
  wire [31:0] _GEN_20 = 5'h14 == io_id_rs1 ? registers_20 : _GEN_19; // @[cmd5.sc 20:21 cmd5.sc 20:21]
  wire [31:0] _GEN_21 = 5'h15 == io_id_rs1 ? registers_21 : _GEN_20; // @[cmd5.sc 20:21 cmd5.sc 20:21]
  wire [31:0] _GEN_22 = 5'h16 == io_id_rs1 ? registers_22 : _GEN_21; // @[cmd5.sc 20:21 cmd5.sc 20:21]
  wire [31:0] _GEN_23 = 5'h17 == io_id_rs1 ? registers_23 : _GEN_22; // @[cmd5.sc 20:21 cmd5.sc 20:21]
  wire [31:0] _GEN_24 = 5'h18 == io_id_rs1 ? registers_24 : _GEN_23; // @[cmd5.sc 20:21 cmd5.sc 20:21]
  wire [31:0] _GEN_25 = 5'h19 == io_id_rs1 ? registers_25 : _GEN_24; // @[cmd5.sc 20:21 cmd5.sc 20:21]
  wire [31:0] _GEN_26 = 5'h1a == io_id_rs1 ? registers_26 : _GEN_25; // @[cmd5.sc 20:21 cmd5.sc 20:21]
  wire [31:0] _GEN_27 = 5'h1b == io_id_rs1 ? registers_27 : _GEN_26; // @[cmd5.sc 20:21 cmd5.sc 20:21]
  wire [31:0] _GEN_28 = 5'h1c == io_id_rs1 ? registers_28 : _GEN_27; // @[cmd5.sc 20:21 cmd5.sc 20:21]
  wire [31:0] _GEN_29 = 5'h1d == io_id_rs1 ? registers_29 : _GEN_28; // @[cmd5.sc 20:21 cmd5.sc 20:21]
  wire [31:0] _GEN_30 = 5'h1e == io_id_rs1 ? registers_30 : _GEN_29; // @[cmd5.sc 20:21 cmd5.sc 20:21]
  wire [31:0] _GEN_31 = 5'h1f == io_id_rs1 ? registers_31 : _GEN_30; // @[cmd5.sc 20:21 cmd5.sc 20:21]
  wire [31:0] _GEN_33 = 5'h1 == io_id_rs2 ? registers_1 : registers_0; // @[cmd5.sc 21:21 cmd5.sc 21:21]
  wire [31:0] _GEN_34 = 5'h2 == io_id_rs2 ? registers_2 : _GEN_33; // @[cmd5.sc 21:21 cmd5.sc 21:21]
  wire [31:0] _GEN_35 = 5'h3 == io_id_rs2 ? registers_3 : _GEN_34; // @[cmd5.sc 21:21 cmd5.sc 21:21]
  wire [31:0] _GEN_36 = 5'h4 == io_id_rs2 ? registers_4 : _GEN_35; // @[cmd5.sc 21:21 cmd5.sc 21:21]
  wire [31:0] _GEN_37 = 5'h5 == io_id_rs2 ? registers_5 : _GEN_36; // @[cmd5.sc 21:21 cmd5.sc 21:21]
  wire [31:0] _GEN_38 = 5'h6 == io_id_rs2 ? registers_6 : _GEN_37; // @[cmd5.sc 21:21 cmd5.sc 21:21]
  wire [31:0] _GEN_39 = 5'h7 == io_id_rs2 ? registers_7 : _GEN_38; // @[cmd5.sc 21:21 cmd5.sc 21:21]
  wire [31:0] _GEN_40 = 5'h8 == io_id_rs2 ? registers_8 : _GEN_39; // @[cmd5.sc 21:21 cmd5.sc 21:21]
  wire [31:0] _GEN_41 = 5'h9 == io_id_rs2 ? registers_9 : _GEN_40; // @[cmd5.sc 21:21 cmd5.sc 21:21]
  wire [31:0] _GEN_42 = 5'ha == io_id_rs2 ? registers_10 : _GEN_41; // @[cmd5.sc 21:21 cmd5.sc 21:21]
  wire [31:0] _GEN_43 = 5'hb == io_id_rs2 ? registers_11 : _GEN_42; // @[cmd5.sc 21:21 cmd5.sc 21:21]
  wire [31:0] _GEN_44 = 5'hc == io_id_rs2 ? registers_12 : _GEN_43; // @[cmd5.sc 21:21 cmd5.sc 21:21]
  wire [31:0] _GEN_45 = 5'hd == io_id_rs2 ? registers_13 : _GEN_44; // @[cmd5.sc 21:21 cmd5.sc 21:21]
  wire [31:0] _GEN_46 = 5'he == io_id_rs2 ? registers_14 : _GEN_45; // @[cmd5.sc 21:21 cmd5.sc 21:21]
  wire [31:0] _GEN_47 = 5'hf == io_id_rs2 ? registers_15 : _GEN_46; // @[cmd5.sc 21:21 cmd5.sc 21:21]
  wire [31:0] _GEN_48 = 5'h10 == io_id_rs2 ? registers_16 : _GEN_47; // @[cmd5.sc 21:21 cmd5.sc 21:21]
  wire [31:0] _GEN_49 = 5'h11 == io_id_rs2 ? registers_17 : _GEN_48; // @[cmd5.sc 21:21 cmd5.sc 21:21]
  wire [31:0] _GEN_50 = 5'h12 == io_id_rs2 ? registers_18 : _GEN_49; // @[cmd5.sc 21:21 cmd5.sc 21:21]
  wire [31:0] _GEN_51 = 5'h13 == io_id_rs2 ? registers_19 : _GEN_50; // @[cmd5.sc 21:21 cmd5.sc 21:21]
  wire [31:0] _GEN_52 = 5'h14 == io_id_rs2 ? registers_20 : _GEN_51; // @[cmd5.sc 21:21 cmd5.sc 21:21]
  wire [31:0] _GEN_53 = 5'h15 == io_id_rs2 ? registers_21 : _GEN_52; // @[cmd5.sc 21:21 cmd5.sc 21:21]
  wire [31:0] _GEN_54 = 5'h16 == io_id_rs2 ? registers_22 : _GEN_53; // @[cmd5.sc 21:21 cmd5.sc 21:21]
  wire [31:0] _GEN_55 = 5'h17 == io_id_rs2 ? registers_23 : _GEN_54; // @[cmd5.sc 21:21 cmd5.sc 21:21]
  wire [31:0] _GEN_56 = 5'h18 == io_id_rs2 ? registers_24 : _GEN_55; // @[cmd5.sc 21:21 cmd5.sc 21:21]
  wire [31:0] _GEN_57 = 5'h19 == io_id_rs2 ? registers_25 : _GEN_56; // @[cmd5.sc 21:21 cmd5.sc 21:21]
  wire [31:0] _GEN_58 = 5'h1a == io_id_rs2 ? registers_26 : _GEN_57; // @[cmd5.sc 21:21 cmd5.sc 21:21]
  wire [31:0] _GEN_59 = 5'h1b == io_id_rs2 ? registers_27 : _GEN_58; // @[cmd5.sc 21:21 cmd5.sc 21:21]
  wire [31:0] _GEN_60 = 5'h1c == io_id_rs2 ? registers_28 : _GEN_59; // @[cmd5.sc 21:21 cmd5.sc 21:21]
  wire [31:0] _GEN_61 = 5'h1d == io_id_rs2 ? registers_29 : _GEN_60; // @[cmd5.sc 21:21 cmd5.sc 21:21]
  wire [31:0] _GEN_62 = 5'h1e == io_id_rs2 ? registers_30 : _GEN_61; // @[cmd5.sc 21:21 cmd5.sc 21:21]
  wire [31:0] _GEN_63 = 5'h1f == io_id_rs2 ? registers_31 : _GEN_62; // @[cmd5.sc 21:21 cmd5.sc 21:21]
  assign io_rs1_data = io_id_rs1 == 5'h0 ? 32'h0 : _GEN_31; // @[cmd5.sc 20:21]
  assign io_rs2_data = io_id_rs2 == 5'h0 ? 32'h0 : _GEN_63; // @[cmd5.sc 21:21]
  always @(posedge clock) begin
    if (reset) begin // @[cmd5.sc 17:26]
      registers_0 <= 32'h0; // @[cmd5.sc 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[cmd5.sc 24:44]
      if (5'h0 == io_wb_rd) begin // @[cmd5.sc 25:25]
        registers_0 <= io_writedata; // @[cmd5.sc 25:25]
      end
    end
    if (reset) begin // @[cmd5.sc 17:26]
      registers_1 <= 32'h0; // @[cmd5.sc 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[cmd5.sc 24:44]
      if (5'h1 == io_wb_rd) begin // @[cmd5.sc 25:25]
        registers_1 <= io_writedata; // @[cmd5.sc 25:25]
      end
    end
    if (reset) begin // @[cmd5.sc 17:26]
      registers_2 <= 32'h0; // @[cmd5.sc 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[cmd5.sc 24:44]
      if (5'h2 == io_wb_rd) begin // @[cmd5.sc 25:25]
        registers_2 <= io_writedata; // @[cmd5.sc 25:25]
      end
    end
    if (reset) begin // @[cmd5.sc 17:26]
      registers_3 <= 32'h0; // @[cmd5.sc 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[cmd5.sc 24:44]
      if (5'h3 == io_wb_rd) begin // @[cmd5.sc 25:25]
        registers_3 <= io_writedata; // @[cmd5.sc 25:25]
      end
    end
    if (reset) begin // @[cmd5.sc 17:26]
      registers_4 <= 32'h0; // @[cmd5.sc 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[cmd5.sc 24:44]
      if (5'h4 == io_wb_rd) begin // @[cmd5.sc 25:25]
        registers_4 <= io_writedata; // @[cmd5.sc 25:25]
      end
    end
    if (reset) begin // @[cmd5.sc 17:26]
      registers_5 <= 32'h0; // @[cmd5.sc 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[cmd5.sc 24:44]
      if (5'h5 == io_wb_rd) begin // @[cmd5.sc 25:25]
        registers_5 <= io_writedata; // @[cmd5.sc 25:25]
      end
    end
    if (reset) begin // @[cmd5.sc 17:26]
      registers_6 <= 32'h0; // @[cmd5.sc 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[cmd5.sc 24:44]
      if (5'h6 == io_wb_rd) begin // @[cmd5.sc 25:25]
        registers_6 <= io_writedata; // @[cmd5.sc 25:25]
      end
    end
    if (reset) begin // @[cmd5.sc 17:26]
      registers_7 <= 32'h0; // @[cmd5.sc 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[cmd5.sc 24:44]
      if (5'h7 == io_wb_rd) begin // @[cmd5.sc 25:25]
        registers_7 <= io_writedata; // @[cmd5.sc 25:25]
      end
    end
    if (reset) begin // @[cmd5.sc 17:26]
      registers_8 <= 32'h0; // @[cmd5.sc 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[cmd5.sc 24:44]
      if (5'h8 == io_wb_rd) begin // @[cmd5.sc 25:25]
        registers_8 <= io_writedata; // @[cmd5.sc 25:25]
      end
    end
    if (reset) begin // @[cmd5.sc 17:26]
      registers_9 <= 32'h0; // @[cmd5.sc 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[cmd5.sc 24:44]
      if (5'h9 == io_wb_rd) begin // @[cmd5.sc 25:25]
        registers_9 <= io_writedata; // @[cmd5.sc 25:25]
      end
    end
    if (reset) begin // @[cmd5.sc 17:26]
      registers_10 <= 32'h0; // @[cmd5.sc 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[cmd5.sc 24:44]
      if (5'ha == io_wb_rd) begin // @[cmd5.sc 25:25]
        registers_10 <= io_writedata; // @[cmd5.sc 25:25]
      end
    end
    if (reset) begin // @[cmd5.sc 17:26]
      registers_11 <= 32'h0; // @[cmd5.sc 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[cmd5.sc 24:44]
      if (5'hb == io_wb_rd) begin // @[cmd5.sc 25:25]
        registers_11 <= io_writedata; // @[cmd5.sc 25:25]
      end
    end
    if (reset) begin // @[cmd5.sc 17:26]
      registers_12 <= 32'h0; // @[cmd5.sc 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[cmd5.sc 24:44]
      if (5'hc == io_wb_rd) begin // @[cmd5.sc 25:25]
        registers_12 <= io_writedata; // @[cmd5.sc 25:25]
      end
    end
    if (reset) begin // @[cmd5.sc 17:26]
      registers_13 <= 32'h0; // @[cmd5.sc 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[cmd5.sc 24:44]
      if (5'hd == io_wb_rd) begin // @[cmd5.sc 25:25]
        registers_13 <= io_writedata; // @[cmd5.sc 25:25]
      end
    end
    if (reset) begin // @[cmd5.sc 17:26]
      registers_14 <= 32'h0; // @[cmd5.sc 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[cmd5.sc 24:44]
      if (5'he == io_wb_rd) begin // @[cmd5.sc 25:25]
        registers_14 <= io_writedata; // @[cmd5.sc 25:25]
      end
    end
    if (reset) begin // @[cmd5.sc 17:26]
      registers_15 <= 32'h0; // @[cmd5.sc 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[cmd5.sc 24:44]
      if (5'hf == io_wb_rd) begin // @[cmd5.sc 25:25]
        registers_15 <= io_writedata; // @[cmd5.sc 25:25]
      end
    end
    if (reset) begin // @[cmd5.sc 17:26]
      registers_16 <= 32'h0; // @[cmd5.sc 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[cmd5.sc 24:44]
      if (5'h10 == io_wb_rd) begin // @[cmd5.sc 25:25]
        registers_16 <= io_writedata; // @[cmd5.sc 25:25]
      end
    end
    if (reset) begin // @[cmd5.sc 17:26]
      registers_17 <= 32'h0; // @[cmd5.sc 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[cmd5.sc 24:44]
      if (5'h11 == io_wb_rd) begin // @[cmd5.sc 25:25]
        registers_17 <= io_writedata; // @[cmd5.sc 25:25]
      end
    end
    if (reset) begin // @[cmd5.sc 17:26]
      registers_18 <= 32'h0; // @[cmd5.sc 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[cmd5.sc 24:44]
      if (5'h12 == io_wb_rd) begin // @[cmd5.sc 25:25]
        registers_18 <= io_writedata; // @[cmd5.sc 25:25]
      end
    end
    if (reset) begin // @[cmd5.sc 17:26]
      registers_19 <= 32'h0; // @[cmd5.sc 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[cmd5.sc 24:44]
      if (5'h13 == io_wb_rd) begin // @[cmd5.sc 25:25]
        registers_19 <= io_writedata; // @[cmd5.sc 25:25]
      end
    end
    if (reset) begin // @[cmd5.sc 17:26]
      registers_20 <= 32'h0; // @[cmd5.sc 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[cmd5.sc 24:44]
      if (5'h14 == io_wb_rd) begin // @[cmd5.sc 25:25]
        registers_20 <= io_writedata; // @[cmd5.sc 25:25]
      end
    end
    if (reset) begin // @[cmd5.sc 17:26]
      registers_21 <= 32'h0; // @[cmd5.sc 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[cmd5.sc 24:44]
      if (5'h15 == io_wb_rd) begin // @[cmd5.sc 25:25]
        registers_21 <= io_writedata; // @[cmd5.sc 25:25]
      end
    end
    if (reset) begin // @[cmd5.sc 17:26]
      registers_22 <= 32'h0; // @[cmd5.sc 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[cmd5.sc 24:44]
      if (5'h16 == io_wb_rd) begin // @[cmd5.sc 25:25]
        registers_22 <= io_writedata; // @[cmd5.sc 25:25]
      end
    end
    if (reset) begin // @[cmd5.sc 17:26]
      registers_23 <= 32'h0; // @[cmd5.sc 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[cmd5.sc 24:44]
      if (5'h17 == io_wb_rd) begin // @[cmd5.sc 25:25]
        registers_23 <= io_writedata; // @[cmd5.sc 25:25]
      end
    end
    if (reset) begin // @[cmd5.sc 17:26]
      registers_24 <= 32'h0; // @[cmd5.sc 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[cmd5.sc 24:44]
      if (5'h18 == io_wb_rd) begin // @[cmd5.sc 25:25]
        registers_24 <= io_writedata; // @[cmd5.sc 25:25]
      end
    end
    if (reset) begin // @[cmd5.sc 17:26]
      registers_25 <= 32'h0; // @[cmd5.sc 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[cmd5.sc 24:44]
      if (5'h19 == io_wb_rd) begin // @[cmd5.sc 25:25]
        registers_25 <= io_writedata; // @[cmd5.sc 25:25]
      end
    end
    if (reset) begin // @[cmd5.sc 17:26]
      registers_26 <= 32'h0; // @[cmd5.sc 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[cmd5.sc 24:44]
      if (5'h1a == io_wb_rd) begin // @[cmd5.sc 25:25]
        registers_26 <= io_writedata; // @[cmd5.sc 25:25]
      end
    end
    if (reset) begin // @[cmd5.sc 17:26]
      registers_27 <= 32'h0; // @[cmd5.sc 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[cmd5.sc 24:44]
      if (5'h1b == io_wb_rd) begin // @[cmd5.sc 25:25]
        registers_27 <= io_writedata; // @[cmd5.sc 25:25]
      end
    end
    if (reset) begin // @[cmd5.sc 17:26]
      registers_28 <= 32'h0; // @[cmd5.sc 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[cmd5.sc 24:44]
      if (5'h1c == io_wb_rd) begin // @[cmd5.sc 25:25]
        registers_28 <= io_writedata; // @[cmd5.sc 25:25]
      end
    end
    if (reset) begin // @[cmd5.sc 17:26]
      registers_29 <= 32'h0; // @[cmd5.sc 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[cmd5.sc 24:44]
      if (5'h1d == io_wb_rd) begin // @[cmd5.sc 25:25]
        registers_29 <= io_writedata; // @[cmd5.sc 25:25]
      end
    end
    if (reset) begin // @[cmd5.sc 17:26]
      registers_30 <= 32'h0; // @[cmd5.sc 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[cmd5.sc 24:44]
      if (5'h1e == io_wb_rd) begin // @[cmd5.sc 25:25]
        registers_30 <= io_writedata; // @[cmd5.sc 25:25]
      end
    end
    if (reset) begin // @[cmd5.sc 17:26]
      registers_31 <= 32'h0; // @[cmd5.sc 17:26]
    end else if (io_wb_regwrite & io_wb_rd != 5'h0) begin // @[cmd5.sc 24:44]
      if (5'h1f == io_wb_rd) begin // @[cmd5.sc 25:25]
        registers_31 <= io_writedata; // @[cmd5.sc 25:25]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  registers_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  registers_1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  registers_2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  registers_3 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  registers_4 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  registers_5 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  registers_6 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  registers_7 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  registers_8 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  registers_9 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  registers_10 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  registers_11 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  registers_12 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  registers_13 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  registers_14 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  registers_15 = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  registers_16 = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  registers_17 = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  registers_18 = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  registers_19 = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  registers_20 = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  registers_21 = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  registers_22 = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  registers_23 = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  registers_24 = _RAND_24[31:0];
  _RAND_25 = {1{`RANDOM}};
  registers_25 = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  registers_26 = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  registers_27 = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  registers_28 = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  registers_29 = _RAND_29[31:0];
  _RAND_30 = {1{`RANDOM}};
  registers_30 = _RAND_30[31:0];
  _RAND_31 = {1{`RANDOM}};
  registers_31 = _RAND_31[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
