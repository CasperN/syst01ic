module Element(clock, a, b, c, a_in, b_in, reset);

input wire clock;
input wire reset;
input wire a_in;
input wire b_in;
output reg [7:0]a;
output reg [7:0]b;
output reg [7:0]c;

    always @ ( reset == 1'b1 ) begin
        a <= 8'b0;
        b <= 8'b0;
        c <= 8'b0;
    end

    always @ ( reset != 1'b1 ) begin
        c = c + a_in * b_in;
        a <= a_in;
        b <= b_in;
    end

endmodule
