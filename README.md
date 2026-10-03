# Day 5 — 4-Bit Comparator

<p align="center">
  <b>4-Bit Comparator RTL Design, Functional Verification & Cadence Genus Synthesis using Verilog HDL.</b>
</p>

<p align="center">
  <code>Specification → Architecture → RTL → Testbench → Simulation → Verification → Synthesis → Timing → Power → PPA → Documentation</code>
</p>

---

## 1. Project Information

| Item                         | Details                          |
| ---------------------------- | -------------------------------- |
| Project                      | **Day 5**                        |
| Design Title                 | `4-Bit Comparator`               |
| Top Module                   | `comparator_4bit_top`            |
| Domain                       | Digital VLSI / RTL Design        |
| HDL                          | Verilog HDL                      |
| Design Type                  | Combinational Logic Circuit      |
| Inputs                       | `A[3:0]`, `B[3:0]`               |
| Outputs                      | `GT`, `EQ`, `LT`                 |
| Verification                 | Directed Functional Verification |
| Verification Result          | **24/24 PASS**                   |
| Simulation Tool              | Cadence NC-Sim                   |
| Synthesis Tool               | Cadence Genus                    |
| Genus Version                | `21.14-s082_1`                   |
| Technology Library           | `tsmc18`                         |
| Operating Condition          | `slow (balanced_tree)`           |
| Wireload Mode                | `enclosed`                       |
| Area Mode                    | `timing library`                 |
| Leaf Instance Count          | **33**                           |
| Sequential Instance Count    | **0**                            |
| Combinational Instance Count | **33**                           |
| Hierarchical Instance Count  | **17**                           |
| Total Cell Area              | **412.474**                      |
| Total Reported Power         | **12.1453 µW**                   |
| Reported Data Path Delay     | **1.080 ns**                     |
| Timing Status                | **UNCONSTRAINED**                |
| Simulation Completion        | **240 ns**                       |
| Status                       | **Completed**                    |

---

## 2. Project Overview

This project implements a **4-bit magnitude comparator** using synthesizable Verilog HDL.

The comparator compares two 4-bit unsigned inputs:

```text
A[3:0]
B[3:0]
```

and generates three mutually exclusive comparison results:

```text
GT → A > B
EQ → A = B
LT → A < B
```

### Basic Operation

| Condition | Output   |
| --------- | -------- |
| `A > B`   | `GT = 1` |
| `A = B`   | `EQ = 1` |
| `A < B`   | `LT = 1` |

The design was verified using Cadence NC-Sim and synthesized using Cadence Genus with the `tsmc18` technology library.

The verification environment includes:

* Basic gate verification
* 1-bit comparator verification
* 4-bit comparator verification
* MSB priority testing
* Lower-bit priority testing
* Gate-level vs RTL comparison
* Top-module verification
* SHM waveform generation

---

## 3. Objective

The objectives of this project are:

* Understand magnitude comparator operation.
* Design a 1-bit comparator.
* Build a hierarchical 4-bit comparator.
* Understand MSB priority in multi-bit comparison.
* Understand lower-bit comparison when higher bits are equal.
* Implement synthesizable Verilog RTL.
* Develop a directed functional verification testbench.
* Verify all major comparison conditions.
* Compare gate-level behavior with RTL behavior.
* Generate simulation waveforms.
* Understand RTL hierarchy during synthesis.
* Understand RTL-to-standard-cell mapping.
* Perform synthesis using Cadence Genus.
* Analyze cell count and area.
* Analyze power components.
* Analyze the synthesized data path.
* Identify the reported longest path.
* Document actual PPA results.
* Build a professional GitHub Digital VLSI portfolio project.

---

## 4. Comparator Concept

A magnitude comparator determines the relationship between two binary numbers.

For this project:

```text
        A[3:0]
          │
          │
          ▼
   ┌───────────────┐
   │               │
   │  4-Bit        │
   │  Comparator   │
   │               │
   └───────────────┘
          ▲
          │
        B[3:0]

          │
     ┌────┼────┐
     ▼    ▼    ▼
    GT    EQ   LT
```

Where:

```text
GT = 1 → A > B
EQ = 1 → A = B
LT = 1 → A < B
```

---

## 5. Magnitude Comparison Principle

For unsigned binary numbers, the **most significant differing bit** determines the comparison result.

The comparator therefore examines the inputs starting from:

```text
Bit 3 → Bit 2 → Bit 1 → Bit 0
 MSB                         LSB
```

Conceptually:

```text
A[3] ─┐
      ├── Compare MSB
B[3] ─┘
       │
       ├── Different → Result determined
       │
       └── Equal
             │
             ▼
         Compare bit 2
             │
             ▼
         Compare bit 1
             │
             ▼
         Compare bit 0
```

