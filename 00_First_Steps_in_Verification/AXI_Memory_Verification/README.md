# AXI Memory Protocol Verification

---

## 📚 Project Overview

This project focuses on the verification of an AXI4-Lite compliant memory-mapped slave interface.  
The verification process is performed using two complementary approaches:

- A **SystemVerilog class-based directed testbench** for early functional validation.
- A **UVM (Universal Verification Methodology) environment** for scalable and reusable system-level verification.

By implementing both approaches, the project demonstrates how verification can evolve from simple directed testing to a more robust and industry-standard layered methodology.

---

## 🎯 Verification Approaches

### 🔹 SystemVerilog Class-Based Testbench

- Built a lightweight SystemVerilog testbench to validate basic AXI transactions.
- Focused on directed Read and Write operations to ensure correct handshaking and data transfer behavior.
- Suitable for **early-stage module-level** functional verification.

---

### 🔹 UVM-Based Verification Environment

- Developed a complete UVM environment, including driver, monitor, scoreboard, sequencer, transactions, and sequences.
- Modeled AXI master-side behavior to drive a variety of Read and Write transactions to the DUT.
- Implemented a functional coverage model and randomized test scenarios for better protocol validation.
- Prepared the environment for **future scalability and integration into larger SoC verification flows**.

---

## 🤔 Why Both SystemVerilog and UVM?

- The **SystemVerilog class-based testbench** helped in **quickly verifying** the basic functionality of the AXI Slave during early development stages.
- The **UVM-based testbench** allowed building a **scalable, layered, and reusable** environment, making it easier to manage complexity as designs grow larger.
- This mirrors **real-world verification practices** where small units are initially validated with simpler methods, and full systems are verified with structured methodologies like UVM.

---

## 🧠 Key Learnings

- Hands-on experience with AXI4-Lite protocol handshakes and transfer mechanisms.
- Designed and integrated UVM components to build a full test environment.
- Understood the practical challenges in moving from directed stimulus to constrained-random verification.
- Emphasized on achieving reusability, modularity, and coverage closure in verification environments.


> **Note:**  
> This project verifies an AXI4-Lite compliant slave interface primarily focusing on basic single-beat Read and Write transactions according to AMBA AXI protocol specifications.
