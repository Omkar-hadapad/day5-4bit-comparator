//==============================================================
// DAY 5 : 4-BIT COMPARATOR
// File    : day5_design.v
// Language: Verilog-2001
//==============================================================


//==============================================================
// 1. NOT GATE
//==============================================================
module not_gate (
    input A,
    output Y
);

    assign Y = ~A;

endmodule


//==============================================================
// 2. AND GATE
//==============================================================
module and_gate (
    input A,
    input B,
    output Y
);

    assign Y = A & B;

endmodule


//==============================================================
// 3. OR GATE
//==============================================================
module or_gate (
    input A,
    input B,
    output Y
);

    assign Y = A | B;

endmodule


//==============================================================
// 4. XOR GATE
//==============================================================
module xor_gate (
    input A,
    input B,
    output Y
);

    assign Y = A ^ B;

endmodule


//==============================================================
// 5. 1-BIT COMPARATOR
//
// Inputs : A, B
//
// Outputs:
//
// GT = A > B
// EQ = A = B
// LT = A < B
//
// Equations:
//
// GT = A . B'
// EQ = A XNOR B
// LT = A' . B
//
// XNOR = ~(A XOR B)
//==============================================================
module comparator_1bit (
    input A,
    input B,
    output GT,
    output EQ,
    output LT
);

    wire B_not;
    wire A_not;
    wire XOR_Y;
    wire AND_GT;
    wire AND_LT;

    // NOT B
    not_gate N1 (
        .A(B),
        .Y(B_not)
    );

    // NOT A
    not_gate N2 (
        .A(A),
        .Y(A_not)
    );

    // A XOR B
    xor_gate X1 (
        .A(A),
        .B(B),
        .Y(XOR_Y)
    );

    // A XNOR B
    not_gate N3 (
        .A(XOR_Y),
        .Y(EQ)
    );

    // A > B
    and_gate A1 (
        .A(A),
        .B(B_not),
        .Y(GT)
    );

    // A < B
    and_gate A2 (
        .A(A_not),
        .B(B),
        .Y(LT)
    );

endmodule


//==============================================================
// 6. 4-BIT COMPARATOR
//
// Comparison starts from MSB.
//
// Priority:
//
// A[3] vs B[3]
//       ↓
// if equal:
// A[2] vs B[2]
//       ↓
// if equal:
// A[1] vs B[1]
//       ↓
// if equal:
// A[0] vs B[0]
//
// The first unequal bit from MSB determines the result.
//==============================================================
module comparator_4bit (
    input [3:0] A,
    input [3:0] B,
    output GT,
    output EQ,
    output LT
);

    wire GT3;
    wire EQ3;
    wire LT3;

    wire GT2;
    wire EQ2;
    wire LT2;

    wire GT1;
    wire EQ1;
    wire LT1;

    wire GT0;
    wire EQ0;
    wire LT0;


    //==========================================================
    // BIT 3 : MSB
    //==========================================================

    comparator_1bit C3 (
        .A(A[3]),
        .B(B[3]),
        .GT(GT3),
        .EQ(EQ3),
        .LT(LT3)
    );


    //==========================================================
    // BIT 2
    //==========================================================

    comparator_1bit C2 (
        .A(A[2]),
        .B(B[2]),
        .GT(GT2),
        .EQ(EQ2),
        .LT(LT2)
    );


    //==========================================================
    // BIT 1
    //==========================================================

    comparator_1bit C1 (
        .A(A[1]),
        .B(B[1]),
        .GT(GT1),
        .EQ(EQ1),
        .LT(LT1)
    );


    //==========================================================
    // BIT 0 : LSB
    //==========================================================

    comparator_1bit C0 (
        .A(A[0]),
        .B(B[0]),
        .GT(GT0),
        .EQ(EQ0),
        .LT(LT0)
    );


    //==========================================================
    // EQUALITY
    //
    // All four bits must be equal.
    //==========================================================

    assign EQ = EQ3 & EQ2 & EQ1 & EQ0;


    //==========================================================
    // GREATER THAN
    //
    // A > B if:
    //
    // A3 > B3
    // OR
    // A3=B3 and A2>B2
    // OR
    // A3=B3 and A2=B2 and A1>B1
    // OR
    // A3=B3 and A2=B2 and A1=B1 and A0>B0
    //==========================================================

    assign GT =
          GT3
        | (EQ3 & GT2)
        | (EQ3 & EQ2 & GT1)
        | (EQ3 & EQ2 & EQ1 & GT0);


    //==========================================================
    // LESS THAN
    //
    // A < B if:
    //
    // A3 < B3
    // OR
    // A3=B3 and A2<B2
    // OR
    // A3=B3 and A2=B2 and A1<B1
    // OR
    // A3=B3 and A2=B2 and A1=B1 and A0<B0
    //==========================================================

    assign LT =
          LT3
        | (EQ3 & LT2)
        | (EQ3 & EQ2 & LT1)
        | (EQ3 & EQ2 & EQ1 & LT0);

endmodule


//==============================================================
// 7. BEHAVIORAL RTL COMPARATOR
//
// Compact RTL version.
//
// Used to compare the hierarchical gate-level design
// against a direct RTL description.
//==============================================================
module comparator_4bit_rtl (
    input [3:0] A,
    input [3:0] B,
    output GT,
    output EQ,
    output LT
);

    assign GT = (A > B);
    assign EQ = (A == B);
    assign LT = (A < B);

endmodule


//==============================================================
// 8. TOP MODULE
//
// Final Day 5 design.
//
// The top module uses the hierarchical 4-bit comparator.
//==============================================================
module comparator_4bit_top (
    input [3:0] A,
    input [3:0] B,
    output GT,
    output EQ,
    output LT
);

    comparator_4bit COMP (
        .A(A),
        .B(B),
        .GT(GT),
        .EQ(EQ),
        .LT(LT)
    );

endmodule
