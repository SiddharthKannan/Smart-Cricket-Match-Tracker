module cricket_tracker(
    input clk,
    input reset,
    input start_innings,
    input ball_bowled,
    input [2:0] runs_scored,
    input wicket_fallen,
    output [2:0] balls,
    output [4:0] overs,
    output [15:0] total_runs,
    output [3:0] wickets,
    output [1:0] game_state,
    output innings_active
);

parameter IDLE = 2'b00;
parameter PLAYING = 2'b01;
parameter INNINGS_OVER = 2'b10;

reg [1:0] state;
assign game_state = state;

wire over_complete;
wire all_out;
wire max_overs_reached;

assign all_out = (wicket_count == 10);
assign max_overs_reached = (over_count == 20);
assign innings_active = (state == PLAYING);

// FSM
always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
    end else begin
        case(state)
            IDLE: begin
                if (start_innings)
                    state <= PLAYING;
            end
            PLAYING: begin
                if (all_out || max_overs_reached)
                    state <= INNINGS_OVER;
            end
            INNINGS_OVER: begin
                state <= INNINGS_OVER;
            end
            default: state <= IDLE;
        endcase
    end
end

// Ball counter
reg [2:0] ball_count;
assign balls = ball_count;
assign over_complete = (ball_count == 5 && ball_bowled && innings_active);

always @(posedge clk) begin
    if (reset || state == IDLE)
        ball_count <= 0;
    else if (ball_bowled && innings_active) begin
        if (ball_count == 5)
            ball_count <= 0;
        else
            ball_count <= ball_count + 1;
    end
end

// Over counter
reg [4:0] over_count;
assign overs = over_count;

always @(posedge clk) begin
    if (reset || state == IDLE)
        over_count <= 0;
    else if (over_complete)
        over_count <= over_count + 1;
end

// Run counter
reg [15:0] runs;
assign total_runs = runs;

always @(posedge clk) begin
    if (reset || state == IDLE)
        runs <= 0;
    else if (ball_bowled && innings_active)
        runs <= runs + runs_scored;
end

// Wicket counter
reg [3:0] wicket_count;
assign wickets = wicket_count;

always @(posedge clk) begin
    if (reset || state == IDLE)
        wicket_count <= 0;
    else if (wicket_fallen && innings_active && wicket_count < 10)
        wicket_count <= wicket_count + 1;
end

endmodule