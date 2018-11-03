`include "element.v"


module test_element();
// Declare inputs as regs and outputs as wires
reg [7:0] a_in;
reg [7:0] b_in;
reg clock;
reg reset;
wire [7:0] a_out;
wire [7:0] b_out;
wire [7:0] c_out;


wire [7:0] counter_out;

// Initialize all variables
initial begin
    $display ("time\ta_in\t\tb_in\t\tc_out\t\ta_out\t\tb_out\treset");
    $monitor ("%g\t %b\t%b\t%b\t%b\t%b\t%b",
        $time, a_in, b_in, c_out, a_out, b_out, reset
    );
    clock = 1;
    reset = 1;
    #1
    reset = 0;
    a_in = 1;
    b_in = 2;
    #1 a_in = 1;
    #4 a_in = 4;
    #10 $finish;
end

always begin
    #1 clock = clock + 1;
end

Element X(clock, a_in, b_in, reset, a_out, b_out, c_out);


endmodule
