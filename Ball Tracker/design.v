module ball_counter(
    input clk,
    input reset,
    input ball_bowled,
    output reg [2:0] count
);

always @(posedge clk) begin
    if (reset) begin
        count <= 0;
    end
    else if (ball_bowled) begin
        if (count == 6) begin
            count <= 0;
        end else begin
            count <= count + 1;
        end
    end
end

endmodule