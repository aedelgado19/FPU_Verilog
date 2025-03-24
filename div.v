module fp_divider(
    input  [63:0] A, B,
    output reg [63:0] result
);

    wire sign_A = A[63];
    wire sign_B = B[63];
    wire [10:0] exp_A = A[62:52];
    wire [10:0] exp_B = B[62:52];
    wire [51:0] mant_A = A[51:0];
    wire [51:0] mant_B = B[51:0];

    reg sign_result;
    reg [10:0] exp_result;
    reg [52:0] norm_mant_A, norm_mant_B;
    reg [105:0] remainder;
    reg [52:0] quotient;
    integer i;

    always @(*) begin
        //XOR the signs
        sign_result = sign_A ^ sign_B;

        //get exponent (A - B + 1023)
        exp_result = (exp_A - exp_B) + 1023;

        //get mantissas w/ leading 1
        norm_mant_A = {1'b1, mant_A};
        norm_mant_B = {1'b1, mant_B};

        //bitwise division
        remainder = norm_mant_A;
        remainder = remainder << 53; //align left for division
        quotient = 0;

        for (i = 52; i >= 0; i = i - 1) begin
            remainder = remainder << 1;
            if (remainder[105:53] >= norm_mant_B) begin
                remainder[105:53] = remainder[105:53] - norm_mant_B;
                quotient[i] = 1;
            end
        end

        result = {sign_result, exp_result, quotient[51:0]};
    end
endmodule
