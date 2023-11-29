vlib work
vlog beat.v
vlog clock_divider.v
vlog vga_double_buffering.v
vlog ram1.v
vlog ram_control.v
vlog notes.v
vlog data_generation.v
vsim -L altera_mf_ver beat
log {/*}
add wave {/*}


add wave {/beat/screen}
add wave {/beat/y_position}


force clk 0 0ns, 1 5ns -r 10ns

force resetn 0
run 10ns
force resetn 1
run 100000000000000ns