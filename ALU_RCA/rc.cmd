# Cadence Encounter(R) RTL Compiler
#   version v10.10-s209_1 (32-bit) built Feb  3 2011
#


set_attribute library {{/chalmers/sw/sup/cds/cmos065-5.3.4/CORE65LPSVT_5.1/libs/CORE65LPSVT_nom_1.20V_25C.lib}}
read_hdl ALU_RCA.vhdl  ALU_TB.vhdl  RCA.vhdl  full_adder.vhdl  logic_unit.vhdl  shifter.vhdl  sltu.vhdl
clear
read_hdl ALU_RCA.vhdl RCA.vhdl  full_adder.vhdl  logic_unit.vhdl  shifter.vhdl  sltu.vhdl
read_hdl -vhdl ALU_RCA.vhdl RCA.vhdl  full_adder.vhdl  logic_unit.vhdl  shifter.vhdl  sltu.vhdl
elaborate
gui_show
synthesize -to_mapped -effort low
report timing
report gates
report gates > gates_report.txt
report timing > timing_report.txt
report timing > timing_report.txt
define_clock -name main_clk -period 2375 [find / -port Clk]
report timing
synthesize -to_mapped -effort medium
report timing
report timing > timing_report_50.txt
report gates > gates_report_50.txt
define_clock -name main_clk -period 1000 [find / -port Clk]
report timing
synthesize -to_mapped -effort medium
report timing
report timing > timing_report_1ghz.txt
report gates > gates_report_1ghz.txt
report gates
define_clock -name main_clk -period 1910 [find / -port Clk]
synthesize -to_mapped -effort medium
report timing
define_clock -name main_clk -period 1950 [find / -port Clk]
synthesize -to_mapped -effort medium
report timing
define_clock -name main_clk -period 2000 [find / -port Clk]
synthesize -to_mapped -effort medium
report timing
define_clock -name main_clk -period 2100 [find / -port Clk]
synthesize -to_mapped -effort medium
report timing
write_hdl > ALU_RCA_netlist.v
report gates > gates_report_final.txt
report timing > timing_report_final.txt
write_hdl > ALU_RCA_netlist.v
