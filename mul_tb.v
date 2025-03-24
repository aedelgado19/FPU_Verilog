module tb_fp_multiplier;
    reg [63:0] A, B;
    reg [63:0] expected;
    wire [63:0] result;

    fp_multiplier uut (A, B, result);

    initial begin
        // Test 1: 3.0 * 2.5 = 7.5
        A = 64'h4008000000000000;  
        B = 64'h4004000000000000;
        expected = 64'h401E000000000000;
        #10;
        if (result !== expected) begin
            $display("Test 1 FAILED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        end else $display("Test 1 PASSED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        // Test 2: 0.5 * 0.5 = 0.25
        A = 64'h3FE0000000000000;
        B = 64'h3FE0000000000000;
        expected = 64'h3FD0000000000000;
        #10;
        if (result !== expected) begin
            $display("Test 2 FAILED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        end else $display("Test 2 PASSED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        // Test 3: -2.0 * 4.0 = -8.0
        A = 64'hC000000000000000;
        B = 64'h4010000000000000;
        expected = 64'hC020000000000000;
        #10;
        if (result !== expected) begin
            $display("Test 3 FAILED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        end else $display("Test 3 PASSED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        // Test 4: 1.0 * 1.0 = 1.0
        A = 64'h3FF0000000000000;
        B = 64'h3FF0000000000000;
        expected = 64'h3FF0000000000000;
        #10;
        if (result !== expected) begin
            $display("Test 4 FAILED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        end else $display("Test 4 PASSED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        // Test 5: 2^-1022 * 2 = 2^-1021
        A = 64'h0010000000000000;
        B = 64'h4000000000000000;
        expected = 64'h0020000000000000;
        #10;
        if (result !== expected) begin
            $display("Test 5 FAILED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        end else $display("Test 5 PASSED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        // Test 6: -1.0 * 0.0 = -0.0
        A = 64'hBFF0000000000000;
        B = 64'h0000000000000000;
        expected = 64'h8000000000000000;
        #10;
        if (result !== expected) begin
            $display("Test 6 FAILED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        end else $display("Test 6 PASSED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        $stop;
    end
endmodule
