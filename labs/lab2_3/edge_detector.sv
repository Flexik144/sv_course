module edge_detector (
    input  logic clk,
    input  logic rstn,
    input  logic sck,
    output logic falling_edge
);
    logic sck_d1, sck_d2;
    
    always_ff @(posedge clk) begin
        if (!rstn) begin
            sck_d1 <= 1'b0;
            sck_d2 <= 1'b0;
        end else begin
            sck_d1 <= sck;
            sck_d2 <= sck_d1;
        end
    end
    
    assign falling_edge = ~sck_d1 & sck_d2;
endmodule