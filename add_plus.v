// File: add_plus.v
// Author: Diego Dominguez
// Hierarchy: top-level module; does not instantiate other modules.
// Function: adds A, B, and Cin using the Verilog arithmetic operator.
// Parameters: N sets the width of A, B, and Y.
// Clock: combinational design; no clock or active edges.
// Critical path: the adder implementation inferred during synthesis.
module add_plus #(parameter N = 32)(
  input [N-1:0] A,
  input [N-1:0] B,
  input Cin,
  output [N-1:0] Y,
  output Cout
);

  // The concatenation retains the most significant carry of the addition.
  assign {Cout, Y} = A + B + Cin;

endmodule