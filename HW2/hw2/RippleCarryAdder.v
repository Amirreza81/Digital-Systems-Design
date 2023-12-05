// top-down

module RCA(a, b, cin, sum, cout);
	input [3:0]a;
	input [3:0]b;
	input cin;
	output [3:0]sum;
	output cout;
	wire c_1, c_2, c_3;

	Full_Adder fa_1(a[0], b[0], cin, c_1, sum[0]);
	Full_Adder fa_2(a[1], b[1], c_1, c_2, sum[1]);
	Full_Adder fa_3(a[2], b[2], c_2, c_3, sum[2]);
	Full_Adder fa_4(a[3], b[3], c_3, cout, sum[3]);
endmodule

module Full_Adder(a, b, cin, cout, sum);
	input a, b, cin;
	output cout, sum;
	wire w_1, w_2, w_3;
	
	Half_Adder ha_1(a, b, w_1, w_2);
	Half_Adder ha_2(w_2, cin, w_3, sum);
	or(cout, w_1, w_3);
endmodule

module Half_Adder(a, b, cout, sum);
	input a, b;
	output reg cout, sum;

	always@(*)
		#2 cout = a & b;
	always@(*)
		#3 sum = a ^ b;
endmodule
	 
module Top;
	reg [3:0]a;
	reg [3:0]b;
	reg cin;
	wire [3:0]sum;
	wire cout;

	initial
	begin
		a = 0;
		b = 0;
		cin = 0;
	end	
	
	RCA adder(a, b, cin, sum, cout);
	
	initial
	begin
		a[1] = 1;	// a = 1010, b = 0101
		cin = 1; 
		a[3] = 1;
		b[0] = 1;
		b[2] = 1;
		#25 a = 0;
		b = 0;
		cin = 0;
		#25 cin = 1;
		a[0] = 1;
		a[2] = 1;
		a[3] = 1;
		b[0] = 1;
		b[1] = 1;
		b[2] = 1;
		b[3] = 1;
		#25 a = 0;
		b = 0;
		cin = 0;
		#25 a[0] = 1;
		cin = 1; 
		a[2] = 1;
		a[3] = 1;
		b[1] = 1;
	end
endmodule





