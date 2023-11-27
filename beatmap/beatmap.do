vlib work
vlog beat.v
vlog clock_divider.v
vlog notes.v
vsim beat
log {/*}
add wave {/*}
add wave {/beat/U1/*}
add wave {/beat/U2/*}
add wave {/beat/U3/*}

force clk 0 0ns, 1 5ns -r 10ns

force resetn 0
run 10ns
force resetn 1
run 100000000000000ns
