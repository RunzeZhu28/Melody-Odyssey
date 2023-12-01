# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog PS2_Top.v

#load simulation using mux as the top level simulation module
vsim PS2_Top

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {iClock} 0 0ns, 1 {5ns} -r 10ns
run 10ns

force {iResetn} 0
run 10ns
force {iResetn} 1
run 10ns

# D pressed
force {iPS2_Dat} 0
run 1ns

force {iPS2_Dat} 0
run 1ns

force {iPS2_Dat} 1
run 1ns

force {iPS2_Dat} 0
run 1ns

force {iPS2_Dat} 0
run 1ns

force {iPS2_Dat} 0
run 1ns

force {iPS2_Dat} 1
run 1ns

force {iPS2_Dat} 1
run 1ns


# F pressed
force {iPS2_Dat} 0
run 1ns

force {iPS2_Dat} 0
run 1ns

force {iPS2_Dat} 1
run 1ns

force {iPS2_Dat} 0
run 1ns

force {iPS2_Dat} 1
run 1ns

force {iPS2_Dat} 0
run 1ns

force {iPS2_Dat} 1
run 1ns

force {iPS2_Dat} 1
run 1ns

# F break
force {iPS2_Dat} 1
run 1ns

force {iPS2_Dat} 1
run 1ns

force {iPS2_Dat} 1
run 1ns

force {iPS2_Dat} 1
run 1ns

force {iPS2_Dat} 0
run 1ns

force {iPS2_Dat} 0
run 1ns

force {iPS2_Dat} 0
run 1ns

force {iPS2_Dat} 0
run 1ns

force {iPS2_Dat} 0
run 1ns

force {iPS2_Dat} 0
run 1ns

force {iPS2_Dat} 1
run 1ns

force {iPS2_Dat} 0
run 1ns

force {iPS2_Dat} 1
run 1ns

force {iPS2_Dat} 0
run 1ns

force {iPS2_Dat} 1
run 1ns

force {iPS2_Dat} 1
run 1ns

