vsim work.forwardingunit
# vsim work.forwardingunit 
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.forwardingunit(forwardingunit_arch)
add wave -position insertpoint sim:/forwardingunit/*
force -freeze sim:/forwardingunit/exec_mem_regwrite 0 0
force -freeze sim:/forwardingunit/mem_wb_regwrite 1 0
force -freeze sim:/forwardingunit/id_exec_Rs 2 0
force -freeze sim:/forwardingunit/id_exec_Rd 3 0
force -freeze sim:/forwardingunit/exec_mem_Rs 3 0
force -freeze sim:/forwardingunit/exec_mem_Rd 4 0
force -freeze sim:/forwardingunit/mem_wb_Rd 1 0
force -freeze sim:/forwardingunit/control_a_select 0 0
force -freeze sim:/forwardingunit/control_b_select 0 0
force -freeze sim:/forwardingunit/exec_mem_regwrite 1 0
run
force -freeze sim:/forwardingunit/mem_wb_Rd 2 0
run
force -freeze sim:/forwardingunit/id_exec_Rs 3 0
force -freeze sim:/forwardingunit/id_exec_Rd 2 0
run
force -freeze sim:/forwardingunit/id_exec_Rs 4 0
force -freeze sim:/forwardingunit/id_exec_Rd 5 0
force -freeze sim:/forwardingunit/exec_mem_Rs 3 0
force -freeze sim:/forwardingunit/exec_mem_Rd 2 0
force -freeze sim:/forwardingunit/mem_wb_Rd 2 0
run