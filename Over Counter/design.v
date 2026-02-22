module over_counter(
    input clk,
    input reset,
    input over_complete,    // Signal from ball counter
    output reg [4:0] overs  // Can count 0-31 overs
);

always @(posedge clk) begin
    if (reset)
        overs <= 0;
    else if (over_complete)
        overs <= overs + 1;
end

endmodule