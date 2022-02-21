module successive_approximation_register
    #(parameter SIZE = 3)
    (input wire clk, reset, comparator_out,
    output reg done,
    output reg [SIZE-1:0] digital_out);

    // Pointer to track current index being check
    reg [$clog2(SIZE)-1:0] index_ptr;

    always @(posedge clk)
        begin
            if (reset)
                begin
                    done <= 0;
                    digital_out <= {1'b1, {(SIZE-1){1'b0}}};
                    index_ptr <= SIZE - 1;
                end
            else
                if (done == 0)
                    begin
                        digital_out[index_ptr] <= comparator_out & digital_out[index_ptr];
                        digital_out[index_ptr-1] <= 1'b1;
                        index_ptr <= index_ptr - 1;
                    end
        end

    always @(*)
        begin
            done = (index_ptr == 0)?1:0;
        end

endmodule