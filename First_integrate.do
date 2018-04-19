
vsim work.first_integrate
# vsim work.first_integrate 
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.first_integrate(first_integrate_arch)
# Loading work.mux2x1(mux2x1_arch)
# Loading work.registerfile(registerfilearch)
# Loading work.registern(registerarch)
# Loading work.reg(reg_arch)
# Loading work.mux4x1_1bit(mux4x1_1bit_arch)
# Loading work.mux4x1(mux4x1_arch)
# Loading ieee.numeric_std(body)
# Loading work.alu(alu_arch)
# Loading work.mux8x1(mux8x1_arch)
# Loading work.pmemoryunit(archpmemoryunit)
# Loading work.pmemory(archpmemory)
add wave -r /*
force -freeze sim:/first_integrate/port1_selec 0 0
force -freeze sim:/first_integrate/port2_selec 1 0
force -freeze sim:/first_integrate/port1_selec 0 0
force -freeze sim:/first_integrate/port2_selec 1 0
force -freeze sim:/first_integrate/Imediate_mem_out 0c00 0
force -freeze sim:/first_integrate/mem_WB_signal_out 1 0
force -freeze sim:/first_integrate/mem_destination_select_out 0 0
force -freeze sim:/first_integrate/WB_value 2 0
force -freeze sim:/first_integrate/DEnable 1 0
force -freeze sim:/first_integrate/Read_Enable 1 0
force -freeze sim:/first_integrate/Aenable 0 0
run
force -freeze sim:/first_integrate/clk 1 0, 0 {50 ps} -r 100
run
force -freeze sim:/first_integrate/port2_selec 3 0
run
restart -f
force -freeze sim:/first_integrate/port1_selec 3 0
force -freeze sim:/first_integrate/Imediate_mem_out c00 0
force -freeze sim:/first_integrate/mem_WB_signal_out 1 0
force -freeze sim:/first_integrate/mem_destination_select_out 0 0
force -freeze sim:/first_integrate/WB_value 2 0
force -freeze sim:/first_integrate/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/first_integrate/DEnable 1 0
force -freeze sim:/first_integrate/Read_Enable 1 0
force -freeze sim:/first_integrate/Aenable 0 0
run
force -freeze sim:/first_integrate/mem_destination_select_out 1 0
force -freeze sim:/first_integrate/port2_selec 0 0
force -freeze sim:/first_integrate/WB_value 0002 0
force -freeze sim:/first_integrate/WB_value 0003 0
force -freeze sim:/first_integrate/Aenable 1 0
force -freeze sim:/first_integrate/alu_op_select 1 0
force -freeze sim:/first_integrate/A_Select 0 0
force -freeze sim:/first_integrate/B_Select 0 0
force -freeze sim:/first_integrate/aluOperation 1 0
force -freeze sim:/first_integrate/alu_op_select 3 0
run
run
mem load -i {E:/CCE Files/Semster6/arch/spring18/Computer-Architecture/pmemoryMemoryUnit.mem} /first_integrate/memoryunit/mem/ram
force -freeze sim:/first_integrate/exe_WB_Dest_Select_out 1 0
force -freeze sim:/first_integrate/exe_Mem_Write_Address_Select_out 0 0
force -freeze sim:/first_integrate/exe_MW_out 1 0
run
mem save -o {E:/CCE Files/Semster6/arch/spring18/Computer-Architecture/pmemoryMemoryUnit.mem} -f {} /first_integrate/memoryunit/mem/ram