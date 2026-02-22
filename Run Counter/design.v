module run_counter(
    input clk,
    input reset,
    input ball_bowled,
    input [2:0] runs,       // 0-6 runs per ball
    output reg [15:0] total_runs  // Total score
);

always @(posedge clk) begin
    if (reset)
        total_runs <= 0;
    else if (ball_bowled)
        total_runs <= total_runs + runs;
end

endmodule