# AES-128 Formal Verification

---

## 📚 Project Overview

This project focuses on the formal verification of an AES-128 encryption core using SystemVerilog Assertions (SVA) and Cadence JasperGold Formal Verification Platform.

The goal was to verify critical functional properties of the AES design such as key expansion integrity, encryption rounds correctness, and final ciphertext validity using formal proof methods, achieving full assertion coverage.

---

## 🛠️ Verification Strategy

- Developed SystemVerilog Assertions to capture:
  - Correctness of the key scheduling process.
  - Accuracy of S-box substitution and round transformations.
  - Proper final ciphertext generation.
- Used JasperGold to formally prove the assertions without needing exhaustive simulation.
- Focused on detecting corner cases and design bugs that are difficult to catch through traditional simulation-based verification.

---

## 📦 Project Structure

AES128_Formal_Verification/ ├── src/ │ ├── rtl/ │ │ └── (AES-128 RTL design files: aes_core.sv, aes_round.sv, key_expand.sv, etc.) │ ├── sva/ │ │ └── (SystemVerilog Assertion files: aes_assertions.sv, aes_properties.sv, etc.) │ ├── scripts/ │ │ └── (JasperGold setup scripts, if any) ├── report/ │ └── (Formal verification report - to be added) ├── README.md

yaml
Copy
Edit

---

## 🔍 Key Formal Properties Verified

- Correct round key expansion from initial key input.
- Correct encryption transformations across all rounds (SubBytes, ShiftRows, MixColumns).
- Correct final ciphertext output after 10 rounds.
- No deadlock or stuck states in the encryption process.

---

## 📈 Results Summary

- All formal assertions were proven without counterexamples.
- Full functional coverage was achieved for the critical encryption paths.
- Formal verification provided exhaustive proof of correctness, complementing traditional simulation efforts.

---

## 🧠 Key Learnings

- Gained hands-on experience in writing and structuring SystemVerilog Assertions (SVA).
- Understood how to set up and run formal verification using Cadence JasperGold.
- Learned how to debug failing properties and refine assertions to match functional intent.
- Realized the power of formal tools in finding corner-case design issues efficiently.

---