This MSB-priority behavior was specifically verified in the testbench.

---

## 6. Example Comparisons

### Example 1

```text
A = 0101 = 5
B = 0011 = 3
```

The MSB comparison eventually determines:

```text
A > B
```

Therefore:

```text
GT = 1
EQ = 0
LT = 0
```

### Example 2

```text
A = 0011 = 3
B = 0101 = 5
```

Therefore:

```text
GT = 0
EQ = 0
LT = 1
```

### Example 3

```text
A = 0111 = 7
B = 0111 = 7
```

Therefore:

```text
GT = 0
EQ = 1
LT = 0
```

---

## 7. Hardware Architecture

The design is organized hierarchically using a 4-bit comparator built from 1-bit comparator logic.

### Conceptual Architecture

```text
              A[3:0]
                │
                ▼
       ┌─────────────────┐
       │                 │
       │  4-Bit          │
       │  Comparator     │
       │                 │
       └────────┬────────┘
                │
        ┌───────┼───────┐
        ▼       ▼       ▼
       GT      EQ      LT
```

### Bit-Level Structure

```text
A[3] ─────┐
B[3] ─────┤
           ▼
        Comparator
           │
           │
A[2] ─────┐
B[2] ─────┤
           ▼
        Comparator
           │
           │
A[1] ─────┐
B[1] ─────┤
           ▼
        Comparator
           │
           │
A[0] ─────┐
B[0] ─────┤
           ▼
        Comparator
           │
           ▼
       GT / EQ / LT
```

The actual synthesized implementation is technology-mapped by Genus and therefore contains more standard-cell instances than the logical RTL hierarchy alone suggests.

---

## 8. Logical Hierarchy

The supplied Genus hierarchy report shows:

```text
comparator_4bit_top
│
└── COMP : comparator_4bit
    │
    ├── C0 : comparator_1bit_15
    │   ├── A1 : and_gate_9
    │   ├── A2 : and_gate_8
    │   └── X1 : xor_gate_18
    │
    ├── C1 : comparator_1bit_16
    │   ├── A1 : and_gate_11
    │   ├── A2 : and_gate_10
    │   └── X1 : xor_gate_19
    │
    ├── C2 : comparator_1bit_17
    │   ├── A1 : and_gate_13
    │   ├── A2 : and_gate_12
    │   └── X1 : xor_gate_20
    │
    └── C3 : comparator_1bit
        ├── A1 : and_gate
        ├── A2 : and_gate_14
        └── X1 : xor_gate
```

### Hierarchy Levels

```text
Level 0 → comparator_4bit_top
Level 1 → comparator_4bit
Level 2 → C0, C1, C2, C3
Level 3 → AND / XOR logical blocks
```

This confirms that the intended hierarchical RTL structure was recognized during synthesis.

---

## 9. Functional Specification

### Inputs

| Signal | Width | Description                        |
| ------ | ----: | ---------------------------------- |
| `A`    |     4 | First unsigned comparison operand  |
| `B`    |     4 | Second unsigned comparison operand |

### Outputs

| Signal | Width | Description           |
| ------ | ----: | --------------------- |
| `GT`   |     1 | Asserted when `A > B` |
| `EQ`   |     1 | Asserted when `A = B` |
| `LT`   |     1 | Asserted when `A < B` |

### Expected Relationship

For valid 4-bit unsigned inputs, the comparison produces one of:

```text
A > B
A = B
A < B
```

The verification environment checks the corresponding outputs.

---

## 10. 1-Bit Comparator

The 1-bit comparator forms the basic comparison building block.

For inputs:

```text
A
B
```

the four possible combinations are:

|  A |  B | Relationship |
| -: | -: | ------------ |
|  0 |  0 | Equal        |
|  0 |  1 | A < B        |
|  1 |  0 | A > B        |
|  1 |  1 | Equal        |

The project explicitly verifies all four combinations.

---

## 11. RTL Design

The project uses hierarchical Verilog RTL.

```text
rtl/
```

The top-level design is:

```text
comparator_4bit_top
```

The RTL hierarchy contains:

```text
comparator_4bit_top
        │
        ▼
 comparator_4bit
        │
   ┌────┼────┬────┐
   ▼    ▼    ▼    ▼
  C0   C1   C2   C3
   │    │    │    │
   ▼    ▼    ▼    ▼
1-bit comparator blocks
```

The repository source files are the authoritative RTL implementation.

---

## 12. RTL-to-Hardware Mapping

The logical RTL hierarchy is transformed by Genus into technology-specific standard cells.

The supplied technology-mapped cell report contains:

