module CSR(
  input         clock,
  input         reset,
  input         io_meip,
  input  [11:0] io_csr_address,
  input  [31:0] io_mem_pc,
  output [31:0] io_csr_read_data,
  output        io_readable,
  output        io_writeable,
  input         io_csr_write_enable,
  input  [11:0] io_csr_write_address,
  input  [31:0] io_csr_write_data,
  input         io_inst_retired,
  input         io_trapped,
  input         io_mret,
  input  [2:0]  io_ecause,
  input         io_interrupt,
  output        io_eip,
  output        io_tip,
  output        io_sip,
  output [31:0] io_trap_vector,
  output [31:0] io_mret_vector
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [63:0] _RAND_1;
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
`endif // RANDOMIZE_REG_INIT
  reg [63:0] mcycle; // @[csr.scala 41:23]
  reg [63:0] minstret; // @[csr.scala 42:25]
  reg [31:0] mepc; // @[csr.scala 44:21]
  reg [31:0] mscratch; // @[csr.scala 45:25]
  reg [31:0] mtvec; // @[csr.scala 46:22]
  reg [3:0] mcause; // @[csr.scala 47:23]
  reg  minterrupt; // @[csr.scala 48:27]
  reg  pie; // @[csr.scala 50:20]
  reg  ie; // @[csr.scala 51:19]
  reg  meie; // @[csr.scala 52:21]
  reg  msie; // @[csr.scala 53:21]
  reg  msip; // @[csr.scala 54:21]
  reg  mtie; // @[csr.scala 55:21]
  reg  mtip; // @[csr.scala 56:21]
  wire [31:0] _csr_read_data_T_3 = {21'h0,3'h0,pie,2'h0,1'h0,ie,1'h0,2'h0}; // @[Cat.scala 31:58]
  wire [31:0] _csr_read_data_T_5 = {20'h0,io_meip,2'h0,1'h0,mtip,1'h0,2'h0,msip,3'h0}; // @[Cat.scala 31:58]
  wire [31:0] _csr_read_data_T_6 = {20'h0,meie,2'h0,1'h0,mtie,1'h0,2'h0,msie,3'h0}; // @[Cat.scala 31:58]
  wire [31:0] _csr_read_data_T_8 = {mtvec[31:2],2'h0}; // @[Cat.scala 31:58]
  wire [31:0] _csr_read_data_T_9 = {minterrupt,27'h0,mcause}; // @[Cat.scala 31:58]
  wire [31:0] _GEN_0 = 12'hb02 == io_csr_address ? minstret[31:0] : 32'h0; // @[csr.scala 141:21 69:26]
  wire [31:0] _GEN_2 = 12'hb00 == io_csr_address | 12'hb01 == io_csr_address ? mcycle[31:0] : _GEN_0; // @[csr.scala 136:21 69:26]
  wire  _GEN_3 = 12'hb00 == io_csr_address | 12'hb01 == io_csr_address | 12'hb02 == io_csr_address; // @[csr.scala 137:16 69:26]
  wire [31:0] _GEN_4 = 12'h343 == io_csr_address ? 32'h0 : _GEN_2; // @[csr.scala 131:21 69:26]
  wire  _GEN_5 = 12'h343 == io_csr_address | _GEN_3; // @[csr.scala 132:16 69:26]
  wire [31:0] _GEN_6 = 12'h342 == io_csr_address ? _csr_read_data_T_9 : _GEN_4; // @[csr.scala 126:21 69:26]
  wire  _GEN_7 = 12'h342 == io_csr_address | _GEN_5; // @[csr.scala 127:16 69:26]
  wire [31:0] _GEN_8 = 12'h341 == io_csr_address ? mepc : _GEN_6; // @[csr.scala 121:21 69:26]
  wire  _GEN_9 = 12'h341 == io_csr_address | _GEN_7; // @[csr.scala 122:16 69:26]
  wire [31:0] _GEN_10 = 12'h340 == io_csr_address ? mscratch : _GEN_8; // @[csr.scala 116:21 69:26]
  wire  _GEN_11 = 12'h340 == io_csr_address | _GEN_9; // @[csr.scala 117:16 69:26]
  wire [31:0] _GEN_12 = 12'h305 == io_csr_address ? _csr_read_data_T_8 : _GEN_10; // @[csr.scala 111:21 69:26]
  wire  _GEN_13 = 12'h305 == io_csr_address | _GEN_11; // @[csr.scala 112:16 69:26]
  wire [31:0] _GEN_14 = 12'h304 == io_csr_address ? _csr_read_data_T_6 : _GEN_12; // @[csr.scala 106:21 69:26]
  wire  _GEN_15 = 12'h304 == io_csr_address | _GEN_13; // @[csr.scala 107:16 69:26]
  wire [31:0] _GEN_16 = 12'h344 == io_csr_address ? _csr_read_data_T_5 : _GEN_14; // @[csr.scala 101:21 69:26]
  wire  _GEN_17 = 12'h344 == io_csr_address | _GEN_15; // @[csr.scala 102:16 69:26]
  wire [31:0] _GEN_18 = 12'h301 == io_csr_address ? 32'h40000100 : _GEN_16; // @[csr.scala 69:26 96:21]
  wire  _GEN_19 = 12'h301 == io_csr_address | _GEN_17; // @[csr.scala 69:26 97:16]
  wire [31:0] _GEN_20 = 12'h300 == io_csr_address ? _csr_read_data_T_3 : _GEN_18; // @[csr.scala 69:26 91:21]
  wire  _GEN_21 = 12'h300 == io_csr_address | _GEN_19; // @[csr.scala 69:26 92:16]
  wire [31:0] _GEN_22 = 12'hf11 == io_csr_address | 12'hf12 == io_csr_address | 12'hf13 == io_csr_address | 12'hf14 ==
    io_csr_address ? 32'h0 : _GEN_20; // @[csr.scala 69:26 86:21]
  wire  _GEN_23 = 12'hf11 == io_csr_address | 12'hf12 == io_csr_address | 12'hf13 == io_csr_address | 12'hf14 ==
    io_csr_address | _GEN_21; // @[csr.scala 69:26 87:16]
  wire  _GEN_24 = 12'hf11 == io_csr_address | 12'hf12 == io_csr_address | 12'hf13 == io_csr_address | 12'hf14 ==
    io_csr_address ? 1'h0 : _GEN_21; // @[csr.scala 69:26 88:17]
  wire [31:0] _GEN_25 = 12'hc82 == io_csr_address ? minstret[63:32] : _GEN_22; // @[csr.scala 69:26 81:21]
  wire  _GEN_26 = 12'hc82 == io_csr_address | _GEN_23; // @[csr.scala 69:26 82:16]
  wire  _GEN_27 = 12'hc82 == io_csr_address ? 1'h0 : _GEN_24; // @[csr.scala 69:26 83:17]
  wire [31:0] _GEN_28 = 12'hc02 == io_csr_address ? minstret[31:0] : _GEN_25; // @[csr.scala 69:26 76:21]
  wire  _GEN_29 = 12'hc02 == io_csr_address | _GEN_26; // @[csr.scala 69:26 77:16]
  wire  _GEN_30 = 12'hc02 == io_csr_address ? 1'h0 : _GEN_27; // @[csr.scala 69:26 78:17]
  wire  _GEN_34 = io_mret ? pie : ie; // @[csr.scala 156:24 157:8 51:19]
  wire  _GEN_35 = io_mret | pie; // @[csr.scala 156:24 158:9 50:20]
  wire  _GEN_36 = io_trapped ? ie : _GEN_35; // @[csr.scala 150:20 151:9]
  wire  _GEN_37 = io_trapped ? 1'h0 : _GEN_34; // @[csr.scala 150:20 152:8]
  wire [31:0] _GEN_38 = io_trapped ? io_mem_pc : mepc; // @[csr.scala 150:20 153:10 44:21]
  wire  _GEN_39 = io_trapped ? io_interrupt : minterrupt; // @[csr.scala 150:20 154:16 48:27]
  wire [3:0] _GEN_40 = io_trapped ? {{1'd0}, io_ecause} : mcause; // @[csr.scala 150:20 155:12 47:23]
  wire [63:0] _mcycle_T_1 = mcycle + 64'h1; // @[csr.scala 161:20]
  wire [63:0] _minstret_T_1 = minstret + 64'h1; // @[csr.scala 163:26]
  wire [63:0] _GEN_41 = io_inst_retired ? _minstret_T_1 : minstret; // @[csr.scala 162:25 163:14 42:25]
  wire [31:0] _mtvec_T_1 = {io_csr_write_data[31:2],2'h0}; // @[Cat.scala 31:58]
  wire [63:0] _mcycle_T_2 = {32'h0,io_csr_write_data}; // @[Cat.scala 31:58]
  wire [63:0] _mcycle_T_3 = _mcycle_T_2 | mcycle; // @[csr.scala 198:52]
  wire [63:0] _minstret_T_3 = _mcycle_T_2 | minstret; // @[csr.scala 201:54]
  wire [63:0] _GEN_42 = 12'hb02 == io_csr_write_address ? _minstret_T_3 : _GEN_41; // @[csr.scala 168:34 201:18]
  wire [63:0] _GEN_43 = 12'hb00 == io_csr_write_address | 12'hb01 == io_csr_write_address ? _mcycle_T_3 : _mcycle_T_1; // @[csr.scala 161:10 168:34 198:16]
  wire [63:0] _GEN_44 = 12'hb00 == io_csr_write_address | 12'hb01 == io_csr_write_address ? _GEN_41 : _GEN_42; // @[csr.scala 168:34]
  wire [63:0] _GEN_46 = 12'h343 == io_csr_write_address ? _mcycle_T_1 : _GEN_43; // @[csr.scala 161:10 168:34]
  wire [63:0] _GEN_47 = 12'h343 == io_csr_write_address ? _GEN_41 : _GEN_44; // @[csr.scala 168:34]
  wire  _GEN_48 = 12'h342 == io_csr_write_address ? io_csr_write_data[31] : _GEN_39; // @[csr.scala 168:34 191:20]
  wire [3:0] _GEN_49 = 12'h342 == io_csr_write_address ? io_csr_write_data[3:0] : _GEN_40; // @[csr.scala 168:34 192:16]
  wire [63:0] _GEN_51 = 12'h342 == io_csr_write_address ? _mcycle_T_1 : _GEN_46; // @[csr.scala 161:10 168:34]
  wire [63:0] _GEN_52 = 12'h342 == io_csr_write_address ? _GEN_41 : _GEN_47; // @[csr.scala 168:34]
  wire [31:0] _GEN_53 = 12'h341 == io_csr_write_address ? io_csr_write_data : _GEN_38; // @[csr.scala 168:34 188:14]
  wire  _GEN_54 = 12'h341 == io_csr_write_address ? _GEN_39 : _GEN_48; // @[csr.scala 168:34]
  wire [3:0] _GEN_55 = 12'h341 == io_csr_write_address ? _GEN_40 : _GEN_49; // @[csr.scala 168:34]
  wire [63:0] _GEN_57 = 12'h341 == io_csr_write_address ? _mcycle_T_1 : _GEN_51; // @[csr.scala 161:10 168:34]
  wire [63:0] _GEN_58 = 12'h341 == io_csr_write_address ? _GEN_41 : _GEN_52; // @[csr.scala 168:34]
  wire [31:0] _GEN_59 = 12'h340 == io_csr_write_address ? io_csr_write_data : mscratch; // @[csr.scala 168:34 185:18 45:25]
  wire [31:0] _GEN_60 = 12'h340 == io_csr_write_address ? _GEN_38 : _GEN_53; // @[csr.scala 168:34]
  wire  _GEN_61 = 12'h340 == io_csr_write_address ? _GEN_39 : _GEN_54; // @[csr.scala 168:34]
  wire [3:0] _GEN_62 = 12'h340 == io_csr_write_address ? _GEN_40 : _GEN_55; // @[csr.scala 168:34]
  wire [63:0] _GEN_64 = 12'h340 == io_csr_write_address ? _mcycle_T_1 : _GEN_57; // @[csr.scala 161:10 168:34]
  wire [63:0] _GEN_65 = 12'h340 == io_csr_write_address ? _GEN_41 : _GEN_58; // @[csr.scala 168:34]
  wire [31:0] _GEN_66 = 12'h305 == io_csr_write_address ? _mtvec_T_1 : mtvec; // @[csr.scala 168:34 182:15 46:22]
  wire [31:0] _GEN_67 = 12'h305 == io_csr_write_address ? mscratch : _GEN_59; // @[csr.scala 168:34 45:25]
  wire [31:0] _GEN_68 = 12'h305 == io_csr_write_address ? _GEN_38 : _GEN_60; // @[csr.scala 168:34]
  wire  _GEN_69 = 12'h305 == io_csr_write_address ? _GEN_39 : _GEN_61; // @[csr.scala 168:34]
  wire [3:0] _GEN_70 = 12'h305 == io_csr_write_address ? _GEN_40 : _GEN_62; // @[csr.scala 168:34]
  wire [63:0] _GEN_72 = 12'h305 == io_csr_write_address ? _mcycle_T_1 : _GEN_64; // @[csr.scala 161:10 168:34]
  wire [63:0] _GEN_73 = 12'h305 == io_csr_write_address ? _GEN_41 : _GEN_65; // @[csr.scala 168:34]
  wire  _GEN_74 = 12'h304 == io_csr_write_address ? io_csr_write_data[3] : msie; // @[csr.scala 168:34 177:14 53:21]
  wire  _GEN_75 = 12'h304 == io_csr_write_address ? io_csr_write_data[7] : mtie; // @[csr.scala 168:34 178:14 55:21]
  wire  _GEN_76 = 12'h304 == io_csr_write_address ? io_csr_write_data[11] : meie; // @[csr.scala 168:34 179:14 52:21]
  wire [31:0] _GEN_77 = 12'h304 == io_csr_write_address ? mtvec : _GEN_66; // @[csr.scala 168:34 46:22]
  wire [31:0] _GEN_78 = 12'h304 == io_csr_write_address ? mscratch : _GEN_67; // @[csr.scala 168:34 45:25]
  wire [31:0] _GEN_79 = 12'h304 == io_csr_write_address ? _GEN_38 : _GEN_68; // @[csr.scala 168:34]
  wire  _GEN_80 = 12'h304 == io_csr_write_address ? _GEN_39 : _GEN_69; // @[csr.scala 168:34]
  wire [3:0] _GEN_81 = 12'h304 == io_csr_write_address ? _GEN_40 : _GEN_70; // @[csr.scala 168:34]
  wire [63:0] _GEN_83 = 12'h304 == io_csr_write_address ? _mcycle_T_1 : _GEN_72; // @[csr.scala 161:10 168:34]
  wire [63:0] _GEN_84 = 12'h304 == io_csr_write_address ? _GEN_41 : _GEN_73; // @[csr.scala 168:34]
  assign io_csr_read_data = 12'hc00 == io_csr_address | 12'hc01 == io_csr_address ? mcycle[31:0] : _GEN_28; // @[csr.scala 69:26 71:21]
  assign io_readable = 12'hc00 == io_csr_address | 12'hc01 == io_csr_address | _GEN_29; // @[csr.scala 69:26 72:16]
  assign io_writeable = 12'hc00 == io_csr_address | 12'hc01 == io_csr_address ? 1'h0 : _GEN_30; // @[csr.scala 69:26 73:17]
  assign io_eip = ie & meie & io_meip; // @[csr.scala 58:24]
  assign io_tip = ie & mtie & mtip; // @[csr.scala 59:24]
  assign io_sip = ie & msie & msip; // @[csr.scala 60:24]
  assign io_trap_vector = mtvec; // @[csr.scala 62:18]
  assign io_mret_vector = mepc; // @[csr.scala 63:18]
  always @(posedge clock) begin
    if (reset) begin // @[csr.scala 41:23]
      mcycle <= 64'h0; // @[csr.scala 41:23]
    end else if (io_csr_write_enable) begin // @[csr.scala 167:29]
      if (12'h300 == io_csr_write_address) begin // @[csr.scala 168:34]
        mcycle <= _mcycle_T_1; // @[csr.scala 161:10]
      end else if (12'h344 == io_csr_write_address) begin // @[csr.scala 168:34]
        mcycle <= _mcycle_T_1; // @[csr.scala 161:10]
      end else begin
        mcycle <= _GEN_83;
      end
    end else begin
      mcycle <= _mcycle_T_1; // @[csr.scala 161:10]
    end
    if (reset) begin // @[csr.scala 42:25]
      minstret <= 64'h0; // @[csr.scala 42:25]
    end else if (io_csr_write_enable) begin // @[csr.scala 167:29]
      if (12'h300 == io_csr_write_address) begin // @[csr.scala 168:34]
        minstret <= _GEN_41;
      end else if (12'h344 == io_csr_write_address) begin // @[csr.scala 168:34]
        minstret <= _GEN_41;
      end else begin
        minstret <= _GEN_84;
      end
    end else begin
      minstret <= _GEN_41;
    end
    if (reset) begin // @[csr.scala 44:21]
      mepc <= 32'h0; // @[csr.scala 44:21]
    end else if (io_csr_write_enable) begin // @[csr.scala 167:29]
      if (12'h300 == io_csr_write_address) begin // @[csr.scala 168:34]
        mepc <= _GEN_38;
      end else if (12'h344 == io_csr_write_address) begin // @[csr.scala 168:34]
        mepc <= _GEN_38;
      end else begin
        mepc <= _GEN_79;
      end
    end else begin
      mepc <= _GEN_38;
    end
    if (reset) begin // @[csr.scala 45:25]
      mscratch <= 32'h0; // @[csr.scala 45:25]
    end else if (io_csr_write_enable) begin // @[csr.scala 167:29]
      if (!(12'h300 == io_csr_write_address)) begin // @[csr.scala 168:34]
        if (!(12'h344 == io_csr_write_address)) begin // @[csr.scala 168:34]
          mscratch <= _GEN_78;
        end
      end
    end
    if (reset) begin // @[csr.scala 46:22]
      mtvec <= 32'h0; // @[csr.scala 46:22]
    end else if (io_csr_write_enable) begin // @[csr.scala 167:29]
      if (!(12'h300 == io_csr_write_address)) begin // @[csr.scala 168:34]
        if (!(12'h344 == io_csr_write_address)) begin // @[csr.scala 168:34]
          mtvec <= _GEN_77;
        end
      end
    end
    if (reset) begin // @[csr.scala 47:23]
      mcause <= 4'h0; // @[csr.scala 47:23]
    end else if (io_csr_write_enable) begin // @[csr.scala 167:29]
      if (12'h300 == io_csr_write_address) begin // @[csr.scala 168:34]
        mcause <= _GEN_40;
      end else if (12'h344 == io_csr_write_address) begin // @[csr.scala 168:34]
        mcause <= _GEN_40;
      end else begin
        mcause <= _GEN_81;
      end
    end else begin
      mcause <= _GEN_40;
    end
    if (reset) begin // @[csr.scala 48:27]
      minterrupt <= 1'h0; // @[csr.scala 48:27]
    end else if (io_csr_write_enable) begin // @[csr.scala 167:29]
      if (12'h300 == io_csr_write_address) begin // @[csr.scala 168:34]
        minterrupt <= _GEN_39;
      end else if (12'h344 == io_csr_write_address) begin // @[csr.scala 168:34]
        minterrupt <= _GEN_39;
      end else begin
        minterrupt <= _GEN_80;
      end
    end else begin
      minterrupt <= _GEN_39;
    end
    if (reset) begin // @[csr.scala 50:20]
      pie <= 1'h0; // @[csr.scala 50:20]
    end else if (io_csr_write_enable) begin // @[csr.scala 167:29]
      if (12'h300 == io_csr_write_address) begin // @[csr.scala 168:34]
        pie <= io_csr_write_data[7]; // @[csr.scala 171:13]
      end else begin
        pie <= _GEN_36;
      end
    end else begin
      pie <= _GEN_36;
    end
    if (reset) begin // @[csr.scala 51:19]
      ie <= 1'h0; // @[csr.scala 51:19]
    end else if (io_csr_write_enable) begin // @[csr.scala 167:29]
      if (12'h300 == io_csr_write_address) begin // @[csr.scala 168:34]
        ie <= io_csr_write_data[3]; // @[csr.scala 170:12]
      end else begin
        ie <= _GEN_37;
      end
    end else begin
      ie <= _GEN_37;
    end
    if (reset) begin // @[csr.scala 52:21]
      meie <= 1'h0; // @[csr.scala 52:21]
    end else if (io_csr_write_enable) begin // @[csr.scala 167:29]
      if (!(12'h300 == io_csr_write_address)) begin // @[csr.scala 168:34]
        if (!(12'h344 == io_csr_write_address)) begin // @[csr.scala 168:34]
          meie <= _GEN_76;
        end
      end
    end
    if (reset) begin // @[csr.scala 53:21]
      msie <= 1'h0; // @[csr.scala 53:21]
    end else if (io_csr_write_enable) begin // @[csr.scala 167:29]
      if (!(12'h300 == io_csr_write_address)) begin // @[csr.scala 168:34]
        if (!(12'h344 == io_csr_write_address)) begin // @[csr.scala 168:34]
          msie <= _GEN_74;
        end
      end
    end
    if (reset) begin // @[csr.scala 54:21]
      msip <= 1'h0; // @[csr.scala 54:21]
    end else if (io_csr_write_enable) begin // @[csr.scala 167:29]
      if (!(12'h300 == io_csr_write_address)) begin // @[csr.scala 168:34]
        if (12'h344 == io_csr_write_address) begin // @[csr.scala 168:34]
          msip <= io_csr_write_data[3]; // @[csr.scala 174:14]
        end
      end
    end
    if (reset) begin // @[csr.scala 55:21]
      mtie <= 1'h0; // @[csr.scala 55:21]
    end else if (io_csr_write_enable) begin // @[csr.scala 167:29]
      if (!(12'h300 == io_csr_write_address)) begin // @[csr.scala 168:34]
        if (!(12'h344 == io_csr_write_address)) begin // @[csr.scala 168:34]
          mtie <= _GEN_75;
        end
      end
    end
    if (reset) begin // @[csr.scala 56:21]
      mtip <= 1'h0; // @[csr.scala 56:21]
    end else begin
      mtip <= mcycle >= 64'h7fffffff; // @[csr.scala 205:8]
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
  _RAND_0 = {2{`RANDOM}};
  mcycle = _RAND_0[63:0];
  _RAND_1 = {2{`RANDOM}};
  minstret = _RAND_1[63:0];
  _RAND_2 = {1{`RANDOM}};
  mepc = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  mscratch = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  mtvec = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  mcause = _RAND_5[3:0];
  _RAND_6 = {1{`RANDOM}};
  minterrupt = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  pie = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  ie = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  meie = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  msie = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  msip = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  mtie = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  mtip = _RAND_13[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
