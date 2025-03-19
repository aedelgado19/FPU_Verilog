module tb_fp_adder;
    reg [63:0] A, B;
    wire [63:0] result;
    reg [63:0] expected;

    fp_adder uut (A, B, result);

    initial begin
        //3.5 + 2.25 = 5.75
        A = 64'h400C000000000000; 
        B = 64'h4002000000000000;
        expected = 64'h4017000000000000;
        #10;
        if (result !== expected) begin
            $display("Test 1 Failed (3.5 + 2.25): A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        end else $display("Test 1 PASSED (3.5 + 2.25): A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        //-4.75 + 1.5 = -3.25
        A = 64'hC012000000000000;
        B = 64'h3FF8000000000000;
        expected = 64'hC008000000000000;
        #10;
        if (result !== expected) begin
            $display("Test 2 Failed (-4.75 + 1.5): A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        end else $display("Test 2 PASSED (-4.75 + 1.5): A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        //0.0 + 5.75 = 5.75
        A = 64'h0000000000000000;
        B = 64'h4017000000000000;
        expected = 64'h4017000000000000;
        #10;
        if (result !== expected) begin
            $display("Test 3 Failed (0.0 + 5.75) : A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        end else $display("Test 3 PASSED (0.0 + 5.75) : A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        //Infinity + 0 = Infinity
        A = 64'h7FF0000000000000;
        B = 64'h0000000000000000;
        expected = 64'h7FF0000000000000;
        #10;
        if (result !== expected) begin
            $display("Test 4 Failed (Inf + 0): A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        end else $display("Test 4 PASSED (Inf + 0): A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        //Infinity + Infinity = Infinity
        A = 64'h7FF0000000000000;
        B = 64'h7FF0000000000000;
        expected = 64'h7FF0000000000000;
        #10;
        if (result !== expected) begin
            $display("Test 5 Failed (Inf + Inf) : A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        end else $display("Test 5 PASSED (Inf + Inf): A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);


	// -3.5 + -2.25 = -5.75
        A = 64'hC00C000000000000;
        B = 64'hC002000000000000;
        expected = 64'hC017000000000000;
        #10;
        if (result !== expected) begin
            $display("Test 6 Failed (-3.5 + -2.25): Expected = %h, Got = %h", expected, result);
        end else $display("Test 6 PASSED (-3.5 + -2.25): Expected = %h, Got = %h", expected, result);

        // -0.25 + -0.375 = -0.625
        A = 64'hBFD0000000000000;
        B = 64'hBFD8000000000000;
        expected = 64'hBFE4000000000000;
        #10;
        if (result !== expected) begin
            $display("Test 7 Failed (-0.25 + -0.375): Expected = %h, Got = %h", expected, result);
        end else $display("Test 7 PASSED (-0.25 + -0.375): Expected = %h, Got = %h", expected, result);

        // -8.125 + 0.0 = -8.125
        A = 64'hC020400000000000;
        B = 64'h0000000000000000;
        expected = 64'hC020400000000000;
        #10;
        if (result !== expected) begin
            $display("Test 8 Failed (-8.125 + 0.0): Expected = %h, Got = %h", expected, result);
        end else $display("Test 9 PASSED (-8.125 + 0.0): Expected = %h, Got = %h", expected, result);

        $stop;
    end
endmodule