| Standard Cell | Instances |        Area |
| ------------- | --------: | ----------: |
| `AND2X1`      |        11 |     146.362 |
| `AOI21XL`     |         2 |      26.611 |
| `AOI22XL`     |         2 |      33.264 |
| `INVXL`       |        12 |      79.834 |
| `NAND2XL`     |         2 |      19.958 |
| `XOR2XL`      |         4 |     106.445 |
| **Total**     |    **33** | **412.474** |

### Synthesized Hardware

```text
11 × AND2X1
 2 × AOI21XL
 2 × AOI22XL
12 × INVXL
 2 × NAND2XL
 4 × XOR2XL
----------------
33 total leaf cells
```

This demonstrates an important synthesis concept:

> RTL operators and hierarchy are not necessarily mapped one-to-one into standard cells.

Genus performs Boolean optimization and technology mapping according to the target library.

---

## 13. Standard-Cell Area Distribution

The supplied cell-area report gives:

| Cell      | Instances |        Area | Approx. Area % |
| --------- | --------: | ----------: | -------------: |
| `AND2X1`  |        11 |     146.362 |         35.45% |
| `XOR2XL`  |         4 |     106.445 |         25.81% |
| `INVXL`   |        12 |      79.834 |         19.38% |
| `AOI22XL` |         2 |      33.264 |          8.06% |
| `AOI21XL` |         2 |      26.611 |          6.45% |
| `NAND2XL` |         2 |      19.958 |          4.84% |
| **Total** |    **33** | **412.474** |       **100%** |

### Category Breakdown

| Category       | Instances |        Area | Percentage |
| -------------- | --------: | ----------: | ---------: |
| Inverter       |        12 |      79.834 |      19.4% |
| Logic          |        21 |     332.640 |      80.6% |
| Physical cells |         0 |       0.000 |       0.0% |
| **Total**      |    **33** | **412.474** |   **100%** |

---

## 14. Verification Strategy

The verification environment uses multiple levels of checking.

```text
Basic Gate Verification
          ↓
1-Bit Comparator
          ↓
4-Bit Comparator
          ↓
MSB Priority
          ↓
Lower-Bit Priority
          ↓
Gate-Level vs RTL
          ↓
Top Module
```

The testbench was executed using Cadence NC-Sim.

---

## 15. Verification Results

### 1. Basic Gate Verification

```text
GATE 00 : PASS
GATE 01 : PASS
GATE 10 : PASS
GATE 11 : PASS
```

Result:

```text
4/4 PASS
```

---

### 2. 1-Bit Comparator

```text
1-BIT 00 : PASS
1-BIT 01 : PASS
1-BIT 10 : PASS
1-BIT 11 : PASS
```

Result:

```text
4/4 PASS
```

---

### 3. 4-Bit Comparator

```text
4-BIT 5 > 3 : PASS
4-BIT 3 < 5 : PASS
4-BIT 7 = 7 : PASS
4-BIT 15 > 0 : PASS
4-BIT 0 < 15 : PASS
```

Result:

```text
5/5 PASS
```

---

### 4. MSB Priority

```text
MSB PRIORITY 1 : PASS
MSB PRIORITY 2 : PASS
```

Result:

```text
2/2 PASS
```

---

### 5. Lower-Bit Priority

```text
LOWER BIT TEST 1 : PASS
LOWER BIT TEST 2 : PASS
```

Result:

```text
2/2 PASS
```

---

### 6. Gate-Level vs RTL

```text
COMPARE 0 vs 0 : PASS
COMPARE 5 vs 2 : PASS
COMPARE 2 vs 5 : PASS
COMPARE 15 vs 15 : PASS
```

Result:

```text
4/4 PASS
```

This verifies that the tested gate-level implementation produces the expected behavior relative to the RTL reference.

---

### 7. Top Module Verification

```text
TOP 12 > 3 : PASS
TOP 3 < 12 : PASS
TOP 10 = 10 : PASS
```

Result:

```text
3/3 PASS
```

---

## 16. Overall Verification Result

Total explicitly reported checks:

[
4+4+5+2+2+4+3=24
]

Therefore:

```text
┌──────────────────────────────────┐
│       VERIFICATION RESULT        │
├──────────────────────────────────┤
│ Total Checks : 24                │
│ PASS         : 24                │
│ FAIL         : 0                 │
│ Result       : 24/24 PASS        │
└──────────────────────────────────┘
```

### Final Functional Verification Status

[
\boxed{\text{24/24 PASS}}
]

---

## 17. MSB Priority Verification

MSB priority is a critical property of a binary magnitude comparator.

The comparison proceeds from the most significant bit.

```text
A[3] / B[3]
     │
     ▼
Different?
 ┌───┴───┐
Yes      No
 │        │
 ▼        ▼
Result   A[2]/B[2]
determined
```

