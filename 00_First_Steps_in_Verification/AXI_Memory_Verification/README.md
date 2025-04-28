# AXI Memory Protocol Verification

---

## 📚 Project Overview

This project demonstrates the progressive verification of an AXI4-Lite compliant slave interface through two stages:

- **SystemVerilog class-based directed testbench** for early **module-level** validation.
- **UVM (Universal Verification Methodology) environment** for **system-level** integrated verification.

This approach reflects real-world industry practices, where simple module-level sanity checks are followed by scalable, reusable system-level verification.

---

## 🛠️ Verification Approaches

### 🔹 SystemVerilog Directed Testbench (Module-Level Verification)

- Verified a basic AXI slave design located under:
  - `src/rtl/module_level/axi_slave_basic_design.sv`
- Applied directed Read and Write transactions.
- Focused on validating fundamental AXI handshakes:
  - Write Address (AWVALID/AWREADY)
  - Write Data (WVALID/WREADY)
  - Write Response (BVALID/BREADY)
  - Read Address (ARVALID/ARREADY)
  - Read Data (RVALID/RREADY)
- Ensured initial functional correctness before moving to complex environments.

---

### 🔹 UVM-Based Environment (System-Level Verification)

- Verified a more full-featured AXI slave design located under:
  - `src/rtl/system_level/axi_slave_full_design.sv`
- Developed a layered UVM testbench including:
  - Transaction
  - Driver
  - Monitor
  - Scoreboard
  - Sequences
  - Environment
  - Test
- Performed constrained-random generation of AXI transactions.
- Focused on verifying complete protocol behavior including:
  - Address/data channel independence
  - Valid/Ready handshake robustness
  - Response correctness (OKAY, SLVERR)
- Emphasized coverage-driven verification and reusability.

---

## 📦 Project Structure

AXI_Memory_Verification/ ├── src/ │ ├── rtl/ │ │ ├── module_level/ │ │ │ └── axi_slave_basic_design.sv │ │ ├── system_level/ │ │ │ └── axi_slave_full_design.sv │ ├── tb/ │ │ └── axi_tb.sv │ ├── uvm_env/ │ │ └── (UVM environment files...) ├── README.md

yaml
Copy
Edit

---

## 📈 Results Summary

- Basic AXI slave successfully validated using directed tests for single read/write transactions.
- Full AXI slave verified through UVM-based random transaction streams achieving protocol compliance.
- Built modular and reusable testbench components in UVM, matching industry verification standards.

---

## 🧠 Key Learnings

- Transition from directed testing to scalable UVM environments.
- Deep understanding of AXI4-Lite protocol handshakes and transaction flows.
- Design of reusable, layered verification components.
- Practical experience in constrained-random test generation and functional coverage analysis.
