module top(
	input 	logic	[3:0]   dip,
	output 	logic   [6:0]   seg,
    output  logic   [2:0]   led,
);

	// High Frequency 48MHz Oscillator
	logic int_osc;
    HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
    
    // Oscillator-based Counter which divides by 20million to get frequency 2.4Hz
	logic [24:0] counter = 0;
    always_ff @(posedge int_osc)
		if (counter < 25'd20_000_000) counter <= counter + 1;
        else    counter <= 0;
		
    // LED Output Logic
    assign led[0] = dip[1] | dip[0];
    assign led[1] = dip[3] & dip[2];
    assign led[2] = counter[24];

    // Segment Logic
    always_comb
        case (dip)
            4'x0: seg <= 6'b1111110
            4'x1: seg <= 6'b1001000
            4'x2: seg <= 6'b0111101
            4'x3: seg <= 6'b1101101
            4'x4: seg <= 6'b1001011
            4'x5: seg <= 6'b1100111
            4'x6: seg <= 6'b1110111
            4'x7: seg <= 6'b1001100
            4'x8: seg <= 6'b1111111
            4'x9: seg <= 6'b1001111
            4'xa: seg <= 6'b1011111
            4'xb: seg <= 6'b1110011
            4'xc: seg <= 6'b0110001
            4'xd: seg <= 6'b1111001
            4'xe: seg <= 6'b0110111
            4'xf: seg <= 6'b0010111
            default: 
        endcase


endmodule