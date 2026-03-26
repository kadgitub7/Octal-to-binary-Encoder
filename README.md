# Octal to Binary Encoder | Verilog

![Language](https://img.shields.io/badge/Language-Verilog-blue)
![Tool](https://img.shields.io/badge/Tool-Xilinx%20Vivado-red)
![Type](https://img.shields.io/badge/Type-Combinational%20Logic-green)
![Status](https://img.shields.io/badge/Simulation-Passing-brightgreen)

A Verilog implementation of an **8-input Octal to Binary Encoder**, designed and simulated in **Xilinx Vivado**.

This document explains:
- What an octal to binary encoder is
- How the Boolean expressions are derived
- The truth table, implementation details, and simulation results

The project includes the RTL design, testbench, and console-style output verifying correct behavior.

---

## Table of Contents

1. [What Is an Octal to Binary Encoder?](#what-is-an-octal-to-binary-encoder)
2. [How the Encoder Works](#how-the-encoder-works)
3. [Truth Table](#truth-table)
4. [Boolean Expressions](#boolean-expressions)
5. [Verilog Implementation](#verilog-implementation)
6. [Testbench](#testbench)
7. [Testbench Output](#testbench-output)
8. [Circuit Diagram](#circuit-diagram)
9. [Waveform Diagram](#waveform-diagram)
10. [Running the Project in Vivado](#running-the-project-in-vivado)
11. [Project Files](#project-files)

---

## What Is an Octal to Binary Encoder?

An **octal to binary encoder** is a combinational logic circuit that takes **eight mutually exclusive inputs** — one for each octal digit (0–7) — and produces a **3-bit binary output** (`Y3`, `Y2`, `Y1`).

Each input line represents a single octal digit. When asserted, the circuit encodes that digit into its equivalent 3-bit binary representation.

> **Assumption:** Exactly one input is active at a time (mutually exclusive inputs).

---

## How the Encoder Works

Octal to binary encoding is straightforward. Since octal digits range from 0 to 7, any octal digit can be represented exactly using three binary bits. The encoder maps each of the 8 octal inputs to a unique 3-bit output:

| Active Input | Y3 | Y2 | Y1 | Binary Value |
|:---:|:---:|:---:|:---:|:---:|
| `zero`  | 0 | 0 | 0 | `000` |
| `one`   | 0 | 0 | 1 | `001` |
| `two`   | 0 | 1 | 0 | `010` |
| `three` | 0 | 1 | 1 | `011` |
| `four`  | 1 | 0 | 0 | `100` |
| `five`  | 1 | 0 | 1 | `101` |
| `six`   | 1 | 1 | 0 | `110` |
| `seven` | 1 | 1 | 1 | `111` |

---

## Truth Table

| Input   | Y3 | Y2 | Y1 |
|:-------:|:--:|:--:|:--:|
| `zero`  | 0  | 0  | 0  |
| `one`   | 0  | 0  | 1  |
| `two`   | 0  | 1  | 0  |
| `three` | 0  | 1  | 1  |
| `four`  | 1  | 0  | 0  |
| `five`  | 1  | 0  | 1  |
| `six`   | 1  | 1  | 0  |
| `seven` | 1  | 1  | 1  |

---

## Boolean Expressions

Each output bit is high for the octal inputs where that bit equals `1` in the corresponding binary value:

```
Y3 = four  | five  | six   | seven
Y2 = two   | three | six   | seven
Y1 = one   | three | five  | seven
```

These expressions are read directly from the truth table — `Y3` is the MSB and is only high for inputs 4 through 7; `Y1` is the LSB and is high for all odd values.

---

## Circuit Diagram

Below is a circuit diagram illustrating the OR gate structure used to implement the encoder:

![Octal to Binary Circuit](/imageAssets/OctalBinaryCircuit.png)

---

## Waveform Diagram

Below is the waveform diagram captured when running the simulation using the files in this project:

![Octal to Binary Waveform](/imageAssets/OctalBinaryWaveform.png)

---

## Verilog Implementation

```verilog
`timescale 1ns / 1ps

module octalBinary(
    input  zero, one, two, three, four, five, six, seven,
    output Y3,
    output Y2,
    output Y1
    );

    assign Y3 = four  | five  | six   | seven;
    assign Y2 = two   | three | six   | seven;
    assign Y1 = one   | three | five  | seven;

endmodule
```

---

## Testbench

```verilog
`timescale 1ns / 1ps

module octalBinary_tb();
    reg zero, one, two, three, four, five, six, seven;
    wire Y3, Y2, Y1;

    octalBinary uut(zero, one, two, three, four, five, six, seven, Y3, Y2, Y1);

    task clear_inputs;
    begin
        zero = 0; one = 0; two = 0; three = 0; four = 0;
        five = 0; six = 0; seven = 0;
    end
    endtask

    initial begin
        clear_inputs; zero  = 1; #10 $display("0 -> %b%b%b", Y3, Y2, Y1);
        clear_inputs; one   = 1; #10 $display("1 -> %b%b%b", Y3, Y2, Y1);
        clear_inputs; two   = 1; #10 $display("2 -> %b%b%b", Y3, Y2, Y1);
        clear_inputs; three = 1; #10 $display("3 -> %b%b%b", Y3, Y2, Y1);
        clear_inputs; four  = 1; #10 $display("4 -> %b%b%b", Y3, Y2, Y1);
        clear_inputs; five  = 1; #10 $display("5 -> %b%b%b", Y3, Y2, Y1);
        clear_inputs; six   = 1; #10 $display("6 -> %b%b%b", Y3, Y2, Y1);
        clear_inputs; seven = 1; #10 $display("7 -> %b%b%b", Y3, Y2, Y1);
    end
endmodule
```

---

## Testbench Output

Console output confirming correct octal-to-binary encoding behavior:

```
0 -> 000
1 -> 001
2 -> 010
3 -> 011
4 -> 100
5 -> 101
6 -> 110
7 -> 111
```

**Verification summary:**
- `Y3` is `1` only for inputs `4` through `7` — the MSB of binary values ≥ 4
- `Y2` is `1` for inputs `2`, `3`, `6`, and `7`
- `Y1` is `1` for all odd inputs: `1`, `3`, `5`, and `7`

---

## Running the Project in Vivado

### 1. Launch Vivado

Open **Xilinx Vivado**.

### 2. Create a New RTL Project

1. Click **Create Project**
2. Select **RTL Project**
3. Optionally enable *Do not specify sources at this time*, or add source files directly

### 3. Add Source Files

| Role              | File                  |
|-------------------|-----------------------|
| Design Source     | `octalBinary.v`       |
| Simulation Source | `octalBinary_tb.v`    |

> Set `octalBinary_tb.v` as the **simulation top module**.

### 4. Run Behavioral Simulation

Navigate to:

```
Flow → Run Simulation → Run Behavioral Simulation
```

Observe the signals in the waveform viewer:

```
Inputs : zero, one, two, three, four, five, six, seven
Outputs: Y3, Y2, Y1
```

Verify that the waveform output matches the truth table and the console output listed above.

---

## Project Files

| File                | Description                                                          |
|---------------------|----------------------------------------------------------------------|
| `octalBinary.v`     | Octal to binary encoder RTL module                                   |
| `octalBinary_tb.v`  | Testbench — applies all 8 octal inputs and displays binary output    |

---

## Author

**Kadhir Ponnambalam**

---

*Designed and simulated using Xilinx Vivado.*
