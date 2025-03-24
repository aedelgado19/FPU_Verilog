module tb_fp_divider;
    reg [63:0] A, B;
    wire [63:0] result;
    reg [63:0] expected;

    fp_divider uut (A, B, result);

    initial begin

        //-10.0 / 5.0 = -2.0
        A = 64'hc024000000000000; // -10.0
        B = 64'h4014000000000000; // 5.0
        expected = 64'hc000000000000000; // -2.0
        #10;
        if (result !== expected)
            $display("Test 1 FAILED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        else
            $display("Test 1 PASSED: A = %h, B = %h, Result = %h", A, B, result);

        // Test 2: 1.0 / 1.0 = 1.0
        A = 64'h3ff0000000000000;
        B = 64'h3ff0000000000000;
        expected = 64'h3ff0000000000000;
        #10;
        if (result !== expected)
            $display("Test 2 FAILED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        else
            $display("Test 2 PASSED: A = %h, B = %h, Result = %h", A, B, result);

        //8.0 / 4.0 = 2.0
        A = 64'h4020000000000000; // 8.0
        B = 64'h4010000000000000; // 4.0
        expected = 64'h4000000000000000; // 2.0
        #10;
        if (result !== expected)
            $display("Test 3 FAILED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        else
            $display("Test 3 PASSED: A = %h, B = %h, Result = %h", A, B, result);

        //4.0 / 2.0 = 2.0
        A = 64'h4010000000000000;
        B = 64'h4000000000000000;
        expected = 64'h4000000000000000;
        #10;
        if (result !== expected)
            $display("Test 4 FAILED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        else
            $display("Test 4 PASSED: A = %h, B = %h, Result = %h", A, B, result);

        //2.0 / 4.0 = 0.5
        A = 64'h4000000000000000;
        B = 64'h4010000000000000;
        expected = 64'h3fe0000000000000; // 0.5
        #10;
        if (result !== expected)
            $display("Test 5 FAILED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        else
            $display("Test 5 PASSED: A = %h, B = %h, Result = %h", A, B, result);

        //-2.0 / -2.0 = 1.0
        A = 64'hc000000000000000;
        B = 64'hc000000000000000;
        expected = 64'h3ff0000000000000;
        #10;
        if (result !== expected)
            $display("Test 6 FAILED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        else
            $display("Test 6 PASSED: A = %h, B = %h, Result = %h", A, B, result);

        //-4.0 / 2.0 = -2.0
        A = 64'hc010000000000000;
        B = 64'h4000000000000000;
        expected = 64'hc000000000000000;
        #10;
        if (result !== expected)
            $display("Test 7 FAILED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        else
            $display("Test 7 PASSED: A = %h, B = %h, Result = %h", A, B, result);

        //2.0 / -2.0 = -1.0
        A = 64'h4000000000000000;
        B = 64'hc000000000000000;
        expected = 64'hbff0000000000000;
        #10;
        if (result !== expected)
            $display("Test 8 FAILED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        else
            $display("Test 8 PASSED: A = %h, B = %h, Result = %h", A, B, result);

        $stop;
    end
endmodule
