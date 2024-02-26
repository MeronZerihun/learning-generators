`timescale 1ns/1ps

module tb_xor_gen;

logic           clk;
logic           rst;
logic [7:0]     value;
logic [7:0]    ciphertext[3];

//logic [7:0]     darray;


/* Clock gen */
initial begin
    clk = 0;
    forever #1ns clk = ~clk;
end

/* Drive test data */
initial begin
    // apply reset
    reset();

    // Test input 1
    value = 'b10110001;
    driver(value);

    // Test input 2
    // repeat(4) @(posedge clk);
    // darray = '{'b00010001};
    // driver(darray);

    repeat(10) @(posedge clk);
    $finish;
end

/*
 * Reset
 */
task reset;
    rst = 1;
    value = 0;
    repeat(10) @(posedge clk);
    rst = 0;
    repeat(10) @(posedge clk);
endtask: reset

/*
 * Main interface driver
 */
task driver;
    input logic [7:0] data_in;

    value = data_in;
    @(posedge clk);
   
    @(posedge clk);
    print_xor_out();
    
    @(posedge clk);
endtask: driver

/*
 * Print convenience function
 */
function automatic void print_xor_out;
    string str, s;

    $display("=== Printing outputs from all 3 blocks ===");
    //for (int i=0; i<1; i++) begin
    $sformat(s, "0b%b ", value);
    str = {str, s};
    //end
    $display("Data In: %s", str);
    for (int i=0; i < 3; i++) begin
        $display("XOR[%0d] = 0b%b", i, ciphertext[i]);
    end
endfunction: print_xor_out

/*
 * 3 instances of xor_gen module each with a different
 * MODE parameter selected
 */
genvar k;
generate 
    for (k=0; k < 3; k++) begin: xor_gen_blk
        xor_gen #(k) ixor_gen
        (
            .clk(clk),
            .rst(rst),
            .value(value),
            .ciphertext(ciphertext[k])
        );	
    end
  
endgenerate
endmodule: tb_xor_gen
