module ALU (clock, data, control, Acc, carry, zero, overf, sign);
    parameter width = 16;
    input clock;
    input [width-1 : 0] data;
    input [2:0] control;
    output reg [width-1 : 0] Acc;
    output reg carry;
    output zero;
    output reg overf;
    output sign;

    assign sign = Acc[width-1];
    assign zero = ~(|Acc[width - 1 : 0]);
    

    always @ (posedge clock)
    begin
        case (control)
            3'b000 : // Hold
            begin
                carry = 0;
                overf = 0;
            end
            3'b001 : // Clear
            begin
                Acc = 0;
                carry = 0;
                overf = 0;
            end
            3'b010 : // Add
            begin
                {carry, Acc} = Acc + data;
                if (Acc[width - 1] == data[width - 1] &&  ((Acc + data) >> (width - 1)) & 1'b1  !=  (Acc >> (width - 1))& 1'b1 )
                    overf = 1;
                else
                    overf = 0;    
            end
            3'b011 : // Sub
            begin
                {carry, Acc} = Acc - data;
                if (Acc[width - 1] != data[width - 1] &&  ((Acc - data) >> (width - 1)) & 1'b1  !=  (Acc >> (width - 1))& 1'b1 )
                    overf = 1;
                else
                    overf = 0; 
            end
            3'b100 : // And
            begin
                Acc = Acc & data;
                carry = 0;
                overf = 0;
            end
            3'b101 : // Neg
            begin
                Acc = - Acc;
                carry = 0;
                overf = 0;                
            end
            3'b110 : // Not
            begin 
                Acc = ~ Acc;
                carry = 0;
                overf = 0;                
            end
            3'b111 : // Xor
            begin
                Acc = Acc ^ data;
                carry = 0;
                overf = 0;
            end
        endcase
    end
endmodule


module TestBench;
    reg clock;
    reg [15 : 0] data;
    reg [2 : 0] control;
    wire [15 : 0] result;
    wire c;
    wire z;
    wire v;
    wire s;

    ALU alu(clock, data, control, result, c, z, v, s);
    defparam alu.width = 16;

    initial
        clock = 0;
    always
        #8 clock = ~clock;
        initial
        begin
	    $dumpfile("HW4_99101087.vcd"); $dumpvars;
            control = 3'b001; // Clear
            #20
            data = 16'd5;
            control = 3'b010; // Add
            #20
	    control = 3'b000; // Hold
            #20
            data = 16'd8;
            control = 3'b010; // Add
            #20
            data = 16'd4;
            control = 3'b011; // Sub
            #20
	    control = 3'b000; // Hold
            #20
            control = 3'b101; // Neg
            #20
            control = 3'b110; // Not
            #20
            data = 16'd15;
            control = 3'b111; // Xor
            #20
	    control = 3'b000; // Hold
            #20
            data = 16'b0001010101100110;
            control = 3'b100; // And
	    #20
            control = 3'b001; // Clear
            #20
            data = 16'd23;
            control = 3'b010; // Add
            #20
            $finish;
       end
    always @ (data, control, result, c, z, v, s)
        $display(data, control, result, c, z, v, s, $time);
endmodule










