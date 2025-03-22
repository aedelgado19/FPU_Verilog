module tb_fp_multiplier;
    reg [63:0] A, B;
    wire [63:0] result;

    fp_multiplier uut (A, B, result);

    task check_result;
        input [63:0] expected;
        input [63:0] computed;
        begin
            if (computed === expected) begin
                $display("PASS: Expected = %h, Got = %h", expected, computed);
            end else begin
                $display("FAIL: Expected = %h, Got = %h", expected, computed);
            end
        end
    endtask

    initial begin
        //3.0 * 2.5 = 7.5
        A = 64'h4008000000000000;  // 3.0
        B = 64'h4004000000000000;  // 2.5
        #10;
        check_result(64'h401E000000000000, result);  // 7.5

        // 0.5 * 0.5 = 0.25
        A = 64'h3FE0000000000000;  // 0.5
        B = 64'h3FE0000000000000;  // 0.5
        #10;
        check_result(64'h3FD0000000000000, result);  // 0.25

        // -2.0 * 4.0 = -8.0
        A = 64'hC000000000000000;  // -2.0
        B = 64'h4010000000000000;  // 4.0
        #10;
        check_result(64'hC020000000000000, result);  // -8.0

        //1.0 * 1.0 = 1.0
        A = 64'h3FF0000000000000;  // 1.0
        B = 64'h3FF0000000000000;  // 1.0
        #10;
        check_result(64'h3FF0000000000000, result);  // 1.0

        //2^-1022 * 2 
        A = 64'h0010000000000000;  // 2^-1022
        B = 64'h4000000000000000;  // 2.0
        #10;
        check_result(64'h0020000000000000, result);  // 2^-1021

        //-1.0 * 0.0 = -0.0
        A = 64'hBFF0000000000000;  // -1.0
        B = 64'h0000000000000000;  // 0.0
        #10;
        check_result(64'h8000000000000000, result);  // -0.0

        $stop;
    end
endmodule
