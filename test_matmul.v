`include "matmul.v"

module test_matmul();

reg [0:3][0:3][0:7] a;
reg [0:3][0:3][0:7] b;
reg reset;
reg clock;

wire complete;
wire [0:3][0:3][7:0] c;
wire [0:31]step;

// Set up clock
initial clock <= 0;
always #1 clock = clock + 1;

// Initialize the matrix
genvar i, j;
generate
for (i=0; i<4; i=i+1) begin
    for (j=0; j<4; j=j+1) begin
        initial begin
            a[i][j] <= i + j;
            b[i][j] <= i + i * j + j;
        end
    end
end
endgenerate

// Link matmul unit
MatrixMultiply X(clock, reset, a, b, c, complete, step);

initial begin
    reset <= 1;

    // TODO make this sane
    $monitor("time %g,   clock %b,   reset %b,   complete %b, step%d\na\t\t\tb\t\t\tc\n%d %d %d %d\t\t%d %d %d %d\t\t%d %d %d %d\n%d %d %d %d\t\t%d %d %d %d\t\t%d %d %d %d\n%d %d %d %d\t\t%d %d %d %d\t\t%d %d %d %d\n%d %d %d %d\t\t%d %d %d %d\t\t%d %d %d %d\n",
        $time, clock, reset, complete, step,
        a[0][0], a[0][1], a[0][2], a[0][3], b[0][0], b[0][1], b[0][2], b[0][3], c[0][0], c[0][1], c[0][2], c[0][3],
        a[1][0], a[1][1], a[1][2], a[1][3], b[1][0], b[1][1], b[1][2], b[1][3], c[1][0], c[1][1], c[1][2], c[1][3],
        a[2][0], a[2][1], a[2][2], a[2][3], b[2][0], b[2][1], b[2][2], b[2][3], c[2][0], c[2][1], c[2][2], c[2][3],
        a[3][0], a[3][1], a[3][2], a[3][3], b[3][0], b[3][1], b[3][2], b[3][3], c[3][0], c[3][1], c[3][2], c[3][3]

    );
    #5 reset <= 0;


    #20 $finish;
end

endmodule
