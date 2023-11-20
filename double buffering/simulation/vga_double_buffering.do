vlib work
vlog vga_double_buffering.v
vlog ram1.v
vlog data_generation.v
vlog clock_divider.v
vlog ram_control.v
vlog triangle.v
vsim -L altera_mf_ver vga_double_buffering
log {/*}
add wave {/*}
add wave {/vga_double_buffering/triangle_inst/*}
force clk 0 0ns, 1 5ns -r 10ns

force resetn 0
run 10ns
force resetn 1
run 1000000000ns