module PS2_Keyboard(
    input PS2_Clock,
    input [7: 0] PS2_Data,


    output reg [5:0] PS2_Key_Pressed
);
    parameter ENTER = 8'h5A;        //PS2_Key_Pressed[0] = 1
    parameter D     = 8'h23;        //PS2_Key_Pressed[1] = 1
    parameter F     = 8'h2B;        //PS2_Key_Pressed[2] = 1
    parameter J     = 8'h3B;        //PS2_Key_Pressed[3] = 1
    parameter K     = 8'h42;        //PS2_Key_Pressed[4] = 1
    parameter ESC   = 8'h76;        //PS2_Key_Pressed[5] = 1
	 parameter Break = 8'hF0;        //PS2_Key_Pressed[i] = 0 when Break is detected

    reg [15:0] PS2_Data_Reg;

    always@(posedge PS2_Clock) begin
        PS2_Data_Reg <= {PS2_Data_Reg[7:0], PS2_Data};
    end


    always@(posedge PS2_Clock) begin
        if (PS2_Data_Reg[15:8] == Break) begin
            case (PS2_Data_Reg[7:0])
                ENTER: begin
                    PS2_Key_Pressed[0] <= 1'b0;
                end
                D: begin
                    PS2_Key_Pressed[1] <= 1'b0;
                end
                F: begin
                    PS2_Key_Pressed[2] <= 1'b0;
                end
                J: begin
                    PS2_Key_Pressed[3] <= 1'b0;
                end
                K: begin
                    PS2_Key_Pressed[4] <= 1'b0;
                end
                ESC: begin
                    PS2_Key_Pressed[5] <= 1'b0;
                end
                //default: begin    
                //dnt know whether it is necessary to have a default case here
            endcase
        end
        else begin
            case (PS2_Data_Reg[7:0])
                ENTER: begin
                    PS2_Key_Pressed[0] <= 1'b1;
                end
                D: begin
                    PS2_Key_Pressed[1] <= 1'b1;
                end
                F: begin
                    PS2_Key_Pressed[2] <= 1'b1;
                end
                J: begin
                    PS2_Key_Pressed[3] <= 1'b1;
                end
                K: begin
                    PS2_Key_Pressed[4] <= 1'b1;
                end
                ESC: begin
                    PS2_Key_Pressed[5] <= 1'b1;
                end
            default: begin
                    PS2_Key_Pressed <= 6'b0;
                end
            endcase
        end
    end


endmodule
/*

module PS2_Controller_FSM(
    input [7: 0] PS2_Data,
    input PS2_Clock,

    output reg [3:0] PS2_State,
    output reg [3:0] PS2_Key_Pressed
);

    // State PS2 Key Pressed Parameters
    parameter ENTER = 8'h5A;
    parameter D     = 8'h23;
    parameter F     = 8'h2B;
    parameter J     = 8'h3B;
    parameter K     = 4'h42;
    parameter ESC   = 4'h76;

    // State State Parameters
    parameter IDLE = 4'd0;
    parameter ENTER_PRESSED = 4'd1;
    parameter D_PRESSED = 4'd2;
    parameter F_PRESSED = 4'd3;
    parameter J_PRESSED = 4'd4;
    parameter K_PRESSED = 4'd5;
    parameter ESC_PRESSED = 4'd6;

    // the following TBD

    // State Machine Combinational Logic
    always @(*) begin
        case (PS2_Data)
            IDLE: begin
                PS2_Key_Pressed <= 4'd0;
            end
            ENTER: begin
                PS2_Key_Pressed <= 4'd1;
            end
            D: begin
                PS2_Key_Pressed <= 4'd2;
            end
            F: begin
                PS2_Key_Pressed <= 4'd3;
            end
            J: begin
                PS2_Key_Pressed <= 4'd4;
            end
            K: begin
                PS2_Key_Pressed <= 4'd5;
            end
            ESC: begin
                PS2_Key_Pressed <= 4'd6;
            end
        endcase
    end

endmodule

*/


/*

module PS2_Controller_FSM(
    // This module only allows one input at a time
    input [7: 0] PS2_Data,
    input PS2_Clock,

    output reg [3:0] PS2_State
);

    // State Machine Parameters
    parameter ENTER = 8'h5A;
    parameter D_PRESSED     = 8'h23;
    parameter F_PRESSED     = 8'h2B;
    parameter J_PRESSED     = 8'h3B;
    parameter K_PRESSED     = 8'h42;
    parameter ESC_PRESSED   = 8'h76;

    parameter ENTER_Break   = 8'hF0;
    parameter D_Break       = 8'hDC;
    parameter F_break       = 8'hD4;
    parameter J_Break       = 8'hC4;
    parameter K_Break       = 8'hCC;
    parameter ESC_Break     = 8'hF0;

    // the following TBD

    // State Machine Combinational Logic
    always @(*) begin
        case (PS2_Data)
            IDLE: begin
                PS2_State <= 4'd0;
            end
            ENTER: begin
                PS2_State <= 4'd1;
            end
            D: begin
                PS2_State <= 4'd2;
            end
            F: begin
                PS2_State <= 4'd3;
            end
            J: begin
                PS2_State <= 4'd4;
            end
            K: begin
                PS2_State <= 4'd5;
            end
            ESC: begin
                PS2_State <= 4'd6;
            end
        endcase
    end

endmodule

*/



