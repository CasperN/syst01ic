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

// Initialize all variables
initial begin
    $display ("time \ta_in\tb_in\tc_out\ta_out\tb_out\treset");
    $monitor ("%g\t %d\t%d\t%d\t%d\t%d\t%d",
        $time, a_in, b_in, c_out, a_out, b_out, reset
    );
    clock = 1;
    reset = 1;
    #1
    reset = 0;
    a_in = 1;
    b_in = 2;
    #1 reset = 1;

    #50 reset = 0;
    #1 a_in = 1;
    #4 a_in = 4;
    #10 $finish;
end

always #1 clock = clock + 1;

Element X(clock, reset, a_in, b_in, a_out, b_out, c_out);


endmodule
