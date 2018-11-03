module MatrixMultiply ( clock, reset, matrix_A, matrix_B, matrix_C);

input wire clock;
input wire reset;
input [127:0] matrix_A;
input [127:0] matrix_B;
output reg [127:0] matrix_C;


reg [0:7] passer_ready;
reg [0:7] passer_index;


// TODO
// * reset logic
// * passer logic
//    * decrement passer_ready if its not zero
//    * pass and increment index if if passer_ready is zero
//    * somehow associate passers with the array
// * how to wire up elements? two for loops?




endmodule
