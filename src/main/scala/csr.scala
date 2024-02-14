import chisel3._
import chisel3.util._

class CSR extends Module {
  val io = IO(new Bundle {
    // from interrupt controller
    val meip = Input(Bool())

    // from decode (read port)
    val csr_address = Input(UInt(12.W))

    //from execute
    val mem_pc = Input(UInt(32.W))
    
    // to execute (read port)
    val csr_read_data = Output(UInt(32.W))
    val readable = Output(Bool())
    val writeable = Output(Bool())

    // from memory (write port)
    val csr_write_enable = Input(Bool())
    val csr_write_address = Input(UInt(12.W))
    val csr_write_data = Input(UInt(32.W))

    val inst_retired = Input(Bool())
    val trapped = Input(Bool())
    val mret = Input(Bool())
    val ecause = Input(UInt(3.W))
    val interrupt = Input(Bool())

    // to memory
    val eip = Output(Bool())
    val tip = Output(Bool())
    val sip = Output(Bool())

    // to fetch
    val trap_vector = Output(UInt(32.W))
    val mret_vector = Output(UInt(32.W))
   })

  val mcycle = RegInit(0.U(64.W))
  val minstret = RegInit(0.U(64.W))
  val mtval = RegInit(0.U(32.W))
  val mepc = RegInit(0.U(32.W))
  val mscratch = RegInit(0.U(32.W))
  val mtvec = RegInit(0.U(32.W))
  val mcause = RegInit(0.U(4.W))
  val minterrupt = RegInit(false.B)

  val pie = RegInit(false.B)
  val ie = RegInit(false.B)
  val meie = RegInit(false.B)
  val msie = RegInit(false.B)
  val msip = RegInit(false.B)
  val mtie = RegInit(false.B)
  val mtip = RegInit(false.B)

  io.eip := ie && meie && io.meip
  io.tip := ie && mtie && mtip
  io.sip := ie && msie && msip

  io.trap_vector := mtvec
  io.mret_vector := mepc

  val csr_read_data = WireInit(0.U(32.W))
  val readable = WireInit(false.B)
  val writeable = WireInit(false.B)

  switch(io.csr_address) {
    is(0xc00.U,0xc01.U) {
      csr_read_data := mcycle(31, 0)
      readable := true.B
      writeable := false.B
    }
    is(0xc02.U) {
      csr_read_data := minstret(31, 0)
      readable := true.B
      writeable := false.B
    }  
    is(0xc82.U) {
      csr_read_data := minstret(63, 32)
      readable := true.B
      writeable := false.B
    }
    is(0xf11.U, 0xf12.U, 0xf13.U, 0xf14.U) {
      csr_read_data := 0.U
      readable := true.B
      writeable := false.B
    }
    is(0x300.U) {
      csr_read_data := Cat(0.U(1.W), 0.U(8.W), 0.U(1.W), 0.U(1.W), 0.U(1.W), 0.U(1.W), 0.U(1.W), 0.U(1.W), 0.U(2.W), 0.U(2.W), 0.U(2.W), 0.U(2.W), 0.U(1.W), pie, 0.U(1.W), 0.U(1.W), 0.U(1.W), ie, 0.U(1.W), 0.U(1.W), 0.U(1.W))
      readable := true.B
      writeable := true.B
    }
    is(0x301.U) {
      csr_read_data := Cat(1.U(2.W), 0.U(4.W), "b00000000000000000100000000".U(26.W))
      readable := true.B
      writeable := true.B
    }
    is(0x344.U) {
      csr_read_data := Cat(0.U(20.W), io.meip, 0.U(1.W), 0.U(1.W), 0.U(1.W), mtip, 0.U(1.W), 0.U(1.W), 0.U(1.W), msip, 0.U(1.W), 0.U(1.W), 0.U(1.W))
      readable := true.B
      writeable := true.B
    }
    is(0x304.U) {
      csr_read_data := Cat(0.U(20.W), meie, 0.U(1.W), 0.U(1.W), 0.U(1.W), mtie, 0.U(1.W), 0.U(1.W), 0.U(1.W), msie, 0.U(1.W), 0.U(1.W), 0.U(1.W))
      readable := true.B
      writeable := true.B
    }
    is(0x305.U) {
      csr_read_data := Cat(mtvec(31, 2), 0.U(2.W))
      readable := true.B
      writeable := true.B
    }
    is(0x340.U) {
      csr_read_data := mscratch
      readable := true.B
      writeable := true.B
    }
    is(0x341.U) {
      csr_read_data := mepc
      readable := true.B
      writeable := true.B
    }
    is(0x342.U) {
      csr_read_data := Cat(minterrupt, 0.U(27.W), mcause)
      readable := true.B
      writeable := true.B
    }
    is(0x343.U) {
      csr_read_data := 0.U
      readable := true.B
      writeable := true.B
    }
    is(0xb00.U, 0xb01.U) {
      csr_read_data := mcycle(31, 0)
      readable := true.B
      writeable := true.B
    }
    is(0xb02.U) {
      csr_read_data := minstret(31, 0)
      readable := true.B
      writeable := true.B
    }
  }
    io.csr_read_data := csr_read_data
    io.readable := readable
    io.writeable := writeable

  when(io.trapped) {
    pie := ie
    ie := false.B
    mepc := io.mem_pc
    minterrupt := io.interrupt
    mcause := io.ecause
  } .elsewhen(io.mret) {
    ie := pie
    pie := true.B
  }

  mcycle := mcycle + 1.U
  when(io.inst_retired) {
    minstret := minstret + 1.U
  }
  

  when(io.csr_write_enable) {
    switch(io.csr_write_address) {
      is(0x300.U) {
        ie := io.csr_write_data(3)
        pie := io.csr_write_data(7)
      }
      is(0x344.U) {
        msip := io.csr_write_data(3)
      }
      is(0x304.U) {
        msie := io.csr_write_data(3)
        mtie := io.csr_write_data(7)
        meie := io.csr_write_data(11)
      }
      is(0x305.U) {
        mtvec := Cat(io.csr_write_data(31, 2), 0.U(2.W))
      }
      is(0x340.U) {
        mscratch := io.csr_write_data
      }
      is(0x341.U) {
        mepc := io.csr_write_data
      }
      is(0x342.U) {
        minterrupt := io.csr_write_data(31)
        mcause := io.csr_write_data(3, 0)
      }
      is(0x343.U) {
        mtval := io.csr_write_data
      }
      is(0xb00.U, 0xb01.U) {
        mcycle := Cat(0.U(32.W),io.csr_write_data) | mcycle
      }
      is(0xb02.U) {
        minstret := Cat(0.U(32.W),io.csr_write_data) | minstret
      }
    }
  }
  mtip := mcycle >= 0x7fffffff.U
}