If the MSBs are equal, the next significant bit is evaluated.

This continues toward the LSB until a difference is found.

The testbench contains dedicated MSB-priority tests, and both supplied tests passed.

---

## 18. Lower-Bit Priority Verification

Lower bits should only influence the result when the higher-order bits do not already determine the relationship.

Conceptually:

```text
Bit 3
 ↓
Equal?
 ↓
Bit 2
 ↓
Equal?
 ↓
Bit 1
 ↓
Equal?
 ↓
Bit 0
 ↓
Final Result
```

The supplied testbench includes two lower-bit priority tests.

Result:

```text
2/2 PASS
```

---

## 19. Gate-Level vs RTL Verification

One important verification stage compares the synthesized gate-level implementation with the RTL reference.

Test cases:

```text
0  vs 0
5  vs 2
2  vs 5
15 vs 15
```

All supplied cases passed.

```text
RTL behavior
     │
     ├──────────────┐
     ▼              ▼
Reference       Gate-Level
     │              │
     └──── Compare ─┘
             │
             ▼
           PASS
```

This provides evidence that the tested synthesized implementation preserves the expected functional behavior for the supplied vectors.

---

## 20. Simulation

The project was simulated using Cadence NC-Sim.

### Waveform Database

The simulation created:

```text
waves.shm
```

using:

```text
database -open waves -into waves.shm -default
```

### Probed Signals

The supplied simulation probe command includes:

```text
A
A4
AND_Y
B
B4

C1_EQ
C1_GT
C1_LT

EQ
GT
LT

NOT_Y
OR_Y
XOR_Y

RTL_EQ
RTL_GT
RTL_LT

TOP_EQ
TOP_GT
TOP_LT
```

These signals provide visibility into:

* Input values
* Intermediate comparator logic
* RTL reference outputs
* Gate-level outputs
* Top-level outputs

---

## 21. Simulation Completion

The supplied NC-Sim transcript reports:

```text
Simulation complete via $finish(1)
at time 240 NS + 0
```

Therefore:

[
\boxed{\text{Simulation completion}=240\ ns}
]

The testbench completed normally using `$finish`.

---

## 22. Synthesis Flow

The design was synthesized using Cadence Genus.

```text
Verilog RTL
     ↓
Read / Elaborate
     ↓
Logic Synthesis
     ↓
Boolean Optimization
     ↓
Technology Mapping
     ↓
Standard-Cell Netlist
     ↓
Area / Timing / Power Analysis
```

### Genus Configuration

| Parameter           | Actual Value           |
| ------------------- | ---------------------- |
| Tool                | Cadence Genus          |
| Version             | `21.14-s082_1`         |
| Top Module          | `comparator_4bit_top`  |
| Technology Library  | `tsmc18`               |
| Operating Condition | `slow (balanced_tree)` |
| Wireload Mode       | `enclosed`             |
| Area Mode           | `timing library`       |
| Report Date         | Sep 29, 2026           |

---

## 23. Area Analysis

The supplied Genus report gives:

| Metric                       |      Result |
| ---------------------------- | ----------: |
| Leaf Instance Count          |      **33** |
| Physical Instance Count      |       **0** |
| Sequential Instance Count    |       **0** |
| Combinational Instance Count |      **33** |
| Hierarchical Instance Count  |      **17** |
| Cell Area                    | **412.474** |
| Physical Cell Area           |   **0.000** |
| Net Area                     |   **0.000** |
| Total Area                   | **412.474** |

Therefore:

[
\boxed{\text{Total Cell Area}=412.474}
]

The value is retained in the **library/tool area units reported by Genus**.

No unsupported conversion to µm² is made.

---

## 24. Instance Analysis

The synthesized design contains:

```text
Leaf instances           = 33
Sequential instances     = 0
Combinational instances  = 33
Physical instances       = 0
Hierarchical instances   = 17
```

### Hardware Classification

```text
33 total leaf cells
       │
       ├── Sequential = 0
       │
       └── Combinational = 33
```

Therefore, the synthesized comparator is a **pure combinational implementation** with no flip-flops, registers, or latches reported.

---

## 25. Fanout Analysis

The supplied Genus summary reports:

| Fanout Metric      |   Result |
| ------------------ | -------: |
| Maximum Fanout     |    **3** |
| Maximum Fanout Net | **B[3]** |
| Minimum Fanout     |    **1** |
| Minimum Fanout Net |   **LT** |
| Average Fanout     |  **1.5** |

The highest reported fanout is:

```text
B[3] → Fanout 3
```

The lowest reported fanout is:

```text
LT → Fanout 1
```

---

## 26. Timing Analysis

The supplied Genus timing path report identifies:

