module tb_successive_approximation_register();
    localparam SIZE = 4;
    reg clk, reset, comparator_out;
    wire [SIZE-1:0] digital_out;
    wire done;

    sar_adc_digital #(.SIZE(SIZE)) uut (.reset(reset), .clk(clk), .comparator_out(comparator_out), .done(done), .digital_out(digital_out));

    // Clocking block
    always
        begin
            clk = 0; #10;
            clk = 1; #10;
        end

    initial
        begin
            $monitor("%b, %b", digital_out, done);
            // Test #1
            reset = 0;
            @(negedge clk); reset = 1;
            @(negedge clk); reset = 0; comparator_out = 1;
            @(negedge clk); comparator_out = 1;
            @(negedge clk); comparator_out = 1;
            @(negedge clk); comparator_out = 1;

            // Test #2
            @(negedge clk); reset = 1;
            @(negedge clk); reset = 0; comparator_out = 0;
            @(negedge clk); comparator_out = 1;
            @(negedge clk); comparator_out = 0;
            @(negedge clk); comparator_out = 1;
            #2;
            $finish;
        end

endmodule