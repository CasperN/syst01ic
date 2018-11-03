module Element(clock, a_in, b_in, reset, a, b, c);

input wire clock;
input wire reset;
input wire [7:0]a_in;
input wire [7:0]b_in;
output reg [7:0]a;
output reg [7:0]b;
output reg [7:0]c;


always @ (posedge clock or negedge reset)
begin
    if (~reset) begin
        c = c + a_in * b_in;  // reset register
        a <= a_in;
        b <= b_in;
    end else begin
        a <= 8'b0;
        b <= 8'b0;
        c <= 8'b0;
    end
end

endmodule