```text
Path 1: UNCONSTRAINED

Startpoint: (R) A[3]
Endpoint:   (R) LT

Data Path: 1080 ps
```

Therefore:

[
\boxed{T_{path}=1080\ ps}
]

or:

[
\boxed{T_{path}=1.080\ ns}
]

### Reported Path

```text
A[3]
  │
  ▼
XOR2XL
  │
  ▼
INVXL
  │
  ▼
AND2X1
  │
  ▼
AND2X1
  │
  ▼
AOI22XL
  │
  ▼
NAND2XL
  │
  ▼
LT
```

---

## 27. Critical Path Delay Breakdown

The supplied report gives:

| Timing Point             | Cell      | Reported Delay |     Arrival |
| ------------------------ | --------- | -------------: | ----------: |
| `A[3]`                   | Input     |           0 ps |        0 ps |
| `COMP/C3/X1/g13__5122/Y` | `XOR2XL`  |         318 ps |      318 ps |
| `COMP/C3/g4/Y`           | `INVXL`   |         134 ps |      452 ps |
| `COMP/g159__9315/Y`      | `AND2X1`  |         225 ps |      676 ps |
| `COMP/g156__7482/Y`      | `AND2X1`  |         225 ps |      902 ps |
| `COMP/g153__6131/Y`      | `AOI22XL` |          88 ps |      990 ps |
| `COMP/g152__7098/Y`      | `NAND2XL` |          90 ps | **1080 ps** |
| `LT`                     | Output    |           0 ps | **1080 ps** |

The final reported arrival time is:

[
\boxed{1080\ ps}
]

### Largest Individual Cell Delay

The largest individual reported cell delay is:

```text
XOR2XL = 318 ps
```

However, the two consecutive `AND2X1` stages collectively account for:

[
225+225=450\ ps
]

Therefore, optimization should consider the **whole logic depth**, rather than focusing only on the XOR cell.

---

## 28. Timing Constraint Limitation

The timing path is explicitly reported as:

```text
UNCONSTRAINED
```

Therefore, the following are **not claimed** from this report:

* Timing closure
* Valid timing slack
* Setup timing compliance
* Hold timing compliance
* Guaranteed maximum operating frequency
* Clock-period compliance

The correct documented statement is:

> **Genus reported a 1.080 ns input-to-output data-path delay from A[3] to LT. The path is unconstrained, so the result is reported as a raw data-path delay rather than a constrained timing-closure result.**

This distinction is important for professional ASIC documentation.

---

## 29. Power Analysis

The supplied Genus power report gives:

```text
Instance: /comparator_4bit_top
Power Unit: W
PDB Frame: /stim#0/frame#0
```

### Total Power

[
P_{total}=1.21453\times10^{-5}W
]

Therefore:

[
\boxed{P_{total}=12.1453\ \mu W}
]

---

## 30. Power Breakdown

| Category  |     Power (W) |  Power (µW) | Contribution |
| --------- | ------------: | ----------: | -----------: |
| Leakage   | `1.41486e-08` | **0.01415** |    **0.12%** |
| Internal  | `7.58969e-06` | **7.58969** |   **62.49%** |
| Switching | `4.54146e-06` | **4.54146** |   **37.39%** |
| **Total** | `1.21453e-05` | **12.1453** |     **100%** |

### Power Category

The supplied report attributes all reported power to:

```text
logic
```

The following categories report zero power:

```text
memory
register
latch
bbox
clock
pad
pm
```

This is consistent with the synthesized design being reported as entirely combinational.

---

## 31. Power Interpretation

The largest component is:

```text
Internal Power = 62.49%
```

followed by:

```text
Switching Power = 37.39%
```

and:

```text
Leakage Power = 0.12%
```

The power result is associated with the supplied PDB simulation frame:

```text
/stim#0/frame#0
```

Therefore, the value should be treated as the **reported power for this analysis configuration and stimulus**, not as a universal power value for every possible input workload.

---

## 32. PPA Summary

PPA represents:

```text
Power
Performance
Area
```

### Actual Day-5 Results

| PPA Metric                   |     Actual Result |
| ---------------------------- | ----------------: |
| **Area**                     |       **412.474** |
| **Total Power**              |    **12.1453 µW** |
| **Reported Data Path Delay** |      **1.080 ns** |
| **Leaf Cells**               |            **33** |
| **Sequential Cells**         |             **0** |
| **Combinational Cells**      |            **33** |
| **Critical Path**            |     **A[3] → LT** |
| **Timing Status**            | **UNCONSTRAINED** |
| **Verification**             |    **24/24 PASS** |

### PPA Representation

