# 4-Bit Successive Approximation Register (SAR) ADC

A hybrid implementation of a 4-bit Successive Approximation Register (SAR) Analog-to-Digital Converter integrating digital logic designed in Verilog HDL with analog circuitry developed in LTspice. The project demonstrates complete mixed-signal ADC operation by combining a Verilog-based SAR Finite State Machine (FSM), analog Sample-and-Hold circuit, Comparator, and R-2R Ladder DAC using Yosys-generated gate-level netlists for seamless integration.

## Project Overview

Successive Approximation Register (SAR) ADCs are among the most widely used Analog-to-Digital Converters because they offer an excellent balance between conversion speed, power consumption, and hardware complexity.

This project implements a complete 4-bit SAR ADC by designing the digital and analog subsystems independently and then integrating them into a unified mixed-signal architecture.

The digital controller (SAR FSM) was developed and verified using Verilog HDL in Xilinx Vivado, while the analog blocks including the Sample-and-Hold circuit, Comparator, and DAC were designed and simulated in LTspice.

To bridge the gap between digital RTL and analog simulation, Yosys was used to synthesize the Verilog design into a gate-level netlist, which was then imported into LTspice for complete mixed-signal verification.


## Features

- 4-bit SAR ADC architecture
- Verilog HDL implementation of SAR FSM
- Functional verification using Vivado testbench
- Sample-and-Hold circuit in LTspice
- High-speed LT1719 Comparator
- R-2R Ladder DAC
- Mixed-signal integration using Yosys
- Complete end-to-end SAR conversion simulation
- Modular design suitable for future FPGA implementation


## System Architecture

The complete SAR ADC consists of the following blocks:

<img width="960" height="769" alt="image" src="https://github.com/user-attachments/assets/e6c316ad-303f-4627-bcc5-d3816e50370c" />


## Project Workflow

The implementation was carried out in four major stages.

### 1. Digital Design

- Designed the SAR Finite State Machine in Verilog HDL
- Verified functionality using a dedicated testbench
- Simulated using Xilinx Vivado


### 2. Analog Design

Designed and simulated the following analog blocks in LTspice:

- Sample-and-Hold Circuit
- Comparator
- R-2R Ladder DAC

Each module was individually validated before system integration.


### 3. Mixed-Signal Integration

Since LTspice cannot directly simulate Verilog HDL, Yosys was used to synthesize the Verilog SAR FSM into a gate-level netlist.

The generated netlist (.sp and .asy files) was imported into LTspice, where all analog components were connected to the synthesized digital logic.

Several interface modifications were performed to ensure proper communication between analog and digital domains.


### 4. Final Verification

The complete integrated circuit was simulated in LTspice to verify the operation of the entire SAR ADC conversion process.


## Repository Structure

```

SAR_ADC/
│
├── README.md
│
├── rtl/
│ ├── SAR_fsm.v
│ └── sar_adc_testbench.v
│
├── analog/
│ ├── DAC.asc
│ ├── snh.asc
│ ├── sar_comparator.asc
│ └── FINAL CIRCUIT.asc
│
├── integration/
│ ├── sar_fsm.sp
│ └── sar_fsm_4bit.asy
│
└── images/
└── final_circuit.png

```

---

## Tools Used

| Tool | Purpose |
|-------|----------|
| Verilog HDL | Digital Logic Design |
| Xilinx Vivado | RTL Simulation & Verification |
| LTspice | Analog Circuit Design |
| Yosys | Verilog Synthesis & Netlist Generation |
| GitHub | Version Control |

---

## Final Integrated Circuit



```




```

---

## Challenges Faced

### 1. Signal Integrity & Charge Injection

**Challenge**

The Sample-and-Hold circuit exhibited noticeable voltage droop during the SAR conversion process, reducing conversion accuracy.

**Solution**

The hold capacitor was optimized to **4 nF**, balancing the RC charging time with leakage current to maintain stable sampled voltages.


### 2. Impedance Matching (Loading Effect)

**Challenge**

The original 10kΩ R-2R ladder heavily loaded the Op-Amp buffer, preventing the DAC output from reaching the full 3.3V reference.

**Solution**

The ladder resistor values were increased by a factor of 10 to **100kΩ/200kΩ**, significantly reducing current draw and maintaining proper DAC operation.


### 3. Comparator Non-Idealities

**Challenge**

The LT1719 comparator could not reliably compare voltages close to the positive supply rail due to Input Common-Mode Range (ICMR) limitations.

**Solution**

The comparator supply voltage was increased to **5V**, while keeping logic signals at **3.3V**, providing sufficient headroom for accurate comparisons.


### 4. NMOS Switch Performance

**Challenge**

The Sample-and-Hold NMOS switch suffered from threshold voltage drop and body effect, limiting the sampled voltage.

**Solution**

The NMOS bulk was tied to its source to eliminate body effect, and a voltage-controlled gain stage was introduced to drive the gate above the 3.3V logic level, forcing the transistor into the triode region.


## Results

- Successful implementation of a complete hybrid 4-bit SAR ADC.
- Individual verification of digital and analog modules.
- Successful mixed-signal integration using Yosys-generated netlists.
- Accurate analog-to-digital conversion demonstrated in LTspice.
- Stable operation after resolving analog interface challenges.


## Future Improvements

- Increase ADC resolution to 8-bit and beyond.
- Implement capacitor-based DAC architecture.
- Optimize power consumption.
- FPGA implementation of the complete digital subsystem.
- Physical CMOS implementation using standard cell libraries.
- Static timing and power analysis.


