#System Clock
set_property PACKAGE_PIN E3 [get_ports Sys_Clk]
set_property IOSTANDARD LVCMOS33 [get_ports Sys_Clk]

#RstAsynchronous reset active low
set_property PACKAGE_PIN P18 [get_ports rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports  rst_n]

#choose system frequency
set_property PACKAGE_PIN V10 [get_ports Fre_Choice]
set_property IOSTANDARD LVCMOS33 [get_ports  Fre_Choice]

#select display mode
set_property PACKAGE_PIN M13 [get_ports select[2]]
set_property IOSTANDARD LVCMOS33 [get_ports select[2]]
set_property PACKAGE_PIN L16 [get_ports select[1]]
set_property IOSTANDARD LVCMOS33 [get_ports select[1]]
set_property PACKAGE_PIN J15 [get_ports select[0]]
set_property IOSTANDARD LVCMOS33 [get_ports select[0]]

#set the address to read
set_property PACKAGE_PIN R13 [get_ports address[0]]
set_property IOSTANDARD LVCMOS33 [get_ports address[0]]
set_property PACKAGE_PIN T8 [get_ports address[1]]
set_property IOSTANDARD LVCMOS33 [get_ports address[1]]
set_property PACKAGE_PIN U8 [get_ports address[2]]
set_property IOSTANDARD LVCMOS33 [get_ports address[2]
set_property PACKAGE_PIN R16 [get_ports address[3]]
set_property IOSTANDARD LVCMOS33 [get_ports address[3]]

#set display decimal base



#DP, CG, CF, CE, CD, CC, CB, CA
set_property PACKAGE_PIN H15 [get_ports {Segment[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Segment[7]}]
set_property PACKAGE_PIN L18 [get_ports {Segment[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Segment[6]}]
set_property PACKAGE_PIN T11 [get_ports {Segment[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Segment[5]}]
set_property PACKAGE_PIN P15 [get_ports {Segment[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Segment[4]}]
set_property PACKAGE_PIN K13 [get_ports {Segment[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Segment[3]}]
set_property PACKAGE_PIN K16 [get_ports {Segment[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Segment[2]}]
set_property PACKAGE_PIN R10 [get_ports {Segment[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Segment[1]}]
set_property PACKAGE_PIN T10 [get_ports {Segment[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Segment[0]}]
#AN7, AN6, AN5, AN4, AN3, AN2, AN1, AN0
set_property PACKAGE_PIN U13 [get_ports {LED[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[7]}]
set_property PACKAGE_PIN K2 [get_ports {LED[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[6]}]
set_property PACKAGE_PIN T14 [get_ports {LED[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[5]}]
set_property PACKAGE_PIN P14 [get_ports {LED[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[4]}]
set_property PACKAGE_PIN J14 [get_ports {LED[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[3]}]
set_property PACKAGE_PIN T9 [get_ports {LED[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[2]}]
set_property PACKAGE_PIN J18 [get_ports {LED[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[1]}]
set_property PACKAGE_PIN J17 [get_ports {LED[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[0]}]