```text
┌──────────────────────────────────────────┐
│          DAY 5 — PPA RESULTS             │
├──────────────────────────────────────────┤
│ Area        : 412.474                    │
│ Power       : 12.1453 µW                 │
│ Delay       : 1.080 ns                   │
│ Cells       : 33                         │
│ Sequential  : 0                          │
│ Verification: 24/24 PASS                 │
│ Timing     : UNCONSTRAINED               │
└──────────────────────────────────────────┘
```

---

## 33. Optimization Considerations

The current implementation is treated as the **baseline implementation**.

Possible optimization directions include:

### 1. Logic Depth Reduction

The reported path contains multiple logic stages:

```text
XOR
 ↓
INV
 ↓
AND
 ↓
AND
 ↓
AOI
 ↓
NAND
```

Reducing logic depth can potentially improve the data-path delay.

### 2. Boolean Optimization

Equivalent Boolean expressions can sometimes allow synthesis to select a more compact or faster implementation.

### 3. Technology Mapping

Genus may map equivalent Boolean logic into different combinations of:

```text
AND
XOR
NAND
AOI
INV
```

depending on constraints and optimization objectives.

### 4. Fanout Optimization

The maximum reported fanout is:

```text
B[3] = 3
```

Fanout is not excessive in this small design, but it remains an important timing consideration in larger designs.

### 5. PPA Trade-offs

Optimization should always evaluate:

```text
Timing ↔ Area ↔ Power
```

An optimization that improves delay but increases area or power is a trade-off rather than an unconditional improvement.

### Current Optimization Status

No numerical optimization improvement is claimed because only the baseline synthesis results have been supplied.

---

## 34. Common Design Mistakes

### 1. Ignoring MSB Priority

A comparator cannot simply compare lower bits without considering higher-order differences.

### 2. Incorrect Equality Propagation

Lower-bit comparison is relevant only when higher-order bits are equal.

### 3. Treating RTL Structure as Final Hardware

RTL hierarchy does not directly equal technology-mapped standard-cell structure.

### 4. Assuming Cell Count Equals RTL Gate Count

The synthesized design contains:

```text
33 leaf standard-cell instances
```

This should not be interpreted as simply "33 RTL gates."

### 5. Treating Unconstrained Timing as Timing Closure

```text
UNCONSTRAINED
```

does not mean timing is closed.

### 6. Treating Power as Universal

The reported:

```text
12.1453 µW
```

corresponds to the supplied power-analysis configuration and stimulus frame.

### 7. Reporting Unsupported Units

The area report gives:

```text
412.474
```

The supplied report does not establish this as `µm²`, so the README retains the original Genus area unit.

---

## 35. Verification Status

| Item                            | Status            |
| ------------------------------- | ----------------- |
| Specification                   | **Complete**      |
| Architecture                    | **Complete**      |
| RTL                             | **Complete**      |
| Testbench                       | **Complete**      |
| Basic Gate Verification         | **PASS**          |
| 1-Bit Comparator                | **PASS**          |
| 4-Bit Comparator                | **PASS**          |
| MSB Priority                    | **PASS**          |
| Lower-Bit Priority              | **PASS**          |
| Gate-Level vs RTL               | **PASS**          |
| Top Module                      | **PASS**          |
| Waveform Database               | **Generated**     |
| Simulation                      | **Complete**      |
| Synthesis                       | **Complete**      |
| Hierarchy Analysis              | **Complete**      |
| Standard-Cell Mapping           | **Complete**      |
| Area Analysis                   | **Complete**      |
| Power Analysis                  | **Complete**      |
| Timing Path Analysis            | **Complete**      |
| PPA Analysis                    | **Complete**      |
| Timing Closure                  | **Not claimed**   |
| Formal Verification             | **Not performed** |
| UVM                             | **Not performed** |
| Constrained-Random Verification | **Not performed** |
| Functional Coverage             | **Not performed** |

---

## 36. Project Evidence

Recommended repository evidence:

```text
images/
├── verification_console.png
├── comparator_waveform.png
├── hierarchy_report.png
├── cell_area_report.png
├── power_report.png
└── timing_path.png
```

Only actual screenshots generated from the project flow should be added.

Recommended report files:

```text
reports/
├── area_report.txt
├── cell_area_report.txt
├── hierarchy_report.txt
├── power_report.txt
├── timing_summary.txt
└── timing_path_report.txt
```

---

## 37. Repository Structure

