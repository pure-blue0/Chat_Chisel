module CSR(
  input         clock,
  input         reset,
  input         io_meip,
  input  [11:0] io_csr_address,
  output [31:0] io_csr_read_data,
  output        io_readable,
  output        io_writeable,
  input         io_csr_write_enable,
  input         io_csr_write_address,
  input  [31:0] io_csr_write_data,
  input         io_inst_retired,
  input         io_trapped,
  input         io_interrupt,
  input         io_mret,
  input  [3:0]  io_ecause,
  output        io_sip,
  output        io_tip,
  output        io_eip,
  output [31:0] io_trap_vector,
  output [31:0] io_mret_vector
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
`endif // RANDOMIZE_REG_INIT
  reg [31:0] cycle; // @[csr.scala 33:22]
  reg [31:0] instret; // @[csr.scala 35:24]
  reg [31:0] mstatus; // @[csr.scala 42:24]
  reg [31:0] misa; // @[csr.scala 43:21]
  reg [31:0] mip; // @[csr.scala 44:20]
  reg [31:0] mie; // @[csr.scala 45:20]
  reg [31:0] mtvec; // @[csr.scala 46:22]
  reg [31:0] mscratch; // @[csr.scala 47:25]
  reg [31:0] mepc; // @[csr.scala 48:21]
  reg [31:0] mcause; // @[csr.scala 49:23]
  reg [31:0] mtval; // @[csr.scala 50:22]
  wire  _T = io_csr_address == 12'h780; // @[csr.scala 56:23]
  wire [31:0] _GEN_0 = io_csr_write_enable ? io_csr_write_data : mstatus; // @[csr.scala 57:31 58:15 42:24]
  wire  _T_1 = io_csr_address == 12'h301; // @[csr.scala 61:29]
  wire  _T_2 = io_csr_address == 12'h344; // @[csr.scala 66:29]
  wire [31:0] _GEN_2 = io_csr_write_enable ? io_csr_write_data : mip; // @[csr.scala 67:31 68:11 44:20]
  wire  _T_3 = io_csr_address == 12'h304; // @[csr.scala 71:29]
  wire [31:0] _GEN_3 = io_csr_write_enable ? io_csr_write_data : mie; // @[csr.scala 72:31 73:11 45:20]
  wire  _T_4 = io_csr_address == 12'h305; // @[csr.scala 76:29]
  wire [31:0] _GEN_4 = io_csr_write_enable ? io_csr_write_data : mtvec; // @[csr.scala 77:31 78:13 46:22]
  wire  _T_5 = io_csr_address == 12'h340; // @[csr.scala 81:29]
  wire [31:0] _GEN_5 = io_csr_write_enable ? io_csr_write_data : mscratch; // @[csr.scala 82:31 83:16 47:25]
  wire  _T_6 = io_csr_address == 12'h341; // @[csr.scala 86:29]
  wire [31:0] _GEN_6 = io_csr_write_enable ? io_csr_write_data : mepc; // @[csr.scala 87:31 88:12 48:21]
  wire  _T_7 = io_csr_address == 12'h342; // @[csr.scala 91:29]
  wire [31:0] _GEN_7 = io_csr_write_enable ? io_csr_write_data : mcause; // @[csr.scala 92:31 93:14 49:23]
  wire  _T_8 = io_csr_address == 12'h343; // @[csr.scala 96:29]
  wire [31:0] _GEN_8 = io_csr_write_enable ? io_csr_write_data : mtval; // @[csr.scala 97:31 98:13 50:22]
  wire  _T_9 = io_csr_address == 12'hb00; // @[csr.scala 101:29]
  wire  _T_10 = io_csr_address == 12'hc00; // @[csr.scala 103:27]
  wire  _T_11 = io_csr_address == 12'hb02; // @[csr.scala 105:29]
  wire  _T_12 = io_csr_address == 12'hc02; // @[csr.scala 107:29]
  wire  _T_13 = io_csr_address == 12'h100; // @[csr.scala 109:29]
  wire  _T_14 = io_csr_address == 12'hc01; // @[csr.scala 111:29]
  wire  _T_15 = io_csr_address == 12'hf11; // @[csr.scala 113:29]
  wire  _T_16 = io_csr_address == 12'hf12; // @[csr.scala 115:29]
  wire  _T_17 = io_csr_address == 12'hf13; // @[csr.scala 117:29]
  wire  _T_18 = io_csr_address == 12'hf14; // @[csr.scala 119:29]
  wire [31:0] _GEN_14 = io_csr_address == 12'h100 ? cycle : 32'h0; // @[csr.scala 109:43 110:22]
  wire [31:0] _GEN_15 = io_csr_address == 12'hc02 ? instret : _GEN_14; // @[csr.scala 107:43 108:22]
  wire [31:0] _GEN_16 = io_csr_address == 12'hb02 ? 32'h0 : _GEN_15; // @[csr.scala 105:43 106:22]
  wire [31:0] _GEN_17 = io_csr_address == 12'hc00 ? 32'h0 : _GEN_16; // @[csr.scala 103:41 104:22]
  wire [31:0] _GEN_18 = io_csr_address == 12'hb00 ? 32'h0 : _GEN_17; // @[csr.scala 101:43 102:22]
  wire [31:0] _GEN_19 = io_csr_address == 12'h343 ? _GEN_8 : mtval; // @[csr.scala 50:22 96:43]
  wire [31:0] _GEN_20 = io_csr_address == 12'h343 ? mtval : _GEN_18; // @[csr.scala 100:22 96:43]
  wire [31:0] _GEN_21 = io_csr_address == 12'h342 ? _GEN_7 : mcause; // @[csr.scala 49:23 91:43]
  wire [31:0] _GEN_22 = io_csr_address == 12'h342 ? mcause : _GEN_20; // @[csr.scala 91:43 95:22]
  wire [31:0] _GEN_23 = io_csr_address == 12'h342 ? mtval : _GEN_19; // @[csr.scala 50:22 91:43]
  wire [31:0] _GEN_24 = io_csr_address == 12'h341 ? _GEN_6 : mepc; // @[csr.scala 48:21 86:43]
  wire [31:0] _GEN_25 = io_csr_address == 12'h341 ? mepc : _GEN_22; // @[csr.scala 86:43 90:22]
  wire [31:0] _GEN_26 = io_csr_address == 12'h341 ? mcause : _GEN_21; // @[csr.scala 49:23 86:43]
  wire [31:0] _GEN_27 = io_csr_address == 12'h341 ? mtval : _GEN_23; // @[csr.scala 50:22 86:43]
  wire [31:0] _GEN_28 = io_csr_address == 12'h340 ? _GEN_5 : mscratch; // @[csr.scala 47:25 81:43]
  wire [31:0] _GEN_29 = io_csr_address == 12'h340 ? mscratch : _GEN_25; // @[csr.scala 81:43 85:22]
  wire [31:0] _GEN_30 = io_csr_address == 12'h340 ? mepc : _GEN_24; // @[csr.scala 48:21 81:43]
  wire [31:0] _GEN_31 = io_csr_address == 12'h340 ? mcause : _GEN_26; // @[csr.scala 49:23 81:43]
  wire [31:0] _GEN_32 = io_csr_address == 12'h340 ? mtval : _GEN_27; // @[csr.scala 50:22 81:43]
  wire [31:0] _GEN_33 = io_csr_address == 12'h305 ? _GEN_4 : mtvec; // @[csr.scala 46:22 76:43]
  wire [31:0] _GEN_34 = io_csr_address == 12'h305 ? mtvec : _GEN_29; // @[csr.scala 76:43 80:22]
  wire [31:0] _GEN_35 = io_csr_address == 12'h305 ? mscratch : _GEN_28; // @[csr.scala 47:25 76:43]
  wire [31:0] _GEN_36 = io_csr_address == 12'h305 ? mepc : _GEN_30; // @[csr.scala 48:21 76:43]
  wire [31:0] _GEN_37 = io_csr_address == 12'h305 ? mcause : _GEN_31; // @[csr.scala 49:23 76:43]
  wire [31:0] _GEN_38 = io_csr_address == 12'h305 ? mtval : _GEN_32; // @[csr.scala 50:22 76:43]
  wire [31:0] _GEN_39 = io_csr_address == 12'h304 ? _GEN_3 : mie; // @[csr.scala 45:20 71:43]
  wire [31:0] _GEN_40 = io_csr_address == 12'h304 ? mie : _GEN_34; // @[csr.scala 71:43 75:22]
  wire [31:0] _GEN_41 = io_csr_address == 12'h304 ? mtvec : _GEN_33; // @[csr.scala 46:22 71:43]
  wire [31:0] _GEN_42 = io_csr_address == 12'h304 ? mscratch : _GEN_35; // @[csr.scala 47:25 71:43]
  wire [31:0] _GEN_43 = io_csr_address == 12'h304 ? mepc : _GEN_36; // @[csr.scala 48:21 71:43]
  wire [31:0] _GEN_44 = io_csr_address == 12'h304 ? mcause : _GEN_37; // @[csr.scala 49:23 71:43]
  wire [31:0] _GEN_45 = io_csr_address == 12'h304 ? mtval : _GEN_38; // @[csr.scala 50:22 71:43]
  wire [31:0] _GEN_47 = io_csr_address == 12'h344 ? mip : _GEN_40; // @[csr.scala 66:43 70:22]
  wire [31:0] _GEN_50 = io_csr_address == 12'h344 ? mscratch : _GEN_42; // @[csr.scala 47:25 66:43]
  wire [31:0] _GEN_51 = io_csr_address == 12'h344 ? mepc : _GEN_43; // @[csr.scala 48:21 66:43]
  wire [31:0] _GEN_55 = io_csr_address == 12'h301 ? misa : _GEN_47; // @[csr.scala 61:43 65:22]
  wire [31:0] _GEN_60 = io_csr_address == 12'h301 ? mepc : _GEN_51; // @[csr.scala 48:21 61:43]
  wire [31:0] _GEN_63 = io_csr_address == 12'h780 ? _GEN_0 : mstatus; // @[csr.scala 42:24 56:37]
  wire  _io_readable_T_8 = _T_9 | _T_10 | _T_11 | _T_12 | _T_13; // @[csr.scala 126:140]
  wire  _io_readable_T_16 = _io_readable_T_8 | _T_14 | _T_15 | _T_16 | _T_17; // @[csr.scala 127:126]
  wire  _io_writeable_T_6 = _T | _T_1 | _T_2 | _T_3; // @[csr.scala 129:110]
  wire  _io_writeable_T_14 = _io_writeable_T_6 | _T_4 | _T_5 | _T_6 | _T_7; // @[csr.scala 130:126]
  wire [32:0] _mstatus_T_1 = {mstatus[31:3],io_ecause}; // @[Cat.scala 31:58]
  wire [31:0] _mstatus_T_8 = mstatus & 32'h7f; // @[csr.scala 141:24]
  wire [31:0] _GEN_73 = io_mret ? _mstatus_T_8 : _GEN_63; // @[csr.scala 138:23 141:13]
  wire [32:0] _GEN_75 = io_trapped ? _mstatus_T_1 : {{1'd0}, _GEN_73}; // @[csr.scala 134:20 135:13]
  wire [31:0] _cycle_T_1 = cycle + 32'h1; // @[csr.scala 147:20]
  wire [31:0] _instret_T_1 = instret + 32'h1; // @[csr.scala 148:24]
  wire [31:0] _io_sip_T = mip & 32'h1; // @[csr.scala 152:18]
  wire [31:0] _io_tip_T = mip & 32'h2; // @[csr.scala 153:18]
  wire [31:0] _io_eip_T = mip & 32'h4; // @[csr.scala 154:18]
  wire [32:0] _GEN_81 = reset ? 33'h0 : _GEN_75; // @[csr.scala 42:{24,24}]
  assign io_csr_read_data = io_csr_address == 12'h780 ? mstatus : _GEN_55; // @[csr.scala 56:37 60:22]
  assign io_readable = _io_readable_T_16 | _T_18; // @[csr.scala 128:33]
  assign io_writeable = _io_writeable_T_14 | _T_8; // @[csr.scala 131:33]
  assign io_sip = _io_sip_T != 32'h0; // @[csr.scala 152:25]
  assign io_tip = _io_tip_T != 32'h0; // @[csr.scala 153:25]
  assign io_eip = _io_eip_T != 32'h0; // @[csr.scala 154:25]
  assign io_trap_vector = mepc; // @[csr.scala 157:18]
  assign io_mret_vector = mtvec; // @[csr.scala 158:18]
  always @(posedge clock) begin
    if (reset) begin // @[csr.scala 33:22]
      cycle <= 32'h0; // @[csr.scala 33:22]
    end else if (io_inst_retired) begin // @[csr.scala 146:25]
      cycle <= _cycle_T_1; // @[csr.scala 147:11]
    end
    if (reset) begin // @[csr.scala 35:24]
      instret <= 32'h0; // @[csr.scala 35:24]
    end else if (io_inst_retired) begin // @[csr.scala 146:25]
      instret <= _instret_T_1; // @[csr.scala 148:13]
    end
    mstatus <= _GEN_81[31:0]; // @[csr.scala 42:{24,24}]
    if (reset) begin // @[csr.scala 43:21]
      misa <= 32'h0; // @[csr.scala 43:21]
    end else if (!(io_csr_address == 12'h780)) begin // @[csr.scala 56:37]
      if (io_csr_address == 12'h301) begin // @[csr.scala 61:43]
        if (io_csr_write_enable) begin // @[csr.scala 62:31]
          misa <= io_csr_write_data; // @[csr.scala 63:12]
        end
      end
    end
    if (reset) begin // @[csr.scala 44:20]
      mip <= 32'h0; // @[csr.scala 44:20]
    end else if (!(io_csr_address == 12'h780)) begin // @[csr.scala 56:37]
      if (!(io_csr_address == 12'h301)) begin // @[csr.scala 61:43]
        if (io_csr_address == 12'h344) begin // @[csr.scala 66:43]
          mip <= _GEN_2;
        end
      end
    end
    if (reset) begin // @[csr.scala 45:20]
      mie <= 32'h0; // @[csr.scala 45:20]
    end else if (!(io_csr_address == 12'h780)) begin // @[csr.scala 56:37]
      if (!(io_csr_address == 12'h301)) begin // @[csr.scala 61:43]
        if (!(io_csr_address == 12'h344)) begin // @[csr.scala 66:43]
          mie <= _GEN_39;
        end
      end
    end
    if (reset) begin // @[csr.scala 46:22]
      mtvec <= 32'h0; // @[csr.scala 46:22]
    end else if (!(io_csr_address == 12'h780)) begin // @[csr.scala 56:37]
      if (!(io_csr_address == 12'h301)) begin // @[csr.scala 61:43]
        if (!(io_csr_address == 12'h344)) begin // @[csr.scala 66:43]
          mtvec <= _GEN_41;
        end
      end
    end
    if (reset) begin // @[csr.scala 47:25]
      mscratch <= 32'h0; // @[csr.scala 47:25]
    end else if (io_trapped) begin // @[csr.scala 134:20]
      mscratch <= io_csr_read_data; // @[csr.scala 137:14]
    end else if (!(io_csr_address == 12'h780)) begin // @[csr.scala 56:37]
      if (!(io_csr_address == 12'h301)) begin // @[csr.scala 61:43]
        mscratch <= _GEN_50;
      end
    end
    if (reset) begin // @[csr.scala 48:21]
      mepc <= 32'h0; // @[csr.scala 48:21]
    end else if (io_trapped) begin // @[csr.scala 134:20]
      mepc <= io_trap_vector; // @[csr.scala 136:10]
    end else if (io_mret) begin // @[csr.scala 138:23]
      mepc <= mscratch; // @[csr.scala 142:10]
    end else if (!(io_csr_address == 12'h780)) begin // @[csr.scala 56:37]
      mepc <= _GEN_60;
    end
    if (reset) begin // @[csr.scala 49:23]
      mcause <= 32'h0; // @[csr.scala 49:23]
    end else if (!(io_csr_address == 12'h780)) begin // @[csr.scala 56:37]
      if (!(io_csr_address == 12'h301)) begin // @[csr.scala 61:43]
        if (!(io_csr_address == 12'h344)) begin // @[csr.scala 66:43]
          mcause <= _GEN_44;
        end
      end
    end
    if (reset) begin // @[csr.scala 50:22]
      mtval <= 32'h0; // @[csr.scala 50:22]
    end else if (!(io_csr_address == 12'h780)) begin // @[csr.scala 56:37]
      if (!(io_csr_address == 12'h301)) begin // @[csr.scala 61:43]
        if (!(io_csr_address == 12'h344)) begin // @[csr.scala 66:43]
          mtval <= _GEN_45;
        end
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
  cycle = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  instret = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  mstatus = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  misa = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  mip = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  mie = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  mtvec = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  mscratch = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  mepc = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  mcause = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  mtval = _RAND_10[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
