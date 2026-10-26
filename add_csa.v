// File: add_csa.v
// Author: Diego Dominguez
// Hierarchy: top-level module; instantiates add_rca.
// Function: four-bit-block carry-select adder.
// Parameters: N sets the width of A, B, and Sum; it must be a multiple of 4.
// Clock: combinational design; no clock or active edges.
// Critical path: carry propagation between blocks and sum selection.
module add_csa #(parameter N = 32) (
  input [N-1:0] A,
  input [N-1:0] B,
  input Cin,
  output [N-1:0] Sum,
  output Cout
);

  // Each block processes four bits.
  localparam n = N >> 2;
  localparam j = 4;
  wire [N-1:j] sumaux1, sumaux2;
  wire [n-1:1] carryaux1, carryaux2;
  wire [n-1:0] carries;

  // The carry-out is the carry from the final block.
  assign Cout = carries[n-1];

  add_rca #(.N(j)) adder1 (
    .A(A[j-1:0]),
    .B(B[j-1:0]),
    .Cin(Cin),
    .Sum(Sum[j-1:0]),
    .Cout(carries[0])
  );

  genvar i;
  generate
    // Select the carry calculated with Cin=0 or Cin=1.
    for (i = 1; i < n; i = i + 1) begin : carry_assign
      assign carries[i] = carries[i-1] ? carryaux2[i] : carryaux1[i];
    end

    for (i = 1; i < n; i = i + 1) begin : Sum_assign
      assign Sum[j*i+:4] = carries[i-1] ? sumaux2[j*i+:4] : sumaux1[j*i+:4];
    end

    for (i = 1; i < n; i = i + 1) begin : adder_csa_loop
      add_rca #(.N(j)) rcadder_blocks_1 (
        .A(A[j*i+:4]),
        .B(B[j*i+:4]),
        .Cin(1'b0),
        .Sum(sumaux1[j*i+:4]),
        .Cout(carryaux1[i])
      );

      add_rca #(.N(j)) rcadder_blocks_2 (
        .A(A[j*i+:4]),
        .B(B[j*i+:4]),
        .Cin(1'b1),
        .Sum(sumaux2[j*i+:4]),
        .Cout(carryaux2[i])
      );

    end
  endgenerate

endmodule