```text
day5-4bit-comparator/
│
├── README.md
│
├── rtl/
│   ├── comparator_1bit.v
│   ├── comparator_4bit.v
│   └── comparator_4bit_top.v
│
├── tb/
│   └── day5_tb.v
│
├── simulation/
│   ├── console_output.txt
│   └── waves.shm/
│
├── synthesis/
│   ├── genus.tcl
│   └── netlist/
│
├── timing/
│   └── timing_path_report.txt
│
├── power/
│   └── power_report.txt
│
├── reports/
│   ├── area_report.txt
│   ├── cell_area_report.txt
│   ├── hierarchy_report.txt
│   ├── timing_summary.txt
│   └── power_report.txt
│
├── images/
│   ├── verification_console.png
│   ├── comparator_waveform.png
│   ├── hierarchy_report.png
│   ├── cell_area_report.png
│   ├── power_report.png
│   └── timing_path.png
│
└── docs/
    └── project_report.pdf
```

---

## 38. Industry Relevance

Magnitude comparators are fundamental building blocks used in:

* ALUs
* CPU datapaths
* sorting hardware
* address comparison
* control logic
* counters
* digital signal-processing hardware
* arithmetic units
* packet-processing hardware
* embedded processors
* ASIC and FPGA datapaths

### Skills Demonstrated

```text
Digital Logic Design
        ↓
Verilog RTL
        ↓
Hierarchical Design
        ↓
Functional Verification
        ↓
Gate-Level Verification
        ↓
NC-Sim Simulation
        ↓
Cadence Genus
        ↓
Technology Mapping
        ↓
Area Analysis
        ↓
Timing Analysis
        ↓
Power Analysis
        ↓
PPA Analysis
        ↓
GitHub Documentation
```

### Relevant VLSI Roles

This project demonstrates concepts relevant to:

* RTL Design
* ASIC Design
* Digital Design
* Design Verification
* FPGA Design
* VLSI Design
* SoC Design

---

## 39. GATE Relevance

Important concepts demonstrated by this project include:

* Combinational circuits
* Magnitude comparators
* Boolean logic
* XOR logic
* AND logic
* Logic hierarchy
* Truth tables
* MSB priority
* Binary comparison
* Propagation delay
* Fanout
* Technology mapping

### Binary Comparison Principle

For two unsigned binary numbers:

```text
Compare MSB first.
If MSBs differ → result is determined.
If MSBs are equal → compare next bit.
Continue until a difference is found.
If all bits are equal → A = B.
```

This principle is central to both the implementation and verification of the project.

---

## 40. Interview Questions

### Basic

**Q1. What is a magnitude comparator?**

A magnitude comparator is a combinational circuit that determines whether one binary number is greater than, equal to, or less than another.

**Q2. What are the outputs of this comparator?**

```text
GT → A > B
EQ → A = B
LT → A < B
```

**Q3. How many input combinations exist for a 4-bit comparator pair?**

There are:

[
2^4 \times 2^4 = 256
]

possible combinations of `A` and `B`.

---

### Architecture

**Q4. Why is MSB priority important?**

The most significant differing bit determines the relationship between two unsigned binary numbers.

**Q5. What happens when higher-order bits are equal?**

The comparator proceeds to the next lower-order bit.

**Q6. Why is a 1-bit comparator useful?**

It provides a basic building block from which a multi-bit comparator can be constructed.

---

### Verification

**Q7. How many explicitly reported verification checks passed?**

```text
24/24 PASS
```

**Q8. What verification levels were used?**

```text
Basic gate
1-bit comparator
4-bit comparator
MSB priority
Lower-bit priority
Gate-level vs RTL
Top module
```

**Q9. Why compare gate-level output with RTL?**

To verify that the synthesized implementation maintains the expected RTL functionality for the tested vectors.

---

### Synthesis

**Q10. How many leaf cells were synthesized?**

```text
33
```

**Q11. How many sequential cells were synthesized?**

```text
0
```

**Q12. What standard cells were used?**

```text
AND2X1
AOI21XL
AOI22XL
INVXL
NAND2XL
XOR2XL
```

---

### Timing

**Q13. What is the reported longest path?**

```text
A[3] → LT
```

**Q14. What is the reported data-path delay?**

```text
1080 ps = 1.080 ns
```

**Q15. Is the timing result constrained?**

No.

The report explicitly states:

```text
UNCONSTRAINED
```

**Q16. Can the 1.080 ns value alone be called timing closure?**

No. It is a reported data-path delay without a valid constrained timing result.

---

### Power / PPA

**Q17. What is the reported total power?**

```text
12.1453 µW
```

**Q18. Which power component is largest?**

```text
Internal power = 62.49%
```

**Q19. What is the reported total cell area?**

```text
412.474
```

**Q20. What is the maximum reported fanout?**

```text
3 on B[3]
```

---

## 41. Tiny Memory

```text
4-Bit Comparator
       │
       ├── A[3:0]
       ├── B[3:0]
       │
       └── GT / EQ / LT
```

### Comparison

```text
A > B → GT
A = B → EQ
A < B → LT
```

### Priority

```text
MSB → LSB
```

### Day-5 Actual Results

