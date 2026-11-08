// File: full_adder.v
// Author: Diego Dominguez
// Hierarchy: add_rca submodule; represents a one-bit stage.
// Function: computes the sum and carry of three one-bit inputs.
// Parameters: none.
// Clock: combinational design; no clock or active edges.
// Critical path: sum logic and carry-out generation.
module full_adder(
  input A,
  input B,
  input Cin,
  output Sum,
  output Cout
);

  // Sum is the parity of the three inputs; Cout is their majority carry.
  assign Sum = A ^ B ^ Cin;
  assign Cout = (A & B) | (B & Cin) | (A & Cin);

endmodule