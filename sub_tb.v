module tb_fp_subtractor;
    reg [63:0] A, B;
    wire [63:0] result;
    reg [63:0] expected;

    fp_subtractor uut (A, B, result);

    initial begin
        A = 64'h400C000000000000; // 3.5
        B = 64'h4002000000000000; // 2.25
        expected = 64'h3FF4000000000000; // 1.25
        #10;
        if (result !== expected) begin
            $display("Test 1 Failed: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        end else $display("Test 1 PASSED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        A = 64'h4025000000000000; // 10.5
        B = 64'h4015000000000000; // 5.25
        expected = 64'h4015000000000000; // 5.25
        #10;
        if (result !== expected) begin
            $display("Test 2 Failed: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        end else $display("Test 2 PASSED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        A = 64'h4059000000000000; // 100.0
        B = 64'h4069000000000000; // 200.0
        expected = 64'hC059000000000000; // -100.0
        #10;
        if (result !== expected) begin
            $display("Test 3 Failed: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        end else $display("Test 3 PASSED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        A = 64'h0000000000000000; // 0.0
        B = 64'h0000000000000000; // 0.0
        expected = 64'h0000000000000000; // 0.0
        #10;
        if (result !== expected) begin
            $display("Test 4 Failed: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        end else $display("Test 4 PASSED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        A = 64'h4049000000000000; // 50.0
        B = 64'h0000000000000001; //really small number
        expected = 64'h4049000000000000; //should stay 50
        #10;
        if (result !== expected) begin
            $display("Test 5 Failed: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        end else $display("Test 5 PASSED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        A = 64'h7FF0000000000000; //+Infinity
        B = 64'h3FF0000000000000; //1.0
        expected = 64'h7FF0000000000000; //Infinity
        #10;
        if (result !== expected) begin
            $display("Test 6 Failed: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);
        end else $display("Test 6 PASSED: A = %h, B = %h, Expected = %h, Got = %h", A, B, expected, result);

        $stop;
    end
endmodule
