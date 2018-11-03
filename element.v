module Element(clock, reset, a_in, b_in, a, b, c);

input wire clock;
input wire reset;
input wire [7:0]a_in;
input wire [7:0]b_in;
output reg [7:0]a;
output reg [7:0]b;
output reg [7:0]c;


always @ (posedge clock or negedge reset)
begin
    if (reset)
        a <= b <= c <= 0;
    else begin
        c = c + a_in * b_in;  // reset register
        a <= a_in;
        b <= b_in;
    end 
end

endmodule
