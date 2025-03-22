module fp_multiplier (
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
    reg [105:0] partial_products;
    reg [51:0] final_mantissa;
    reg [52:0] extracted_mant_A;
    reg [52:0] extracted_mant_B;

    always @(*) begin
        //compute sign
        sign_result = sign_A ^ sign_B;

        //get exponent
        exp_result = (exp_A + exp_B) - 1023;

        //get mantissas (with leading 1)
        extracted_mant_A = {1'b1, mant_A};
        extracted_mant_B = {1'b1, mant_B};

        //multiply mantissas
        partial_products = extracted_mant_A * extracted_mant_B;
        
	//normalize
        if (partial_products[105] == 1) begin
            final_mantissa = partial_products[104:53];
            exp_result = exp_result + 1;
        end else begin
            final_mantissa = partial_products[103:52];
        end

        result = {sign_result, exp_result, final_mantissa};
    end
endmodule
