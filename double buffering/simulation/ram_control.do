vlib work
vlog ram_control.v
vsim ram_control
log {/*}
add wave {/*}
force clk 0 0ns, 1 5ns -r 10ns

force resetn 0
run 10ns
force resetn 1
force data_en 1
force data 1
run 10ns

force data 8'b11
run 10ns

force data 8'b100
run 10ns

force data 8'b101
run 10ns

force data 8'b110
run 10ns

force data 8'b111
run 30ns