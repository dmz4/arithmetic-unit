// File: add_rca.v
// Author: Diego Dominguez
// Hierarchy: top-level module; instantiates N full_adder modules.
// Function: parameterized N-bit ripple-carry adder.
// Parameters: N sets the width of A, B, and Sum.
// Clock: combinational design; no clock or active edges.
// Critical path: carry chain from the least significant bit.
module add_rca #(parameter N = 32) (
  input [N-1:0] A,
  input [N-1:0] B,
  input Cin,
  output [N-1:0] Sum,
  output Cout
);
  // carry[0] receives the carry-in; carry[N] is the carry-out.
  wire [N:0] carry;
  assign carry[0] = Cin;
  genvar i;

  generate
    for (i = 0; i < N; i = i + 1) begin : adder_loop
      full_adder fa (
        .A(A[i]),
        .B(B[i]),
        .Cin(carry[i]),
        .Sum(Sum[i]),
        .Cout(carry[i+1])
      );
    end
  endgenerate

  assign Cout = carry[N];

endmodule