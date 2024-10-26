# OpenC906 Simulation Platform

Github: https://github.com/Irisaka/OpenC906_WSL_SIM

Based on https://github.com/XUANTIE-RV/openc906, the simulation platform of **C906** on **WSL** is adjusted and verified. This platform is used for behavioral simulation of C906 on **FPGA** and is used in conjunction with https://github.com/Irisaka/OpenC906_FPGA.

Some key directories are shown below.

```
|--C906_RTL_FACRORY/
  |--gen_rtl/     ##the source verilog code of C906 
  |--setup/       ##set the environment variables
|--smart_run/     ##the RTL simulation environment
  |--impl/        ##sdc file
  |--logical/     ##the SoC demo and test bench to run the simulation 
  |--setup/       ##GNU tool chain setting
  |--tests/       ##include the test suit, linker file, boot code and so on
  |--work/        ##the working directory
  |--Makefile     ##the simulation script
|--doc/           ##the user and integration manual of C906
|--ram_init_file/ ##the instruction and data initialization file
```

## Environment and Prerequisite

* WSL version:

```
Ubuntu 20.04.6 LTS
Linux DESKTOP-xxx 5.15.153.1-microsoft-standard-WSL2
```

* Make
* Icarus Verilog (iverilog) or Synopsys VCS

## Usage

  Step1: Get Started
```
$ cd C906_RTL_FACTORY
$ source setup/setup.csh
$ cd ../smart_run
$ make help
To gain more information about how to use smart testbench.
```

  Step2: Download and install C/C++ Compiler

```
You can download the GNU tool chain compiled by T-HEAD from the url below:
https://www.xrvm.cn/community/download?id=4352528597269942272

$ cd ./smart_run
GNU tool chain (specific riscv version) must be installed and specified before
compiling *.c/*.v tests of the smart environment. Please refer to the following
setup file about how to specify it: 
    ./smart_run/setup/example_setup.csh
After linked to toolchain:
$ source setup/example_setup.csh
```

Step 3: Compile and runcase

```
$ make showcase
$ make clean
$ make runcase CASE=xxx

Then output:
|--work/
  |--inst.pat      ## machine code of instruction
  |--data.pat      ## machine code of data
  |--...
Move 'inst.pat' and 'data.pat' to ram_init_file/, use 'inst_data_split_ram.m' (Matlab file) to generate 16 splited files, which will be used in RAM initialization in FPGA. 
```



## Notes

```
The testbench supports iverilog, vcs and irun to run simulation and you can use Gtkwave or verdi to open the waveform under ./smart_run/work/ directory.

You can get the debugger, IDE and SDK from the url:https://www.xrvm.cn/community/download?id=4313363375687012352
```



#/*Copyright 2020-2021 T-Head Semiconductor Co., Ltd.
#
#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at
#

###    http://www.apache.org/licenses/LICENSE-2.0
#
#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an "AS IS" BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.
#*/
