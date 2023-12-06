
module Memory(clock, instruction, data, address);
    inout [15:0] data;
    input [11:0] address;
    input clock;
    input instruction;

    reg [15:0] memory[2**12 - 1 : 0];
    reg [15:0] data_in;

    assign data = instruction ? data_in : 'hz;

    always @(posedge clock)
    begin
   	if(instruction)
    	data_in = memory[address];
   	else
    	memory[address] = data;
    end
endmodule

module TestBench;
    reg [15:0] data_in;
    reg [11:0] address;
    reg clock;
    reg instruction;
    wire [15:0] data;

    Memory mem(clock, instruction, data, address);

    assign data = instruction ? 'hz : data_in;

    initial begin
        clock = 0;
    end

    always
    #5 clock = ~clock;
    initial begin
	$dumpfile("HW3_99101087.vcd"); $dumpvars;
	address = 12'h1a1;
        instruction = 1;
        #11
	address = 12'h123;
        instruction = 1;
        #11
	instruction = 0;
	#11
        address = 12'h1a1;
        data_in = 16'd81;
        #11
	address = 12'h123;
        data_in = 16'd43;
        #11
	instruction = 1;
	#11
        address = 12'h1a1;
        #11
	address = 12'h123;
        #11
	instruction = 0;
	#13
	address = 12'h1a1;
        data_in = 16'd24;
        #11
	address = 12'h123;
        data_in = 16'd74;
        #11
	instruction = 1;
	#11
	address = 12'h1a1;
        #13
	address = 12'h123;
        #11
	instruction = 0;
	#11
	address = 12'h1a1;
        data_in = 16'd35;
        #23
	address = 12'h1a1;
        instruction = 1;
        #23
	$finish;
    end
endmodule









 