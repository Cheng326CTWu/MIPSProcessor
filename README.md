# MIPSProcessor
## Overview

This project contains implementation of a pipelined and non-pipelined MIPS Processor. Once this project is completed, there will be a more detailed guide detailing
the process which was undertaken in the development of this project in the wiki.

**NOTE:** projects in this repo are done solely without any hardware (i.e. a FPGA dev board). Projects in this repo will eventually be verified on some hardware platform which will be indicated later on in the section below.

## Software Requirement

Any of the below can be used:

* ModelSim + Mentor Graphics Precision RTL **(Optional)**
* Icarus Verilog + GTKWave - **(Should include synthesis option but not tested!)**
* Vivado/ISE
* Quartus Prime

Projects in this repo are compiled using ModelSim. However, efforts will be made to ensure all projects are compilable across all software tools and projects will be synthesizable.

## Hardware Requirement (Optional)

The board(s) listed below are potential requirement which can likely be used for hardware verification later on. It is simply a sort of wish list or future planning which will be executed at an undetermined time in the future.

* DE*XX*-Nano Development Board
* Xilinx FPGA

## Project Progress
### Non-pipelined

This section will outline the progress of the various aspect for this project.

| Modules                       | Current Status        |
|-------------------------------|-----------------------|
| ALU                           | Finished              |
| Decoder                       | Finished              |
| Mux                           | Finished              |
| Data Memory                   | Not Started           |
| Instruction Memory            | Not Started           |
| Register                      | Finished              |
| Control Unit                  | Not Started           |
| MIPS Datapath                 | Not Started           |

### Pipelined

This section will outline the progress of the various aspect for this project.

| Modules                       | Current Status        |
|-------------------------------|-----------------------|
| ALU                           | Not Started           |
| Decoder                       | Not Started           |
| Mux                           | Not Started           |
| Data Memory                   | Not Started           |
| Instruction Memory            | Not Started           |
| Register                      | Not Started           |
| Control Unit                  | Not Started           |
| MIPS Datapath                 | Not Started           |

## Detailed Development Process

**Coming Soon**

## Project Verification

This section will outlines a checklist for what has been verified for the projects in this repo.

| Verification(s)                   | Current Status    |
|-----------------------------------|-------------------|
| Compliable                        | In Progress       |
| Simulation Correctness            | In Progress       |
| Synthesizable                     | In Progress       |
| Hardware Platform Verification    | TBD               |

## Online Compilation Resource

EDA playground is an online "compiler" which allow engineers to simulate various HDLs

* [EDA playground](https://www.edaplayground.com/)
