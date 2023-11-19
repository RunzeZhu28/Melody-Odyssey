vlib work
vlog data_generation.v
vsim data_generation
log {/*}
add wave {/*}
force clk 0 0ns, 1 5ns -r 10ns

force resetn 0
run 10ns
force resetn 1
run 2000ns

