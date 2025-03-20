module fp_subtractor (
    input  [63:0] A, B,
    output reg [63:0] result
);

    wire [10:0] exp_A = A[62:52];
    wire [10:0] exp_B = B[62:52];
    wire [51:0] mant_A = A[51:0];
    wire [51:0] mant_B = B[51:0];
    wire sign_A = A[63];
    wire sign_B = B[63];

    reg [53:0] norm_mant_A, norm_mant_B;
    reg [10:0] larger_exp, exp_diff, final_exp;
    reg [54:0] mant_diff;
    reg [53:0] final_mantissa;
    reg final_sign;
    
    always @(*) begin
        norm_mant_A = {2'b01, mant_A}; //add implicit leading 1
        norm_mant_B = {2'b01, mant_B};

        //align exponent
        if (exp_A > exp_B) begin
            larger_exp = exp_A;
            exp_diff = exp_A - exp_B;
            norm_mant_B = norm_mant_B >> exp_diff; //shift mantissa here
            final_sign = sign_A;
        end else begin
            larger_exp = exp_B;
            exp_diff = exp_B - exp_A;
            norm_mant_A = norm_mant_A >> exp_diff;
            final_sign = sign_B;
        end

        //sub mantissa
        if (norm_mant_A >= norm_mant_B) begin
            mant_diff = norm_mant_A - norm_mant_B;
        end else begin
            mant_diff = norm_mant_B - norm_mant_A;
            final_sign = ~final_sign; //flip sign if B > A
        end

	//special case for zero b/c it's positive in IEEE
	if (mant_diff == 0) final_sign = 0; 

        //normalize mantissa
        final_exp = larger_exp;
        while (mant_diff[52] == 0 && final_exp > 0) begin
            mant_diff = mant_diff << 1;
            final_exp = final_exp - 1;
        end

        //round to even
        if (mant_diff[1] == 1 && (mant_diff[0] == 1 || mant_diff[2] == 1)) begin
            mant_diff = mant_diff + 1;
        end

        //prevent overflow
        if (mant_diff[53] == 1) begin
            mant_diff = mant_diff >> 1;
            final_exp = final_exp + 1;
        end

        //Special case: infinity handling
        if (final_exp == 2047) mant_diff = 0;

        //concat to make final result
        result = {final_sign, final_exp, mant_diff[51:0]};
    end
endmodule
