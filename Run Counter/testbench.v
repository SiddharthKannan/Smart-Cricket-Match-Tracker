module test;

reg clk, reset, ball_bowled;
reg [2:0] runs;
wire [15:0] total_runs;

run_counter rc(
    .clk(clk),
    .reset(reset),
    .ball_bowled(ball_bowled),
    .runs(runs),
    .total_runs(total_runs)
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
    runs = 0;
    #20 reset = 0;
    
    // Ball 1: 4 runs
    #10 ball_bowled = 1; runs = 4;
    #10 ball_bowled = 0;
    
    // Ball 2: 6 runs
    #10 ball_bowled = 1; runs = 6;
    #10 ball_bowled = 0;
    
    // Ball 3: 1 run
    #10 ball_bowled = 1; runs = 1;
    #10 ball_bowled = 0;
    
    // Ball 4: 0 runs
    #10 ball_bowled = 1; runs = 0;
    #10 ball_bowled = 0;
    
    #50 $finish;
end

initial begin
    $monitor("Time=%0t | Total Runs=%0d", $time, total_runs);
end

endmodule