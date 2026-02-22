module test;

reg clk, reset, start_innings, ball_bowled, wicket_fallen;
reg [2:0] runs_scored;
wire [2:0] balls;
wire [4:0] overs;
wire [15:0] total_runs;
wire [3:0] wickets;
wire [1:0] game_state;
wire innings_active;

cricket_tracker ct(
    .clk(clk),
    .reset(reset),
    .start_innings(start_innings),
    .ball_bowled(ball_bowled),
    .runs_scored(runs_scored),
    .wicket_fallen(wicket_fallen),
    .balls(balls),
    .overs(overs),
    .total_runs(total_runs),
    .wickets(wickets),
    .game_state(game_state),
    .innings_active(innings_active)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

// Task to bowl a ball
task bowl;
    input [2:0] runs;
    input wicket;
    begin
        #10;
        ball_bowled = 1;
        runs_scored = runs;
        wicket_fallen = wicket;
        #10;
        ball_bowled = 0;
        wicket_fallen = 0;
    end
endtask

// Main test
initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
    
    // Initialize
    reset = 1;
    start_innings = 0;
    ball_bowled = 0;
    runs_scored = 0;
    wicket_fallen = 0;
    
    #20 reset = 0;
    
    $display("Cricket Over Tracker - Simulation");
    $display("----------------------------------");
    
    // Start innings
    #10 start_innings = 1;
    #10 start_innings = 0;
    
    $display("Over.Ball | Score");
    $display("----------|-------");
    
    // Over 1
    bowl(1, 0);
    $display("  %d.%d    | %d/%d", overs, balls, total_runs, wickets);
    
    bowl(0, 0);
    $display("  %d.%d    | %d/%d", overs, balls, total_runs, wickets);
    
    bowl(4, 0);
    $display("  %d.%d    | %d/%d", overs, balls, total_runs, wickets);
    
    bowl(2, 0);
    $display("  %d.%d    | %d/%d", overs, balls, total_runs, wickets);
    
    bowl(0, 1);
    $display("  %d.%d    | %d/%d (wicket)", overs, balls, total_runs, wickets);
    
    bowl(6, 0);
    $display("  %d.%d    | %d/%d", overs, balls, total_runs, wickets);
    
    // Over 2
    bowl(3, 0);
    $display("  %d.%d    | %d/%d", overs, balls, total_runs, wickets);
    
    bowl(1, 0);
    $display("  %d.%d    | %d/%d", overs, balls, total_runs, wickets);
    
    bowl(4, 0);
    $display("  %d.%d    | %d/%d", overs, balls, total_runs, wickets);
    
    bowl(0, 0);
    $display("  %d.%d    | %d/%d", overs, balls, total_runs, wickets);
    
    bowl(2, 0);
    $display("  %d.%d    | %d/%d", overs, balls, total_runs, wickets);
    
    bowl(6, 0);
    $display("  %d.%d    | %d/%d", overs, balls, total_runs, wickets);
    
    // Over 3
    bowl(1, 0);
    $display("  %d.%d    | %d/%d", overs, balls, total_runs, wickets);
    
    bowl(1, 0);
    $display("  %d.%d    | %d/%d", overs, balls, total_runs, wickets);
    
    bowl(0, 1);
    $display("  %d.%d    | %d/%d (wicket)", overs, balls, total_runs, wickets);
    
    bowl(4, 0);
    $display("  %d.%d    | %d/%d", overs, balls, total_runs, wickets);
    
    bowl(6, 0);
    $display("  %d.%d    | %d/%d", overs, balls, total_runs, wickets);
    
    bowl(2, 0);
    $display("  %d.%d    | %d/%d", overs, balls, total_runs, wickets);
    
    $display("----------------------------------");
    $display("Final: %d/%d in %d overs", total_runs, wickets, overs);
    
    #100 $finish;
end

endmodule