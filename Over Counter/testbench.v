module test;

reg clk, reset, over_complete;
wire [4:0] overs;

over_counter oc(
    .clk(clk),
    .reset(reset),
    .over_complete(over_complete),
    .overs(overs)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
    
    reset = 1;
    over_complete = 0;
    #20 reset = 0;
    
    // Simulate 5 overs completing
    repeat(5) begin
        #10 over_complete = 1;
        #10 over_complete = 0;
    end
    
    #50 $finish;
end

initial begin
    $monitor("Time=%0t | Overs=%0d", $time, overs);
end

endmodulet