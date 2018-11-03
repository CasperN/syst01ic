`include "element.v"

// Matrix multiply of N * N matricies using systolic arrays
module MatrixMultiply #(parameter integer N = 4)
(clock, reset, matrix_a, matrix_b, matrix_c, complete);


input wire clock;
input wire reset;
input wire [0:N-1][0:N-1][0:7] matrix_a;
input wire [0:N-1][0:N-1][0:7] matrix_b;
output wire [0:N-1][0:N-1][0:7] matrix_c;
output wire complete;

// Only advance matrix multiplication when incomplete
reg [0:7] step;
assign complete = step == 2 * N - 2; // does it in 2N - 2 steps
assign matmul_clock = clock & !complete;

// Systolic Array of `c += a * b` Elements
// note the outside edge wires are connected to nothing.
wire [0:N][0:N][0:7] a_wire;
wire [0:N][0:N][0:7] b_wire;
genvar i, j;
generate
    for (i=0; i<N; i=i+1) begin
        for (j=0; j<N; j=j+1) begin
            Element e(
                matmul_clock,
                reset,
                a_wire[i][j],
                b_wire[i][j],
                a_wire[i][j+1], // a travels across columns
                b_wire[i+1][j], // b travels across rows
                matrix_c[i][j]
            );
        end
    end
endgenerate

// Pass values from input matrices to the computation array
reg [0:N-1][0:7] a_in;
reg [0:N-1][0:7] b_in;
generate
    for( i=0; i<N; i=i+1) begin
        always @ (posedge clock or negedge reset) begin

            // Increment step until complete, or reset.
            step = reset ? 0 : step < 2 * N - 2 ? step + 1 : step;

            // Index into array as appropriate FIXME matrix_b needs transposing
            if (i <= step && step - i < N) begin
                a_in[i] <= matrix_a[i][step - i];
                b_in[i] <= matrix_b[i][step - i];

            // emit zeros if not appropriate
            end else begin
                a_in[i] <= b_in[i] <= 0;
            end
        end
    end
endgenerate


endmodule
