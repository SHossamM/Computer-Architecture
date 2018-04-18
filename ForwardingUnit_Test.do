vsim work.alu
# vsim work.alu 
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.alu(alu_arch)
add wave -position insertpoint sim:/alu/*
force -freeze sim:/alu/aluOperation 0 0
force -freeze sim:/alu/enable 1 0
force -freeze sim:/alu/cin 0 0
force -freeze sim:/alu/aluOperation 0 0
force -freeze sim:/alu/a 3 0
force -freeze sim:/alu/b 4 0
run
force -freeze sim:/alu/aluOperation 1 0
force -freeze sim:/alu/aluOperation 1 0
run
force -freeze sim:/alu/aluOperation 2 0
run
force -freeze sim:/alu/aluOperation 3 0
run
force -freeze sim:/alu/aluOperation 4 0
run
force -freeze sim:/alu/aluOperation 5 0
force -freeze sim:/alu/aluOperation 5 0
run
force -freeze sim:/alu/aluOperation 7 0
run
force -freeze sim:/alu/aluOperation 8 0
run
force -freeze sim:/alu/aluOperation 9 0
run
force -freeze sim:/alu/aluOperation A 0
run
force -freeze sim:/alu/aluOperation b 0
run
force -freeze sim:/alu/aluOperation c 0
run
force -freeze sim:/alu/aluOperation d 0
run