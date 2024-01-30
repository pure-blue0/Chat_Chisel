//未完成，修改中。。。
module Exception_Handler_Module (
  // Module inputs
  input wire clk,                               // Clock signal.
  input wire rst,                               // Reset signal.
  input wire ecall_exception,                   // Signal indicating an environment call exception.
  input wire ebreak_exception,                  // Signal indicating an environment breakpoint exception.
  input wire irq_external,                      // Signal indicating an external interrupt request.
  input wire irq_timer,                         // Signal indicating a timer interrupt request.
  input wire exception_valid,                   // Signal indicating the validity of an exception or interrupt.

  input wire [31:0] exception_pc,               // Signal indicating the program counter at the time of the exception.
  input wire [31:0] mtvec,                      // Machine trap vector CSR value.
  input wire [31:0] ecall_pc,                   // Program counter value corresponding to an environment call instruction.
  input wire [31:0] ebreak_pc,                  // Program counter value corresponding to an environment breakpoint instruction.

  // CSR inputs
  input wire [2:0] mstatus_mie,                 // MIE bit from the mstatus CSR.
  input wire [2:0] mstatus_mpie,                // MPIE bit from the mstatus CSR.
  input wire [11:0] mcause,                     // Value of the mcause CSR.
  input wire [11:0] mepc,                       // Value of the mepc CSR.
  input wire [11:0] mtval,                      // Value of the mtval CSR.

  // CSR outputs
  output reg mstatus_mie_out,                   // Output indicating the MIE bit for updating the mstatus CSR.
  output reg mstatus_mpie_out,                  // Output indicating the MPIE bit for updating the mstatus CSR.
  output reg [2:0] exception_code_out,          // Output indicating the exception code for updating the mcause CSR.
  output reg exception_acknowledge_out,         // Output indicating acknowledgment of the exception.
  output reg mtvec_write_enable_out,            // Output indicating whether to enable writing to mtvec.
  output reg [31:0] mtvec_write_data_out,       // Output providing data to be written to mtvec.

  input wire [5:0] opcode,
  input wire [6:0] funct3,
  input wire [6:0] funct7,
  input wire [31:0] pc,
  output wire exception_ecall,
  output wire exception_ebreak,
  output wire exception_mret
);
  // ... (additional signals as needed)

 // Internal signals
  reg [31:0] new_mtvec;

  assign exception_ecall = (opcode == 6'b111001 && funct3 == 3'b000 && funct7 == 7'b0000000);
  assign exception_ebreak = (opcode == 7'b0000000 && funct3 == 3'b000 && funct7 == 7'b0000000);
  assign exception_mret = (opcode == 7'b1110011 && funct3 == 3'b000 && funct7 == 7'b0000001);

  // Module implementation
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      // Reset values
      mstatus_mie_out <= 1'b0;
      mstatus_mpie_out <= 1'b0;
      exception_code_out <= 3'b0;
      exception_acknowledge_out <= 1'b0;
      mtvec_write_enable_out <= 1'b0;
      mtvec_write_data_out <= 32'h0;
      new_mtvec <= 32'h0;
    end else begin
    // Update MIE and MPIE based on external interrupts
      if (irq_external) begin
        mstatus_mie_out <= mstatus_mie;
        mstatus_mpie_out <= mstatus_mie;
      end else begin
        mstatus_mie_out <= 1'b0;
        mstatus_mpie_out <= mstatus_mie;
      end
    
      // Exception handling logic
      if (exception_valid) begin
        // Check for specific exceptions
        case (exception_code_out)
          3'b000: ; // Instruction address misaligned (not shown in this example)
          3'b001: ; // Instruction access fault (not shown in this example)
          3'b010: ; // Illegal instruction (not shown in this example)
          3'b011: ; // Breakpoint exception
            // Handle EBREAK instruction
            exception_ebreak <= 1'b1;
            // Set the new mtvec value for exception return
            mtvec_write_enable_out <= 1'b1;
            mtvec_write_data_out <= ebreak_pc;
          3'b100: ; // Load address misaligned (not shown in this example)
          3'b101: ; // Load access fault (not shown in this example)
          3'b110: ; // Store/AMO address misaligned (not shown in this example)
          3'b111: ; // Store/AMO access fault (not shown in this example)
          default: ; // Handle other exceptions
        endcase

        // Acknowledge the exception
        exception_acknowledge_out <= 1'b1;

        // Handle ECALL instruction
  if (exception_ecall) begin
    // Additional logic for ECALL
    case (mcause)
      12'h000: ; // ECALL from U-mode
        // Handle ECALL from U-mode
        // ...
     
      12'h002: ; // ECALL from M-mode
        // Handle ECALL from M-mode
        // Set mepc to the address of the next instruction
        mepc <= exception_pc + 4'b1000;
        // ...

      // Additional cases for different privilege modes and ECALL arguments
      // ...

      default: ; // Handle other ECALL scenarios
    endcase
  end

  // Handle MRET instruction
  if (exception_mret) begin
    // Additional logic for MRET
    case (mcause)
      12'h308: ; // MRET from U-mode
        // Handle MRET from U-mode
        // ...
    
      12'h302: ; // MRET from M-mode
        // Handle MRET from M-mode
        // Restore the program counter from mepc
        exception_pc <= mepc;
        // ...

      // Additional cases for different privilege modes
      // ...

      default: ; // Handle other MRET scenarios
    endcase
  end


        // Update CSR values based on the exception
        if (exception_code_out == 3'b011) begin
          // If it's a breakpoint exception, update mepc and mtvec
          mepc <= exception_pc;
          mtvec_write_enable_out <= 1'b1;
          mtvec_write_data_out <= new_mtvec;
        end

        // Additional logic for updating other CSR values based on exceptions

      end else begin
        // No exception, reset acknowledge signal
        exception_acknowledge_out <= 1'b0;
      end

      
    end
  end

  // ... (implementation details will follow)

endmodule
