module fpu_top (input [63:0] A, B, input [1:0] instruction, output reg [63:0] result);

    wire [63:0] a, s, m, d; //wires to hold add, sub, mul, div results

    fp_adder add(A, B, a);
    fp_subtractor sub(A, B, s);
    fp_multiplier mul(A, B, m);
    fp_divider div(A, B, d);

    always @(*) begin
        case (instruction)
            2'b00: result = a;
            2'b01: result = s;
            2'b10: result = m;
            2'b11: result = d;
            default: result = 64'h0; //avoid inferred latches
        endcase
    end
endmodule
