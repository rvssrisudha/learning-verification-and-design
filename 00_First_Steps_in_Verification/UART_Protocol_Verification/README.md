# UART Protocol Verification

## 📚 Project Overview

This project focuses on the functional verification of a UART (Universal Asynchronous Receiver Transmitter) protocol implementation.  
Two verification strategies were adopted across different stages of the project:

- **SystemVerilog class-based directed testbench** for early **module-level** validation.
- **UVM (Universal Verification Methodology) environment** for full **system-level** verification.

This approach demonstrates a realistic industry verification flow — starting with individual module validation and scaling towards system integration testing.

---

## 🛠️ Verification Approaches

### 🔹 SystemVerilog Directed Testbench (Module-Level Verification)

- Verified individual UART Transmitter and Receiver designs located under:
  - `src/rtl/module_level/UART_design.sv`
- Built lightweight SystemVerilog testbench (`src/tb/UART_SV_TB.sv`) to stimulate the designs.
- Focused on validating key UART features:
  - Start bit detection
  - 8-bit data transmission
  - Stop bit framing
- Achieved quick bring-up and functional sanity checking at the block level.

### 🔹 UVM Environment (System-Level Verification)

- Developed a layered UVM-based testbench for verifying the integrated UART system (`uart_top` module) located under:
  - `src/rtl/system_level/UART_design.sv`
- Created UVM components including:
  - Transaction
  - Driver
  - Monitor
  - Scoreboard
  - Sequences
  - Environment
  - Test
- Stimulated UART transmission using randomized sequences and captured UART reception outputs.
- Ensured protocol correctness through functional coverage and scoreboard-based checks.
- Scaled verification to system-level integration scenarios.

---

## 📦 Project Structure

UART_Protocol_Verification/ └── src/ ├── rtl/ │ ├── module_level/ │ │ └── UART_design.sv │ ├── system_level/ │ │ └── UART_design.sv ├── tb/ │ └── UART_SV_TB.sv ├── UVM/ │ └── UART_UVM.sv


---

## 🧠 Key Learnings and Highlights

- Transitioned from directed unit testing to scalable, layered UVM-based verification.
- Gained hands-on experience with UART protocol timing, framing, and serial data transmission.
- Designed reusable verification components enabling easier expansion for future SoC-level projects.
- Developed modular and scalable verification flows matching industry practices.

---

## 🤔 Why Both Module-Level and System-Level Testing?

- **SystemVerilog Directed Testing** provided quick and effective validation for individual modules in isolation, speeding up early development bring-up.
- **UVM Environment Testing** enabled structured, randomized, and reusable system-level verification, ensuring better coverage and preparing the environment for larger system integration.

---

