import chisel3._
import chisel3.util._


class Control extends Module {
  val io = IO(new Bundle {
    val opcode = Input(UInt(7.W))
    val funct7 = Input(UInt(7.W))
    val funct3 = Input(UInt(3.W))
    val aluop = Output(UInt(4.W))
    val immsrc = Output(UInt(1.W))
    val isbranch = Output(UInt(1.W))
    val memread = Output(UInt(1.W))
    val memwrite = Output(UInt(1.W))
    val regwrite = Output(UInt(1.W))
    val memtoreg = Output(UInt(2.W))
    val pcsel = Output(UInt(1.W))
    val rdsel = Output(UInt(1.W))
    val isjump = Output(UInt(1.W))
    val islui = Output(UInt(1.W))
  })

  val default = WireDefault(0.U) // Default value for unused control signals

  io.aluop := default // Set default value for aluop
  io.immsrc := default // Set default value for immsrc
  io.isbranch := default // Set default value for isbranch
  io.memread := default // Set default value for memread
  io.memwrite := default // Set default value for memwrite
  io.regwrite := default // Set default value for regwrite
  io.memtoreg := default // Set default value for memtoreg
  io.pcsel := default // Set default value for pcsel
  io.rdsel := default // Set default value for rdsel
  io.isjump := default // Set default value for isjump
  io.islui := default // Set default value for islui

  // Control signal generation logic goes here
  io.aluop := MuxLookup(io.opcode, "b0000".U(4.W), 
    Array(
      "b0110011".U -> MuxLookup(io.funct3, "b0000".U, 
        Array(
          "b000".U -> MuxLookup(io.funct7, "b0000".U, 
            Array(
              "b0000000".U -> "b0000".U,
              "b0100000".U -> "b0001".U,
              "b0000100".U -> "b0010".U
            )
          ),
          "b110".U -> "b0011".U,
          "b111".U -> "b0100".U,
          "b001".U -> "b0101".U,
          "b101".U -> MuxLookup(io.funct7, "b0110".U, 
            Array(
              "b0000000".U -> "b0110".U,
              "b0100000".U -> "b0111".U
            )
          ),
          "b010".U -> "b1000".U,
          "b011".U -> "b1001".U
        )
      ),
      "b0010011".U -> MuxLookup(io.funct3, "b0000".U, 
        Array(
          "b000".U -> "b0000".U,
          "b100".U -> "b0010".U,
          "b110".U -> "b0011".U,
          "b111".U -> "b0100".U,
          "b001".U -> "b0101".U,
          "b101".U -> MuxLookup(io.funct7, "b0110".U, 
            Array(
              "b0000000".U -> "b0110".U,
              "b0100000".U -> "b0111".U
            )
          ),
          "b010".U -> "b1000".U,
          "b011".U -> "b1001".U
        )
      ),
      "b0000011".U -> "b0000".U,
      "b0100011".U -> "b0000".U,
      "b1100011".U -> MuxLookup(io.funct3, "b1000".U, 
        Array(
          "b000".U -> "b1000".U,
          "b001".U -> "b1000".U,
          "b100".U -> "b1000".U,
          "b101".U -> "b1000".U,
          "b110".U -> "b1001".U,
          "b111".U -> "b1001".U
        )
      ),
      "b1101111".U -> "b0000".U,
      "b1100111".U -> "b0000".U,
      "b0110111".U -> "b0000".U,
      "b0010111".U -> "b0000".U
    )
  )


  io.immsrc := MuxLookup(io.opcode, 0.U, Array(
    "b0110011".U -> 0.U,
    "b0010011".U -> 1.U,
    "b0000011".U -> 1.U,
    "b0100011".U -> 1.U,
    "b1100011".U -> 0.U,
    "b1101111".U -> 1.U,
    "b1100111".U -> 1.U,
    "b0110111".U -> 1.U,
    "b0010111".U -> 1.U
  ))

  io.isbranch := MuxLookup(io.opcode, 0.U, Array(
    "b1100011".U -> 1.U
  ))

  io.memread := MuxLookup(io.opcode, 0.U, Array(
    "b0000011".U -> 1.U
  ))

  io.memwrite := MuxLookup(io.opcode, 0.U, Array(
    "b0100011".U -> 1.U
  ))

  io.regwrite := MuxLookup(io.opcode, 0.U, Array(
    "b0110011".U -> 1.U,
    "b0010011".U -> 1.U,
    "b0000011".U -> 1.U,
    "b0100011".U -> 0.U,
    "b1100011".U -> 0.U,
    "b1101111".U -> 1.U,
    "b1100111".U -> 1.U,
    "b0110111".U -> 1.U,
    "b0010111".U -> 1.U
  ))

  io.memtoreg := MuxLookup(io.opcode, 0.U, Array(
    "b0110011".U -> "b10".U,
    "b0010011".U -> "b10".U,
    "b0000011".U -> "b01".U,
    "b1101111".U -> "b00".U,
    "b0110111".U -> "b10".U
  ))

  io.pcsel := MuxLookup(io.opcode, 0.U, Array(
    "b1101111".U -> 0.U,
    "b1100111".U -> 1.U
  ))

  io.rdsel := MuxLookup(io.opcode, 0.U, Array(
    "b0010111".U -> 1.U
  ))

  io.isjump := MuxLookup(io.opcode, 0.U, Array(
    "b1101111".U -> 1.U,
    "b1100111".U -> 1.U
  ))

  io.islui := MuxLookup(io.opcode, 0.U, Array(
    "b0110111".U -> 1.U
  ))

}



