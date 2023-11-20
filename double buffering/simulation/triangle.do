vlib work
vlog triangle.v
vsim triangle
log {/*}
add wave {/*}
force clk 0 0ns, 1 5ns -r 10ns


force resetn 0
run 30ns

force resetn 1
run 10ns

force x 1
force y 8'b1
run 3400ns

force x 1
force y 8'b10
run 3400ns

force x 1
force y 8'b11
run 30ns