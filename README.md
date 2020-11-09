# vivado-single-cycle-cpu
verilog
project structure:
D:.
├─CPU1.cache

│  ├─compile_simlib

│  │  ├─activehdl

│  │  ├─ies

│  │  ├─modelsim

│  │  ├─questa

│  │  ├─riviera

│  │  ├─vcs

│  │  └─xcelium

│  ├─ip

│  │  └─2018.3

│  │      ├─0dac7d9d53d00849

│  │      ├─0dc483973991f367

│  │      └─6ec18b91f3015eb7

│  └─wt

├─CPU1.hw

├─CPU1.ip_user_files

│  ├─ip

│  │  ├─cpuclk

│  │  ├─prgrom

│  │  └─ram

│  ├─ipstatic

│  │  └─simulation

│  ├─mem_init_files

│  └─sim_scripts

│      ├─cpuclk

│      │  ├─activehdl

│      │  ├─ies

│      │  ├─modelsim

│      │  ├─questa

│      │  ├─riviera

│      │  ├─vcs

│      │  ├─xcelium

│      │  └─xsim
│      ├─prgrom

│      │  ├─activehdl

│      │  ├─ies

│      │  ├─modelsim

│      │  ├─questa

│      │  ├─riviera

│      │  ├─vcs

│      │  ├─xcelium

│      │  └─xsim

│      └─ram

│          ├─activehdl

│          ├─ies

│          ├─modelsim

│          ├─questa

│          ├─riviera

│          ├─vcs

│          ├─xcelium

│          └─xsim

├─CPU1.runs

│  ├─.jobs

│  ├─cpuclk_synth_1

│  │  └─.Xil

│  ├─impl_1

│  │  └─.Xil

│  ├─prgrom_synth_1

│  │  └─.Xil

│  ├─ram_synth_1

│  │  └─.Xil

│  └─synth_1

│      └─.Xil

├─CPU1.sim

│  └─sim_1

│      └─behav

│          └─xsim

│              ├─.Xil

│              │  ├─Webtalk-14776-612-40

│              │  │  └─webtalk

│              │  ├─Webtalk-16188-612-40

│              │  │  └─webtalk

│              │  ├─Webtalk-19376-DESKTOP-HS73DI4

│              │  │  └─webtalk

│              │  ├─Webtalk-20288-DESKTOP-HS73DI4

│              │  │  └─webtalk

│              │  ├─Webtalk-21948-DESKTOP-HS73DI4

│              │  │  └─webtalk

│              │  ├─Webtalk-22576-DESKTOP-HS73DI4

│              │  │  └─webtalk

│              │  └─Webtalk-8496-DESKTOP-HS73DI4

│              │      └─webtalk

│              └─xsim.dir

│                  ├─alu_sim_behav

│                  │  ├─obj

│                  │  └─webtalk

│                  ├─mycpu_tb_behav

│                  │  ├─obj

│                  │  └─webtalk

│                  ├─rf_sim_behav

│                  │  ├─obj

│                  │  └─webtalk

│                  └─xil_defaultlib

└─CPU1.srcs

    ├─sim_1
    
    │  └─new
    
    ├─sourc
    
    │  ├─clk_wiz_0
    
    │  │  └─doc
    
    │  ├─cpuclk
    
    │  │  └─doc
    
    │  ├─cpuclk_1
    
    │  │  └─doc
    
    │  ├─prgrom
    
    │  │  ├─doc
    
    │  │  ├─hdl
    
    │  │  ├─misc
    
    │  │  ├─sim
    
    │  │  ├─simulation
    
    │  │  └─synth
    
    │  └─ram
    
    │      ├─doc
    
    │      ├─hdl
    
    │      ├─misc
    
    
    │      ├─sim
    
    │      ├─simulation
    
    │      └─synth
    
    └─sources_1 (important code here)
    
    ├─ip
    
    │  ├─cpuclk
    
    │  │  └─doc
    
    │  ├─prgrom
    
    │  │  ├─doc
    
    │  │  ├─hdl
    
    │  │  ├─misc
    
    │  │  ├─sim
    
    │  │  ├─simulation
    
    │  │  └─synth
    
    │  └─ram
    
    │      ├─doc
    
    │      ├─hdl
    
    │      ├─misc
    
    │      ├─sim
    
    │      ├─simulation
    
    │      └─synth
    
    └─new
