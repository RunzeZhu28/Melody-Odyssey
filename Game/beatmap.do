vlib work
vlog beat.v
vlog clock_divider.v
vlog notes.v
vlog y_update.v
vlog y_update_1.v
vlog y_update_2.v
vlog y_update_3.v
vlog y_update_4.v
vlog y_update_5.v
vlog y_update_6.v
vlog y_update_7.v
vlog y_update_8.v
vlog y_update_9.v
vlog y_update_10.v
vlog vga_double_buffering.v
vlog vga_double_buffering_1.v
vlog vga_double_buffering_2.v
vlog vga_double_buffering_3.v
vlog vga_double_buffering_4.v
vlog vga_double_buffering_5.v
vlog vga_double_buffering_6.v
vlog vga_double_buffering_7.v
vlog vga_double_buffering_8.v
vlog vga_double_buffering_9.v
vlog vga_double_buffering_10.v
vlog double_buffering.v
vlog ram1.v
vlog controlpath.v
vsim -L altera_mf_ver beat
log {/*}
add wave {/*}

add wave {/beat/screen}
add wave {/beat/y_position}
add wave {/beat/control_path_inst/current}

force clk 0 0ns, 1 5ns -r 10ns

force resetn 0
run 1000ns
force resetn 1
force key_1 0
force key_2 0
run 1000ns

force key_1 1
force key_2 0
run  1000ns
force key_1 0
run 10000000000ns

force key_2 1
run 10ns

force key_1 1
run 10ns

run 1000000000ns