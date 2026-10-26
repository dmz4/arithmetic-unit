// File: adder_tb.v
// Author: Diego Dominguez
// Hierarchy: top-level testbench; compares four 32-bit adders.
// Function: applies test vectors and displays simulation outputs.
// Parameters: none.
// Clock: no clock; stimuli are separated by simulation delays.
// Critical path: not applicable; this testbench does not describe hardware.
module adder_tb;

  reg [31:0] A, B;
  reg Cin;
  wire [31:0] Y, Sum_rca, Sum_csa, Y_lc;
  wire Cout, Cout_rca, Cout_csa, Cout_lc;
  add_plus #(.N(32)) adder (
    .A(A),
    .B(B),
    .Cin(Cin),
    .Y(Y),
    .Cout(Cout)
  );

  add_rca #(.N(32)) adder_rca (
    .A(A),
    .B(B),
    .Cin(Cin),
    .Sum(Sum_rca),
    .Cout(Cout_rca)
  );

  add_csa #(.N(32)) adder_csa (
    .A(A),
    .B(B),
    .Cin(Cin),
    .Sum(Sum_csa),
    .Cout(Cout_csa)
  );

  add_lca #(.N(32)) adder_lca (
    .A(A),
    .B(B),
    .Cin(Cin),
    .Y(Y_lc),
    .Cout(Cout_lc)
  );

  // Apply the same operands to each implementation for comparison.
  initial begin
    $monitor($time, " A=%h B=%h Cin=%b | Y=%h Cout=%b | Sum_rca=%h Cout_rca=%b | Sum_csa=%h Cout_csa=%b | Y_lc=%h Cout_lc=%b", A, B, Cin, Y, Cout, Sum_rca, Cout_rca, Sum_csa, Cout_csa, Y_lc, Cout_lc);
    $dumpfile("adder_tb.vcd");
    $dumpvars(0, adder_tb);
    A = 32'h00000000;
    B = 32'h00000000;
    Cin = 1'b0;

    #10 A = 32'hFFFFFFFF; B = 32'h00000001; Cin = 1'b0;
    #10 A = 32'h7FFFFFFF; B = 32'h00000001; Cin = 1'b0;
    #10 A = 32'h80000000; B = 32'hFFFFFFFF; Cin = 1'b1;
    #10 A = 32'h12345678; B = 32'h87654321; Cin = 1'b0;
    #10 A = 32'hFFFFFFFF; B = 32'hFFFFFFFF; Cin = 1'b1;

    #10 $finish;
  end

endmodule