```text
Verification : 24/24 PASS
Cells        : 33
Area         : 412.474
Power        : 12.1453 µW
Delay        : 1.080 ns
Path         : A[3] → LT
Fanout       : 3 maximum
Timing       : UNCONSTRAINED
Simulation   : 240 ns
```

---

## 42. Learning Outcome

```text
Comparator Concept
        ↓
1-Bit Comparator
        ↓
4-Bit Architecture
        ↓
MSB Priority
        ↓
Lower-Bit Priority
        ↓
Verilog RTL
        ↓
Testbench
        ↓
Simulation
        ↓
Functional Verification
        ↓
Gate-Level vs RTL
        ↓
Cadence Genus
        ↓
Technology Mapping
        ↓
Area Analysis
        ↓
Timing Path Analysis
        ↓
Power Analysis
        ↓
PPA
        ↓
GitHub Documentation
        ↓
Interview Preparation
```

### Core Engineering Question

> **What hardware does this RTL create?**

### Answer

The supplied RTL synthesizes into a **33-leaf-cell combinational implementation** using `AND2X1`, `AOI21XL`, `AOI22XL`, `INVXL`, `NAND2XL`, and `XOR2XL` standard cells, with a reported total cell area of **412.474**.

---

## 43. Project Status

```text
Specification             ✓ COMPLETE
Architecture              ✓ COMPLETE
RTL                       ✓ COMPLETE
Testbench                 ✓ COMPLETE
Simulation                ✓ COMPLETE
Basic Gate Verification   ✓ PASS
1-Bit Comparator          ✓ PASS
4-Bit Comparator          ✓ PASS
MSB Priority              ✓ PASS
Lower-Bit Priority        ✓ PASS
RTL vs Gate-Level         ✓ PASS
Top Module Verification   ✓ PASS
Waveform Database         ✓ GENERATED
Synthesis                 ✓ COMPLETE
Hierarchy                 ✓ COMPLETE
Cell Mapping              ✓ COMPLETE
Area                      ✓ COMPLETE
Power                     ✓ COMPLETE
Timing Path               ✓ COMPLETE
PPA                       ✓ COMPLETE
Documentation             ✓ COMPLETE
```

---

## 44. Final Day-5 Results

```text
┌─────────────────────────────────────────┐
│       DAY 5 — 4-BIT COMPARATOR          │
├─────────────────────────────────────────┤
│ Top Module      : comparator_4bit_top   │
│ Technology      : tsmc18                 │
│ Leaf Cells      : 33                     │
│ Area            : 412.474                │
│ Power           : 12.1453 µW             │
│ Delay           : 1.080 ns               │
│ Critical Path   : A[3] → LT              │
│ Fanout          : 3 maximum              │
│ Verification    : 24/24 PASS             │
│ Simulation      : 240 ns                 │
│ Timing Status   : UNCONSTRAINED          │
│ Project Status  : COMPLETE               │
└─────────────────────────────────────────┘
```

### Evidence-Based Conclusion

The Day-5 4-bit comparator was successfully functionally verified with **24/24 explicitly reported tests passing**. Cadence Genus synthesized the design into **33 combinational leaf cells** with a reported cell area of **412.474**. The reported power for the supplied simulation frame is **12.1453 µW**. The longest supplied input-to-output data path is **A[3] → LT with 1.080 ns delay**; this path is explicitly **unconstrained**, so no timing-closure or guaranteed Fmax claim is made.

---

## 45. Next Project — Day 6

# 4-Bit ALU

The next project extends the learned comparator and combinational RTL concepts into a larger datapath.

```text
          A[3:0]
             │
             ▼
      ┌──────────────┐
      │              │
B ───►│   4-Bit ALU  │───► Result[3:0]
      │              │
      └──────┬───────┘
             │
          Control
```

### Day-6 Focus

```text
ALU Specification
       ↓
Operation Selection
       ↓
MUX Architecture
       ↓
Arithmetic Logic
       ↓
Verilog RTL
       ↓
Verification
       ↓
Synthesis
       ↓
Timing
       ↓
Power
       ↓
Area
       ↓
PPA Optimization
```

---

## Author

**Omkar Kalmesh Hadapad**

B.E. Electronics & Communication Engineering
SDM Institute of Technology, Ujire, Karnataka

### Focus Areas

```text
Digital VLSI
RTL Design
Verilog / SystemVerilog
ASIC Design
Design Verification
Cadence Genus
Cadence Innovus
Digital Logic
PPA Analysis
```

### Day 5 Complete

**4-Bit Comparator — RTL → Simulation → Verification → Gate-Level Verification → Genus Synthesis → Timing → Power → PPA → Documentation**

**Next: Day 6 — 4-Bit ALU**
