module fp_adder (input [63:0] A, B, output reg [63:0] result);
    wire [10:0] exp_A = A[62:52];
    wire [10:0] exp_B = B[62:52];
    wire [51:0] mant_A = A[51:0];
    wire [51:0] mant_B = B[51:0];
    wire sign_A = A[63];
    wire sign_B = B[63];

    reg [53:0] norm_mant_A, norm_mant_B;
    reg [10:0] aligned_exp, exp_diff, final_exp;
    reg [54:0] mant_sum;
    reg [53:0] final_mantissa;
    reg final_sign;
    integer i;

    always @(*) begin
        //1.mantissa format
        norm_mant_A = (exp_A != 0) ? {2'b01, mant_A} : 54'b0;
        norm_mant_B = (exp_B != 0) ? {2'b01, mant_B} : 54'b0;
        
	//special cases: NaN, Infinity
        if (exp_A == 11'b11111111111 || exp_B == 11'b11111111111) begin
            if ((A == 64'h7FF0000000000000 && B == 64'h7FF0000000000000)) begin
                result = 64'h7FF0000000000000; // Inf + Inf = Inf
            end 
            else if ((A == 64'h7FF0000000000000 && B == 64'hFFF0000000000000) ||
                     (A == 64'hFFF0000000000000 && B == 64'h7FF0000000000000)) begin
                result = 64'h7FF8000000000000; // Inf - Inf = NaN
                $display("Special Case: Inf - Inf = NaN");
            end else begin
                result = (exp_A == 11'b11111111111) ? A : B; //if one's inf, return Inf
            end
        end 

        //special case: 0's
        else if (A == 64'b0 || B == 64'b0) begin
            result = (A == 64'b0) ? B : A;
        end 
        else begin
            //align exponent
            if (exp_A > exp_B) begin
                exp_diff = exp_A - exp_B;
                norm_mant_B = norm_mant_B >> exp_diff;
                aligned_exp = exp_A;
                final_sign = sign_A;
            end else begin
                exp_diff = exp_B - exp_A;
                norm_mant_A = norm_mant_A >> exp_diff;
                aligned_exp = exp_B;
                final_sign = sign_B;
            end

	    //add/sub
            if (sign_A == sign_B) begin
                mant_sum = norm_mant_A + norm_mant_B;
            end else begin
                if (norm_mant_A >= norm_mant_B) begin
                    mant_sum = norm_mant_A - norm_mant_B;
                    final_sign = sign_A;
                end else begin
                    mant_sum = norm_mant_B - norm_mant_A;
                    final_sign = sign_B;
                end
            end

            final_exp = aligned_exp;
            final_mantissa = mant_sum[53:0];
            if (sign_A == sign_B) begin
                //deal w overflow
                if (mant_sum[53] == 1) begin
                    final_mantissa = mant_sum >> 1;
                    final_exp = final_exp + 1;
                end
            end 
            else begin
		
		for (i = 0; i < 53; i = i + 1) begin
		    if (final_mantissa[53] == 0 && final_exp > 0) begin
			final_mantissa = final_mantissa << 1;
			final_exp = final_exp - 1;
		    end
		end
            end

            //round to nearest even num
            if (final_mantissa[0] == 1) begin
                final_mantissa = final_mantissa + 1;
            end

            //special case to fix infinity overflows (return inf)
            if (final_exp == 2047) begin
                final_mantissa = 0;
                result = {final_sign, final_exp, final_mantissa[51:0]};
            end
            else result = {final_sign, final_exp, final_mantissa[51:0]}; //concat to get final result
            
        end
    end
endmodule
