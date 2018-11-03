`include "element.v"


module MatrixMultiply ( clock, reset, matrix_a, matrix_b, matrix_c, complete);

input wire clock;
input wire reset;
input wire [0:3][0:3][0:7] matrix_a;
input wire [0:3][0:3][0:7] matrix_b;
output wire [0:3][0:3][0:7] matrix_c;
output reg complete;

// Build Systolic array
// note the outside edge wires are connected to nothing.
wire [0:4][0:4][0:7] a_wire;
wire [0:4][0:4][0:7] b_wire;
genvar i;
genvar j;
generate
    for (i=0; i<4; i=i+1) begin
        for (j=0; j<4; j=j+1) begin
            Element element(
                clock,
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

reg [0:3][0:1] passer_ready;
reg [0:3][0:1] passer_index;

// TODO passer logic
// * Only need to count to 3
// * decrement passer_ready if its not zero
// * pass and increment index if if passer_ready is zero
// * somehow associate passers with the array
// * Dynamic indexing?


// Upon reset
// * Set complete bit to zero
// * Reset passer state
// * Reset element registers (handled by Elements themselves)
always @ ( ~reset ) begin
    complete <= 0;
end

generate
    for( i=0; i<4; i=i+1 ) begin
        always @ ( ~reset ) begin
        passer_ready[i] <= i;
        passer_index[i] <= 0;
        end
    end
endgenerate


endmodule
