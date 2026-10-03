//==============================================================
// DAY 5 : COMPLETE VERIFICATION
// File : day5_tb.v
//==============================================================

module day5_tb;


    //==========================================================
    // BASIC GATE SIGNALS
    //==========================================================

    reg A;
    reg B;

    wire NOT_Y;
    wire AND_Y;
    wire OR_Y;
    wire XOR_Y;


    not_gate N1 (
        .A(A),
        .Y(NOT_Y)
    );

    and_gate A1 (
        .A(A),
        .B(B),
        .Y(AND_Y)
    );

    or_gate O1 (
        .A(A),
        .B(B),
        .Y(OR_Y)
    );

    xor_gate X1 (
        .A(A),
        .B(B),
        .Y(XOR_Y)
    );


    //==========================================================
    // 1-BIT COMPARATOR
    //==========================================================

    wire C1_GT;
    wire C1_EQ;
    wire C1_LT;

    comparator_1bit COMP1 (
        .A(A),
        .B(B),
        .GT(C1_GT),
        .EQ(C1_EQ),
        .LT(C1_LT)
    );


    //==========================================================
    // 4-BIT COMPARATOR SIGNALS
    //==========================================================

    reg [3:0] A4;
    reg [3:0] B4;

    wire GT;
    wire EQ;
    wire LT;


    comparator_4bit COMP4 (
        .A(A4),
        .B(B4),
        .GT(GT),
        .EQ(EQ),
        .LT(LT)
    );


    //==========================================================
    // RTL COMPARATOR
    //==========================================================

    wire RTL_GT;
    wire RTL_EQ;
    wire RTL_LT;

    comparator_4bit_rtl COMP_RTL (
        .A(A4),
        .B(B4),
        .GT(RTL_GT),
        .EQ(RTL_EQ),
        .LT(RTL_LT)
    );


    //==========================================================
    // TOP MODULE
    //==========================================================

    wire TOP_GT;
    wire TOP_EQ;
    wire TOP_LT;

    comparator_4bit_top TOP (
        .A(A4),
        .B(B4),
        .GT(TOP_GT),
        .EQ(TOP_EQ),
        .LT(TOP_LT)
    );


    //==========================================================
    // VERIFICATION
    //==========================================================

    initial begin

        $display("=================================================");
        $display("       DAY 5 : 4-BIT COMPARATOR VERIFICATION");
        $display("=================================================");


        //======================================================
        // 1. BASIC GATES
        //======================================================

        $display("");
        $display("---- 1. BASIC GATE VERIFICATION ----");


        A = 0;
        B = 0;
        #10;

        if (NOT_Y == 1 &&
            AND_Y == 0 &&
            OR_Y  == 0 &&
            XOR_Y == 0)
            $display("GATE 00 : PASS");
        else
            $display("GATE 00 : FAIL");


        A = 0;
        B = 1;
        #10;

        if (NOT_Y == 1 &&
            AND_Y == 0 &&
            OR_Y  == 1 &&
            XOR_Y == 1)
            $display("GATE 01 : PASS");
        else
            $display("GATE 01 : FAIL");


        A = 1;
        B = 0;
        #10;

        if (NOT_Y == 0 &&
            AND_Y == 0 &&
            OR_Y  == 1 &&
            XOR_Y == 1)
            $display("GATE 10 : PASS");
        else
            $display("GATE 10 : FAIL");


        A = 1;
        B = 1;
        #10;

        if (NOT_Y == 0 &&
            AND_Y == 1 &&
            OR_Y  == 1 &&
            XOR_Y == 0)
            $display("GATE 11 : PASS");
        else
            $display("GATE 11 : FAIL");


        //======================================================
        // 2. 1-BIT COMPARATOR
        //======================================================

        $display("");
        $display("---- 2. 1-BIT COMPARATOR ----");


        // 0 < 0
        A = 0;
        B = 0;
        #10;

        if (C1_GT == 0 &&
            C1_EQ == 1 &&
            C1_LT == 0)
            $display("1-BIT 00 : PASS");
        else
            $display("1-BIT 00 : FAIL");


        // 0 < 1
        A = 0;
        B = 1;
        #10;

        if (C1_GT == 0 &&
            C1_EQ == 0 &&
            C1_LT == 1)
            $display("1-BIT 01 : PASS");
        else
            $display("1-BIT 01 : FAIL");


        // 1 > 0
        A = 1;
        B = 0;
        #10;

        if (C1_GT == 1 &&
            C1_EQ == 0 &&
            C1_LT == 0)
            $display("1-BIT 10 : PASS");
        else
            $display("1-BIT 10 : FAIL");


        // 1 = 1
        A = 1;
        B = 1;
        #10;

        if (C1_GT == 0 &&
            C1_EQ == 1 &&
            C1_LT == 0)
            $display("1-BIT 11 : PASS");
        else
            $display("1-BIT 11 : FAIL");


        //======================================================
        // 3. 4-BIT COMPARATOR
        //======================================================

        $display("");
        $display("---- 3. 4-BIT COMPARATOR ----");


        // 5 > 3
        A4 = 4'b0101;
        B4 = 4'b0011;
        #10;

        if (GT == 1 &&
            EQ == 0 &&
            LT == 0)
            $display("4-BIT 5 > 3 : PASS");
        else
            $display("4-BIT 5 > 3 : FAIL");


        // 3 < 5
        A4 = 4'b0011;
        B4 = 4'b0101;
        #10;

        if (GT == 0 &&
            EQ == 0 &&
            LT == 1)
            $display("4-BIT 3 < 5 : PASS");
        else
            $display("4-BIT 3 < 5 : FAIL");


        // 7 = 7
        A4 = 4'b0111;
        B4 = 4'b0111;
        #10;

        if (GT == 0 &&
            EQ == 1 &&
            LT == 0)
            $display("4-BIT 7 = 7 : PASS");
        else
            $display("4-BIT 7 = 7 : FAIL");


        // 15 > 0
        A4 = 4'b1111;
        B4 = 4'b0000;
        #10;

        if (GT == 1 &&
            EQ == 0 &&
            LT == 0)
            $display("4-BIT 15 > 0 : PASS");
        else
            $display("4-BIT 15 > 0 : FAIL");


        // 0 < 15
        A4 = 4'b0000;
        B4 = 4'b1111;
        #10;

        if (GT == 0 &&
            EQ == 0 &&
            LT == 1)
            $display("4-BIT 0 < 15 : PASS");
        else
            $display("4-BIT 0 < 15 : FAIL");


        //======================================================
        // 4. MSB PRIORITY TEST
        //======================================================

        $display("");
        $display("---- 4. MSB PRIORITY TEST ----");


        // A = 1000
        // B = 0111
        //
        // MSB decides immediately.
        // A > B

        A4 = 4'b1000;
        B4 = 4'b0111;
        #10;

        if (GT == 1 &&
            EQ == 0 &&
            LT == 0)
            $display("MSB PRIORITY 1 : PASS");
        else
            $display("MSB PRIORITY 1 : FAIL");


        // A = 0111
        // B = 1000
        //
        // A < B

        A4 = 4'b0111;
        B4 = 4'b1000;
        #10;

        if (GT == 0 &&
            EQ == 0 &&
            LT == 1)
            $display("MSB PRIORITY 2 : PASS");
        else
            $display("MSB PRIORITY 2 : FAIL");


        //======================================================
        // 5. LOWER-BIT PRIORITY TEST
        //======================================================

        $display("");
        $display("---- 5. LOWER-BIT PRIORITY TEST ----");


        // A = 1001
        // B = 1000
        //
        // MSB equal.
        // Bit 0 decides.
        // A > B

        A4 = 4'b1001;
        B4 = 4'b1000;
        #10;

        if (GT == 1 &&
            EQ == 0 &&
            LT == 0)
            $display("LOWER BIT TEST 1 : PASS");
        else
            $display("LOWER BIT TEST 1 : FAIL");


        // A = 1010
        // B = 1011
        //
        // Lower bit decides.
        // A < B

        A4 = 4'b1010;
        B4 = 4'b1011;
        #10;

        if (GT == 0 &&
            EQ == 0 &&
            LT == 1)
            $display("LOWER BIT TEST 2 : PASS");
        else
            $display("LOWER BIT TEST 2 : FAIL");


        //======================================================
        // 6. GATE-LEVEL VS RTL
        //======================================================

        $display("");
        $display("---- 6. GATE-LEVEL VS RTL ----");


        A4 = 4'b0000;
        B4 = 4'b0000;
        #10;

        if (GT == RTL_GT &&
            EQ == RTL_EQ &&
            LT == RTL_LT)
            $display("COMPARE 0 vs 0 : PASS");
        else
            $display("COMPARE 0 vs 0 : FAIL");


        A4 = 4'b0101;
        B4 = 4'b0010;
        #10;

        if (GT == RTL_GT &&
            EQ == RTL_EQ &&
            LT == RTL_LT)
            $display("COMPARE 5 vs 2 : PASS");
        else
            $display("COMPARE 5 vs 2 : FAIL");


        A4 = 4'b0010;
        B4 = 4'b0101;
        #10;

        if (GT == RTL_GT &&
            EQ == RTL_EQ &&
            LT == RTL_LT)
            $display("COMPARE 2 vs 5 : PASS");
        else
            $display("COMPARE 2 vs 5 : FAIL");


        A4 = 4'b1111;
        B4 = 4'b1111;
        #10;

        if (GT == RTL_GT &&
            EQ == RTL_EQ &&
            LT == RTL_LT)
            $display("COMPARE 15 vs 15 : PASS");
        else
            $display("COMPARE 15 vs 15 : FAIL");


        //======================================================
        // 7. TOP MODULE
        //======================================================

        $display("");
        $display("---- 7. TOP MODULE VERIFICATION ----");


        A4 = 4'b1100;
        B4 = 4'b0011;
        #10;

        if (TOP_GT == 1 &&
            TOP_EQ == 0 &&
            TOP_LT == 0)
            $display("TOP 12 > 3 : PASS");
        else
            $display("TOP 12 > 3 : FAIL");


        A4 = 4'b0011;
        B4 = 4'b1100;
        #10;

        if (TOP_GT == 0 &&
            TOP_EQ == 0 &&
            TOP_LT == 1)
            $display("TOP 3 < 12 : PASS");
        else
            $display("TOP 3 < 12 : FAIL");


        A4 = 4'b1010;
        B4 = 4'b1010;
        #10;

        if (TOP_GT == 0 &&
            TOP_EQ == 1 &&
            TOP_LT == 0)
            $display("TOP 10 = 10 : PASS");
        else
            $display("TOP 10 = 10 : FAIL");


        //======================================================
        // FINISH
        //======================================================

        $display("");
        $display("=================================================");
        $display("       DAY 5 VERIFICATION COMPLETED");
        $display("=================================================");

        $finish;

    end

endmodule
