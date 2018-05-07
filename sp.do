vsim work.sp
# vsim work.sp 
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.sp(sp_arc)
add wave -position insertpoint sim:/sp/*
force -freeze sim:/sp/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/sp/reset 1 0
force -freeze sim:/sp/popsig 0 0
force -freeze sim:/sp/pushsig 0 0
run
force -freeze sim:/sp/reset 0 0
force -freeze sim:/sp/pushsig 1 0
run
force -freeze sim:/sp/popsig 1 0
force -freeze sim:/sp/pushsig 0 0
run
run
run
force -freeze sim:/sp/popsig 0 0
force -freeze sim:/sp/pushsig 1 0
run
run
run
run