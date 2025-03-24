module tb_fpu_top;
    reg  [63:0] A, B;
    reg  [1:0]  instruction;
    wire [63:0] result;
    reg [63:0] expected;

    fpu_top uut (A, B, instruction, result);

    initial begin
        $display("=============== START OF ADDITION TESTS ================");
        A = 64'h400C000000000000; B = 64'h4002000000000000; expected = 64'h4017000000000000; instruction = 2'b00; #10;
        if (result !== expected) $display("Test 1 Failed (3.5 + 2.25): A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        else $display("Test 1 PASSED (3.5 + 2.25): A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        A = 64'hC012000000000000; B = 64'h3FF8000000000000; expected = 64'hC008000000000000; #10;
        if (result !== expected) $display("Test 2 Failed (-4.75 + 1.5): A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        else $display("Test 2 PASSED (-4.75 + 1.5): A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        A = 64'h0000000000000000; B = 64'h4017000000000000; expected = 64'h4017000000000000; #10;
        if (result !== expected) $display("Test 3 Failed (0.0 + 5.75) : A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        else $display("Test 3 PASSED (0.0 + 5.75) : A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        A = 64'h7FF0000000000000; B = 64'h0000000000000000; expected = 64'h7FF0000000000000; #10;
        if (result !== expected) $display("Test 4 Failed (Inf + 0): A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        else $display("Test 4 PASSED (Inf + 0): A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        A = 64'h7FF0000000000000; B = 64'h7FF0000000000000; expected = 64'h7FF0000000000000; #10;
        if (result !== expected) $display("Test 5 Failed (Inf + Inf) : A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        else $display("Test 5 PASSED (Inf + Inf): A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        A = 64'hC00C000000000000; B = 64'hC002000000000000; expected = 64'hC017000000000000; instruction = 2'b00; #10;
        if (result !== expected) $display("Test 6 Failed (-3.5 + -2.25): A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        else $display("Test 6 PASSED (-3.5 + -2.25): A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        A = 64'hBFD0000000000000; B = 64'hBFD8000000000000; expected = 64'hBFE4000000000000; #10;
        if (result !== expected) $display("Test 7 Failed (-0.25 + -0.375): A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        else $display("Test 7 PASSED (-0.25 + -0.375): A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        A = 64'hC020400000000000; B = 64'h0000000000000000; expected = 64'hC020400000000000; #10;
        if (result !== expected) $display("Test 8 Failed (-8.125 + 0.0): A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        else $display("Test 8 PASSED (-8.125 + 0.0): A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        $display("=============== START OF SUBTRACTION TESTS ================");
        instruction = 2'b01;
        A = 64'h400C000000000000; B = 64'h4002000000000000; expected = 64'h3FF4000000000000; #10;
        if (result !== expected) $display("Test 1 Failed (3.5 - 2.25): A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        else $display("Test 1 PASSED (3.5 - 2.25): A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        A = 64'h4025000000000000; B = 64'h4015000000000000; expected = 64'h4015000000000000; #10;
        if (result !== expected) $display("Test 2 Failed (10.5 - 5.25): A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        else $display("Test 2 PASSED (10.5 - 5.25): A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        A = 64'h4059000000000000; B = 64'h4069000000000000; expected = 64'hC059000000000000; #10;
        if (result !== expected) $display("Test 3 Failed (100.0 - 200.0): A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        else $display("Test 3 PASSED (100.0 - 200.0): A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        A = 64'h0000000000000000; B = 64'h0000000000000000; expected = 64'h0000000000000000; #10;
        if (result !== expected) $display("Test 4 Failed (0.0 - 0.0): A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        else $display("Test 4 PASSED (0.0 - 0.0): A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        A = 64'h4049000000000000; B = 64'h0000000000000001; expected = 64'h4049000000000000; #10;
        if (result !== expected) $display("Test 5 Failed (50.0 - tiny): A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        else $display("Test 5 PASSED (50.0 - tiny): A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        A = 64'h7FF0000000000000; B = 64'h3FF0000000000000; expected = 64'h7FF0000000000000; #10;
        if (result !== expected) $display("Test 6 Failed (Inf - 1.0): A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        else $display("Test 6 PASSED (Inf - 1.0): A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        $display("=============== START OF MULTIPLICATION TESTS ================");
        instruction = 2'b10;
        A = 64'h4008000000000000; B = 64'h4004000000000000; expected = 64'h401E000000000000; #10;
        if (result !== expected) $display("Test 1 FAILED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        else $display("Test 1 PASSED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        A = 64'h3FE0000000000000; B = 64'h3FE0000000000000; expected = 64'h3FD0000000000000; #10;
        if (result !== expected) $display("Test 2 FAILED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        else $display("Test 2 PASSED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        A = 64'hC000000000000000; B = 64'h4010000000000000; expected = 64'hC020000000000000; #10;
        if (result !== expected) $display("Test 3 FAILED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        else $display("Test 3 PASSED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        A = 64'h3FF0000000000000; B = 64'h3FF0000000000000; expected = 64'h3FF0000000000000; #10;
        if (result !== expected) $display("Test 4 FAILED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        else $display("Test 4 PASSED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        A = 64'h0010000000000000; B = 64'h4000000000000000; expected = 64'h0020000000000000; #10;
        if (result !== expected) $display("Test 5 FAILED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        else $display("Test 5 PASSED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        A = 64'hBFF0000000000000; B = 64'h0000000000000000; expected = 64'h8000000000000000; #10;
        if (result !== expected) $display("Test 6 FAILED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        else $display("Test 6 PASSED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        $display("=============== START OF DIVISION TESTS ================");
        instruction = 2'b11;
        A = 64'hc024000000000000; B = 64'h4014000000000000; expected = 64'hc000000000000000; #10;
        if (result !== expected) $display("Test 1 FAILED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        else $display("Test 1 PASSED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        A = 64'h3ff0000000000000; B = 64'h3ff0000000000000; expected = 64'h3ff0000000000000; #10;
        if (result !== expected) $display("Test 2 FAILED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        else $display("Test 2 PASSED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        A = 64'h4020000000000000; B = 64'h4010000000000000; expected = 64'h4000000000000000; #10;
        if (result !== expected) $display("Test 3 FAILED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        else $display("Test 3 PASSED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        A = 64'h4010000000000000; B = 64'h4000000000000000; expected = 64'h4000000000000000; #10;
        if (result !== expected) $display("Test 4 FAILED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        else $display("Test 4 PASSED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        A = 64'h4000000000000000; B = 64'h4010000000000000; expected = 64'h3fe0000000000000; #10;
        if (result !== expected) $display("Test 5 FAILED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        else $display("Test 5 PASSED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        A = 64'hc000000000000000; B = 64'hc000000000000000; expected = 64'h3ff0000000000000; #10;
        if (result !== expected) $display("Test 6 FAILED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        else $display("Test 6 PASSED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        A = 64'hc010000000000000; B = 64'h4000000000000000; expected = 64'hc000000000000000; #10;
        if (result !== expected) $display("Test 7 FAILED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        else $display("Test 7 PASSED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        A = 64'h4000000000000000; B = 64'hc000000000000000; expected = 64'hbff0000000000000; #10;
        if (result !== expected) $display("Test 8 FAILED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        else $display("Test 8 PASSED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        $stop;
    end
endmodule
