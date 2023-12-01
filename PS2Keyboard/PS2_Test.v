module PS2_Test(
    input iClock,
    input iReset,

    inout iPS2_Clock,
    inout iPS2_Dat,

	 output [5:0] LEDR
)；

PS2_Top U1(
    .iClock(iClock),
	 .iiReset(iReset),
	 
    .PS2_Data(last_data_received),
	 .iPS2_Dat(iPS2_Dat),

	.PS2_Key_Pressed(LEDR)

)

endmodule
