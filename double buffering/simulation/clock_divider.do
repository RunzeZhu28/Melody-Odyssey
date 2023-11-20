vlib work
vlog clock_divider.v
vsim clock_divider
log {/*}
add wave {/*}
force clk 0 0ns, 1 5ns -r 10ns


force resetn 0
run 10ns
force resetn 1
run 200000000ns

