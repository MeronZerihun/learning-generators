`timescale 1ns/1ps

module xor_gen #(parameter MODE = 0, localparam [7:0] KEY1 = 'b10101010, localparam [7:0] KEY2 = 'b10101000)
(
	input logic clk,
	input logic rst,
	input logic [7:0] value,
	output logic [7:0] ciphertext
);

always_ff @(posedge clk) begin
	if(rst) begin
		ciphertext <= 'd0;
	end
	else begin
		ciphertext <= xor_modes.encrypt(value);
	end
end

generate 
case (MODE)
	0:
	begin: xor_modes
		// data ^ KEY2
		function automatic [7:0] encrypt;
		       input [7:0] data;
		       
		       reg [7:0] d_in;
		       reg [7:0] c_out;


			d_in = data;
			c_out[0] = KEY2[0] ^ d_in[0];
			c_out[1] = KEY2[1] ^ d_in[1];	
			c_out[2] = KEY2[2] ^ d_in[2];
			c_out[3] = KEY2[3] ^ d_in[3];
			c_out[4] = KEY2[4] ^ d_in[4];
			c_out[5] = KEY2[5] ^ d_in[5];
			c_out[6] = KEY2[6] ^ d_in[6];
			c_out[7] = KEY2[7] ^ d_in[7];

			encrypt = c_out;
		endfunction
	end
	1: 
	begin: xor_modes
		// data ^ KEY1 ^ KEY2
                function automatic [7:0] encrypt;
                       input [7:0] data;

                       reg [7:0] d_in;
                       reg [7:0] c_out;


                        d_in = data;
                        c_out[0] = KEY1[0] ^ KEY2[0] ^ d_in[0];
                        c_out[1] = KEY1[1] ^ KEY2[1] ^ d_in[1];
                        c_out[2] = KEY1[2] ^ KEY2[2] ^ d_in[2];
                        c_out[3] = KEY1[3] ^ KEY2[3] ^ d_in[3];
                        c_out[4] = KEY1[4] ^ KEY2[4] ^ d_in[4];
                        c_out[5] = KEY1[5] ^ KEY2[5] ^ d_in[5];
			c_out[6] = KEY1[6] ^ KEY2[6] ^ d_in[6];
                        c_out[7] = KEY1[7] ^ KEY2[7] ^ d_in[7];

                        encrypt = c_out;
                endfunction
        end
	default:
	begin: xor_modes
		// data ^ KEY1
		function automatic [7:0] encrypt;
                       input [7:0] data;

                       reg [7:0] d_in;
                       reg [7:0] c_out;


                        d_in = data;
                        c_out[0] = KEY1[0] ^ d_in[0];
                        c_out[1] = KEY1[1] ^ d_in[1];
                        c_out[2] = KEY1[2] ^ d_in[2];
                        c_out[3] = KEY1[3] ^ d_in[3];
                        c_out[4] = KEY1[4] ^ d_in[4];
                        c_out[5] = KEY1[5] ^ d_in[5];
                        c_out[6] = KEY1[6] ^ d_in[6];
                        c_out[7] = KEY1[7] ^ d_in[7];
                        encrypt = c_out;
                endfunction
	end
endcase
endgenerate

endmodule: xor_gen
