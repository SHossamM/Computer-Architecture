vsim work.pc_fetch
# vsim work.pc_fetch 
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.pc_fetch(pc_fetch_arc)
# Loading work.mux2x1(mux2x1_arch)
# Loading work.n_bitadder(arch_n_bitadder)
# Loading work.fulladder(arch_fulladder)
# Loading work.mux4x1(mux4x1_arch)
# Loading work.registern(registerarch)
# Loading work.pfetchunit(archpfetchunit)
# Loading work.pmemory(archpmemory)
mem load -i {E:/CCE Files/Semster6/arch/spring18/Computer-Architecture/Assembler/instructions.mem} /pc_fetch/INS_MEM/mem/ram
add wave sim:/pc_fetch/*
force -freeze sim:/pc_fetch/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/pc_fetch/reset 1 0
run
force -freeze sim:/pc_fetch/reset 0 0
force -freeze sim:/pc_fetch/PC_ADDER_MUX_SELECT 0 0
force -freeze sim:/pc_fetch/Rdst_signal 0 0
force -freeze sim:/pc_fetch/JUMP_CALL 0 0
force -freeze sim:/pc_fetch/pc_enable 1 0
force -freeze sim:/pc_fetch/pc_enable 0 0
force -freeze sim:/pc_fetch/Mem0 5 0
force -freeze sim:/pc_fetch/Mem1 1 0
force -freeze sim:/pc_fetch/WB_Value 2 0
force -freeze sim:/pc_fetch/exe_Rd_out 3 0
force -freeze sim:/pc_fetch/Port2dataout 1 0
force -freeze sim:/pc_fetch/PC_Select 2 0
run
run
force -freeze sim:/pc_fetch/pc_enable 1 0
run
force -freeze sim:/pc_fetch/pc_enable 0 0
run
run
run
force -freeze sim:/pc_fetch/pc_enable 1 0
force -freeze sim:/pc_fetch/PC_Select 1 0
run
force -freeze sim:/pc_fetch/PC_Select 0 0
run
force -freeze sim:/pc_fetch/PC_Select 3 0
run