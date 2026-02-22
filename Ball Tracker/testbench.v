module test;

reg clk;
reg reset;
reg ball_bowled;
wire [2:0] count;

ball_counter bc(
    .clk(clk),
    .reset(reset),
    .ball_bowled(ball_bowled),
    .count(count)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
    
    reset = 1;
    ball_bowled = 0;
    #20 reset = 0;
    
    repeat(8) begin
        #10 ball_bowled = 1;
        #10 ball_bowled = 0;
    end
    
    #50 $finish;
end

initial begin
    $monitor("Time=%0t | Ball Count=%0d", $time, count);
end

endmodule