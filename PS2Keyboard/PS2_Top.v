module PS2_Top(
    input iClock,
    input iReset,

    inout iPS2_Clock,
    inout iPS2_Dat,

    output [5:0] iPS2_Key_Pressed
);

wire [7:0] PS2_Data;
wire ps2_key_pressed;
reg [7:0] last_data_received;

always@(posedge iClock) begin
    if(iReset) begin
        last_data_received <= 0;
    end
    else if(ps2_key_pressed)
        last_data_received <= PS2_Data;
    else
        last_data_received <= 0;
end

PS2_Controller u1(
    .CLOCK_50(iClock),
    .reset(iReset),

    .PS2_CLK(iPS2_Clock),
    .PS2_DAT(iPS2_Dat),

    .received_data(PS2_Data),
    .received_data_en(ps2_key_pressed)
);

PS2_Keyboard u2(
    .PS2_Clock(iPS2_Clock),
    .PS2_Data(last_data_received),

    .PS2_Key_Pressed(iPS2_Key_Pressed)
);

endmodule
