//未完成，修改中。。。
module CSR_Module (
  // Clock and reset signals
  input wire clk,
  input wire rst,

  // Control Module Inputs
  input wire start_execution,
  input wire [31:0] instruction,
  input wire [31:0] pc,
  input wire branch_taken,
  input wire csr_instruction,
  input wire [31:0] csr_read_data,
  input wire [31:0] csr_write_data,
  input wire reset,

  // Execution Unit Inputs
  input wire [31:0] alu_result,
  input wire [31:0] mem_data,
  input wire branch_taken,

  // Memory Stage Inputs
  input wire mem_ready,
  input wire [31:0] mem_addr,
  input wire [31:0] mem_write_data,
  input wire mem_read,
  input wire mem_write,
  input wire mem_exception,
  input wire [31:0] mem_writeback_data,

  // Write-Back Inputs
  input wire [31:0] writeback_data,
  input wire [4:0] writeback_reg,
  input wire writeback_valid,
  input wire writeback_ready,
  input wire writeback_exception,
  input wire [31:0] external_interrupt,

  // Control Module Outputs
  output wire [31:0] next_pc,
  output wire branch_taken_out,
  output wire flush,
  output wire exception,
  output wire [31:0] exception_code,

  // Memory Stage Outputs
  output wire mem_ready_out,
  output wire [31:0] mem_data_out,
  output wire mem_exception_out,

  // Write-Back Outputs
  output wire writeback_ready_out,
  output wire writeback_exception_out,
  output wire [31:0] writeback_cause,

  // External Interrupt Acknowledge
  output wire external_interrupt_ack
);

  // Module implementation will go here

  // Internal registers
  reg [31:0] mstatus;
  reg [31:0] mcause;
  reg [31:0] mepc;
  reg [31:0] mip;
  reg [31:0] mie;
  reg [31:0] mtvec;
  reg [31:0] mhartid;
  reg [31:0] mscratch;
  reg [31:0] mideleg;
  reg [31:0] medeleg;
  reg [31:0] mcounteren;
  reg [31:0] mcounter;
  reg [31:0] misa;
  reg [31:0] mvendorid;
  reg [31:0] marchid;
  reg [31:0] mimpid;

  // Internal signals
  reg [31:0] csr_data_out;

  // Input signals from control module
  input wire [2:0] control_op;         // Control operation code
  input wire [11:0] control_csr_addr;  // CSR address for read/write operation
  input wire control_csr_read_enable;  // Control signal to enable CSR read operation
  input wire control_csr_write_enable; // Control signal to enable CSR write operation
  input wire [31:0] control_csr_write_data; // Data to be written to CSR

  // Output signals to control module
  output reg control_csr_read_data_valid; // Signal to indicate valid CSR read data
  output reg [31:0] control_csr_read_data; // CSR read data

  // Input signals from other modules
  input wire interrupt_request;  // Signal from interrupt controller indicating an interrupt request
  input wire [31:0] interrupt_cause;  // Signal from interrupt controller providing the cause of the interrupt

  // Output signals to other modules
  output reg interrupt_acknowledge;  // Signal to interrupt controller acknowledging the interrupt request
  output reg [31:0] interrupt_vector;  // Signal to interrupt controller providing the interrupt vector

  // Input signals from exu module
  input wire exu_read_enable;    // Signal from exu module requesting a read operation
  input wire [11:0] exu_read_addr; // Signal from exu module specifying the CSR address for read operation

  // Output signals to exu module
  output reg [31:0] exu_read_data; // Signal to exu module providing the data read from CSR

  // Input signals from wb module
  input wire wb_write_enable;     // Signal from wb module requesting a write operation
  input wire [11:0] wb_write_addr; // Signal from wb module specifying the CSR address for write operation
  input wire [31:0] wb_write_data; // Signal from wb module providing the data to be written to CSR

  // Assign initial values to mstatus
  initial begin
    mstatus = 32'h0;  // Initialize to all zeros or appropriate default values
    mcause = 32'h0;         // Initialize to all zeros or appropriate default values
    mepc = 32'h0;           // Initialize to all zeros or appropriate default values
    mip = 32'h0;            // Initialize to all zeros or appropriate default values
    mie = 32'h0;            // Initialize to all zeros or appropriate default values
    mtvec = 32'h0;          // Initialize to all zeros or appropriate default values
    mhartid = 32'h0;        // Initialize to a unique ID for each core if in a multi-core system
    mscratch = 32'h0;       // Initialize to all zeros or appropriate default values
    mideleg = 32'h0;        // Initialize to all zeros or appropriate default values
    medeleg = 32'h0;        // Initialize to all zeros or appropriate default values
    mcounteren = 32'h0;     // Initialize to all zeros or appropriate default values
    mcounter = 32'h0;       // Initialize to all zeros or appropriate default values
    misa = 32'h0;           // Initialize to all zeros or appropriate default values
    mvendorid = 32'h0;      // Initialize to the vendor ID of the processor
    marchid = 32'h0;        // Initialize to the architecture ID of the processor
    mimpid = 32'h0;         // Initialize to the implementation ID of the processor
  end

  // Logic to update mstatus based on control signals and instructions
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      // Reset values for mstatus
      mstatus <= 32'h0;  // Reset to all zeros or appropriate default values
      mcause <= 32'h0;         // Reset to all zeros or appropriate default values
      mepc <= 32'h0;           // Reset to all zeros or appropriate default values
      mip <= 32'h0;            // Reset to all zeros or appropriate default values
      mie <= 32'h0;            // Reset to all zeros or appropriate default values
      mtvec <= 32'h0;          // Reset to all zeros or appropriate default values
      mhartid <= 32'h0;        // Reset to a unique ID for each core if in a multi-core system
      mscratch <= 32'h0;       // Reset to all zeros or appropriate default values
      mideleg <= 32'h0;        // Reset to all zeros or appropriate default values
      medeleg <= 32'h0;        // Reset to all zeros or appropriate default values
      mcounteren <= 32'h0;     // Reset to all zeros or appropriate default values
      mcounter <= 32'h0;       // Reset to all zeros or appropriate default values
      misa <= 32'h0;           // Reset to all zeros or appropriate default values
      mvendorid <= 32'h0;      // Reset to the vendor ID of the processor
      marchid <= 32'h0;        // Reset to the architecture ID of the processor
      mimpid <= 32'h0;         // Reset to the implementation ID of the processor
    end else begin
      // Update mstatus and mcause based on control signals and instructions
      if (csr_instruction) begin
        // Decode instruction and update mstatus and mcause accordingly
        // Example: Set or clear MEIE (Machine External Interrupt Enable) based on CSR instruction
        if (csr_op == CSR_OP_SET) begin
          mstatus[3] <= 1'b1;  // Set MEIE
        end else if (csr_op == CSR_OP_CLEAR) begin
          mstatus[3] <= 1'b0;  // Clear MEIE
        end

        // Example: Write exception cause to mcause register
        if (csr_op == CSR_OP_WRITE_CAUSE) begin
          mcause <= csr_write_data;
        end

        // Example: Write the program counter to mepc on an exception
        if (csr_op == CSR_OP_WRITE_MEPC) begin
          mepc <= pc;  // Write program counter to mepc
        end

        // Example: Set or clear MEIP (Machine External Interrupt Pending) based on CSR instruction
        if (csr_op == CSR_OP_SET) begin
          mip[11] <= 1'b1;  // Set MEIP
        end else if (csr_op == CSR_OP_CLEAR) begin
          mip[11] <= 1'b0;  // Clear MEIP
        end

        // Example: Set or clear MEIE (Machine External Interrupt Enable) based on CSR instruction
        if (csr_op == CSR_OP_SET) begin
          mie[11] <= 1'b1;  // Set MEIE
        end else if (csr_op == CSR_OP_CLEAR) begin
          mie[11] <= 1'b0;  // Clear MEIE
        end

        // Example: Write trap vector base address to mtvec
        if (csr_op == CSR_OP_WRITE_MTVEC) begin
          mtvec <= csr_write_data;
        end

        // Example: Set mhartid to the value written in a CSR instruction
        if (csr_op == CSR_OP_WRITE_MHARTID) begin
          mhartid <= csr_write_data;
        end

        // Example: Write data to mscratch on a CSR instruction
        if (csr_op == CSR_OP_WRITE_MSCRATCH) begin
          mscratch <= csr_write_data;
        end

        // Example: Write data to mideleg on a CSR instruction
        if (csr_op == CSR_OP_WRITE_MIDELEG) begin
          mideleg <= csr_write_data;
        end

        // Example: Write data to medeleg on a CSR instruction
        if (csr_op == CSR_OP_WRITE_MEDELEG) begin
          medeleg <= csr_write_data;
        end

        // Example: Write data to mcounteren on a CSR instruction
        if (csr_op == CSR_OP_WRITE_MCOUNTREN) begin
          mcounteren <= csr_write_data;
        end

        if (csr_op == CSR_OP_WRITE_MCOUNTR) begin
          mcounter <= csr_write_data;
        end

        // Example: Write data to misa on a CSR instruction
        if (csr_op == CSR_OP_WRITE_MISA) begin
          misa <= csr_write_data;
        end

        // Example: Write data to mvendorid on a CSR instruction
        if (csr_op == CSR_OP_WRITE_MVENDORID) begin
          mvendorid <= csr_write_data;
        end

        if (csr_op == CSR_OP_WRITE_MARCHID) begin
          mvarchid <= csr_write_data;
        end

        if (csr_op == CSR_OP_WRITE_MIMPID) begin
          mimpid <= csr_write_data;
        end
       end
    end
  end

  // Logic to handle interrupt-related signals
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      // Reset values for output signals
      interrupt_acknowledge <= 1'b0;
      interrupt_vector <= 32'h0;
    end else begin
      // Handle interrupt-related signals
      if (interrupt_request) begin
        // Process interrupt request
        // Example: Set interrupt_acknowledge to acknowledge the interrupt
        interrupt_acknowledge <= 1'b1;

        // Example: Set interrupt_vector based on interrupt cause
        interrupt_vector <= interrupt_cause;
      end else begin
        // No interrupt request, clear acknowledgment and vector
        interrupt_acknowledge <= 1'b0;
        interrupt_vector <= 32'h0;
      end
    end
  end

  // Logic to handle read and write interactions
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      // Reset values for output signals
      exu_read_data <= 32'h0;
    end else begin
      // Handle read operation from exu module
      if (exu_read_enable) begin
        // Example: Read data from CSR based on exu_read_addr
        // You need to implement the logic to read from the appropriate CSR
        exu_read_data <= read_csr(exu_read_addr);
      end

      // Handle write operation from wb module
      if (wb_write_enable) begin
        // Example: Write data to CSR based on wb_write_addr and wb_write_data
        // You need to implement the logic to write to the appropriate CSR
        write_csr(wb_write_addr, wb_write_data);
      end
    end
  end


  // Logic to handle input and output interactions with the control module
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      // Reset values for output signals
      control_csr_read_data_valid <= 1'b0;
      control_csr_read_data <= 32'h0;
    end else begin
      // Handle control signals from control module
      if (control_op == 3'b001) begin // Check for CSR read operation
        if (control_csr_read_enable) begin
          // Example: Read data from CSR based on control_csr_addr
          // You need to implement the logic to read from the appropriate CSR
          control_csr_read_data <= read_csr(control_csr_addr);
          control_csr_read_data_valid <= 1'b1;
        end else begin
          control_csr_read_data_valid <= 1'b0;
        end
      end

      // Handle control write operation
      if (control_op == 3'b010) begin // Check for CSR write operation
        if (control_csr_write_enable) begin
          // Example: Write data to CSR based on control_csr_addr and control_csr_write_data
          // You need to implement the logic to write to the appropriate CSR
          write_csr(control_csr_addr, control_csr_write_data);
        end
      end
    end
  end

  // Example functions for reading and writing to CSR
  function [31:0] read_csr;
    input [11:0] addr;
    // Implement the logic to read from CSR based on the address
  endfunction

  function write_csr;
    input [11:0] addr;
    input [31:0] data;
    // Implement the logic to write to CSR based on the address and data
  endfunction

  // Execution of CSR instructions
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      // Reset values for CSR registers
      mstatus <= 32'h0;
      mcause <= 32'h0;
      mepc <= 32'h0;
      // ... (other CSR registers)
    end else begin
      // CSR read operation
      if (control_csr_read_enable) begin
        control_csr_read_data_valid <= 1'b1;
        case (control_csr_addr)
          // ... (handle specific CSR addresses)
          12'h300: csr_data_out <= mstatus; // Read mstatus
          12'h342: csr_data_out <= mcause;  // Read mcause
          12'h341: csr_data_out <= mepc;    // Read mepc
          // ... (handle other CSR addresses)
          default: csr_data_out <= 32'h0;   // Default value for unknown CSR addresses
        endcase
      end else begin
        control_csr_read_data_valid <= 1'b0;
        csr_data_out <= 32'h0;
      end

      // CSR write operation
      if (control_csr_write_enable) begin
        case (control_csr_addr)
          // ... (handle specific CSR addresses)
          12'h300: mstatus <= control_csr_write_data; // Write mstatus
          12'h342: mcause <= control_csr_write_data;  // Write mcause
          12'h341: mepc <= control_csr_write_data;    // Write mepc
          // ... (handle other CSR addresses)
          default: ; // No action for unknown CSR addresses
        endcase
      end

      // CSR instructions handling
      case (control_op)
        // CSRRW - Read from CSR, Write to CSR
        3'b001: mepc <= (control_csr_read_enable) ? csr_data_out : control_csr_write_data;

        // CSRRS - Read from CSR, Set bits in CSR
        3'b010: mepc <= (control_csr_read_enable) ? csr_data_out | control_csr_write_data : mepc;

        // CSRRC - Read from CSR, Clear bits in CSR
        3'b011: mepc <= (control_csr_read_enable) ? csr_data_out & (~control_csr_write_data) : mepc;

        // CSRRWI - Read from CSR, Write immediate to CSR
        3'b101: mepc <= (control_csr_read_enable) ? csr_data_out : {27'h0, control_csr_write_data};

        // CSRRSI - Read from CSR, Set bits in CSR immediate
        3'b110: mepc <= (control_csr_read_enable) ? csr_data_out | {27'h0, control_csr_write_data} : mepc;

        // CSRRCI - Read from CSR, Clear bits in CSR immediate
        3'b111: mepc <= (control_csr_read_enable) ? csr_data_out & (~(27'h0 | control_csr_write_data)) : mepc;

        // ... (handle other CSR instructions)

        default: ; // No action for unknown CSR instructions
      endcase
    end
  end

  // Assign output value
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      control_csr_read_data <= 32'h0;
    end else begin
      control_csr_read_data <= csr_data_out;
    end
  end

endmodule
