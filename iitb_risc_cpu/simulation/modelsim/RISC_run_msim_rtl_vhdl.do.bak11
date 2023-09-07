transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/HP/Downloads/cpu0612/IITB-Pipe-CPU/DUT.vhdl}
vcom -93 -work work {C:/Users/HP/Downloads/cpu0612/IITB-Pipe-CPU/reg_hazard.vhd}
vcom -93 -work work {C:/Users/HP/Downloads/cpu0612/IITB-Pipe-CPU/Stage_6.vhd}
vcom -93 -work work {C:/Users/HP/Downloads/cpu0612/IITB-Pipe-CPU/Stage_5.vhd}
vcom -93 -work work {C:/Users/HP/Downloads/cpu0612/IITB-Pipe-CPU/Stage_4.vhd}
vcom -93 -work work {C:/Users/HP/Downloads/cpu0612/IITB-Pipe-CPU/Stage_1.vhd}
vcom -93 -work work {C:/Users/HP/Downloads/cpu0612/IITB-Pipe-CPU/register_1bit.vhd}
vcom -93 -work work {C:/Users/HP/Downloads/cpu0612/IITB-Pipe-CPU/six_extender.vhd}
vcom -93 -work work {C:/Users/HP/Downloads/cpu0612/IITB-Pipe-CPU/register_file.vhd}
vcom -93 -work work {C:/Users/HP/Downloads/cpu0612/IITB-Pipe-CPU/mux-two-to-one-16bit.vhd}
vcom -93 -work work {C:/Users/HP/Downloads/cpu0612/IITB-Pipe-CPU/mux-four-to-one-16bit.vhd}
vcom -93 -work work {C:/Users/HP/Downloads/cpu0612/IITB-Pipe-CPU/Instruction_Memory.vhd}
vcom -93 -work work {C:/Users/HP/Downloads/cpu0612/IITB-Pipe-CPU/extender.vhd}
vcom -93 -work work {C:/Users/HP/Downloads/cpu0612/IITB-Pipe-CPU/Data_Memory.vhd}
vcom -93 -work work {C:/Users/HP/Downloads/cpu0612/IITB-Pipe-CPU/clock.vhd}
vcom -93 -work work {C:/Users/HP/Downloads/cpu0612/IITB-Pipe-CPU/alu.vhd}
vcom -93 -work work {C:/Users/HP/Downloads/cpu0612/IITB-Pipe-CPU/Datapath.vhd}
vcom -93 -work work {C:/Users/HP/Downloads/cpu0612/IITB-Pipe-CPU/Controller.vhd}
vcom -93 -work work {C:/Users/HP/Downloads/cpu0612/IITB-Pipe-CPU/Pipeline_Register.vhd}
vcom -93 -work work {C:/Users/HP/Downloads/cpu0612/IITB-Pipe-CPU/Temp_Register.vhd}
vcom -93 -work work {C:/Users/HP/Downloads/cpu0612/IITB-Pipe-CPU/Add_Immediate.vhd}
vcom -93 -work work {C:/Users/HP/Downloads/cpu0612/IITB-Pipe-CPU/decider.vhd}
vcom -93 -work work {C:/Users/HP/Downloads/cpu0612/IITB-Pipe-CPU/Stage_2.vhd}
vcom -93 -work work {C:/Users/HP/Downloads/cpu0612/IITB-Pipe-CPU/Stage_3.vhd}
vcom -93 -work work {C:/Users/HP/Downloads/cpu0612/IITB-Pipe-CPU/mux-four-to-one-3bit.vhd}
vcom -93 -work work {C:/Users/HP/Downloads/cpu0612/IITB-Pipe-CPU/BigPreg.vhd}
vcom -93 -work work {C:/Users/HP/Downloads/cpu0612/IITB-Pipe-CPU/mem_hazard.vhd}

vcom -93 -work work {C:/Users/HP/Downloads/cpu0612/IITB-Pipe-CPU/Testbench.vhdl}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L fiftyfivenm -L rtl_work -L work -voptargs="+acc"  Testbench

add wave *
view structure
view signals
run -all
