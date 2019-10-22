set_property -dict {PACKAGE_PIN W5 IOSTANDARD LVCMOS33} [get_ports {clock}];
create_clock -name clock -period 10 [get_ports clock]
#create_generated_clock -name clock1s -source [get_pins FreqDiv1s/clock] -divide_by 100000000 [get_pins FreqDiv1s/clock_out]

set_property -dict {PACKAGE_PIN R2 IOSTANDARD LVCMOS33} [get_ports {reset}];

set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports {start_stop}];
set_property -dict {PACKAGE_PIN W19 IOSTANDARD LVCMOS33} [get_ports {m}];
set_property -dict {PACKAGE_PIN T17 IOSTANDARD LVCMOS33} [get_ports {s}];

set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS33} [get_ports {alarm_length[0]}];
set_property -dict {PACKAGE_PIN V16 IOSTANDARD LVCMOS33} [get_ports {alarm_length[1]}];
set_property -dict {PACKAGE_PIN W16 IOSTANDARD LVCMOS33} [get_ports {alarm_length[2]}];
set_property -dict {PACKAGE_PIN W17 IOSTANDARD LVCMOS33} [get_ports {alarm_length[3]}];
set_property -dict {PACKAGE_PIN L1 IOSTANDARD LVCMOS33} [get_ports {alarm}];

set_property -dict {PACKAGE_PIN W4 IOSTANDARD LVCMOS33} [get_ports {anodes[3]}];
set_property -dict {PACKAGE_PIN V4 IOSTANDARD LVCMOS33} [get_ports {anodes[2]}];
set_property -dict {PACKAGE_PIN U4 IOSTANDARD LVCMOS33} [get_ports {anodes[1]}];
set_property -dict {PACKAGE_PIN U2 IOSTANDARD LVCMOS33} [get_ports {anodes[0]}];
set_property -dict {PACKAGE_PIN W7 IOSTANDARD LVCMOS33} [get_ports {cathodes[6]}];
set_property -dict {PACKAGE_PIN W6 IOSTANDARD LVCMOS33} [get_ports {cathodes[5]}];
set_property -dict {PACKAGE_PIN U8 IOSTANDARD LVCMOS33} [get_ports {cathodes[4]}];
set_property -dict {PACKAGE_PIN V8 IOSTANDARD LVCMOS33} [get_ports {cathodes[3]}];
set_property -dict {PACKAGE_PIN U5 IOSTANDARD LVCMOS33} [get_ports {cathodes[2]}];
set_property -dict {PACKAGE_PIN V5 IOSTANDARD LVCMOS33} [get_ports {cathodes[1]}];
set_property -dict {PACKAGE_PIN U7 IOSTANDARD LVCMOS33} [get_ports {cathodes[0]}];
set_property -dict {PACKAGE_PIN V7 IOSTANDARD LVCMOS33} [get_ports {dp}];