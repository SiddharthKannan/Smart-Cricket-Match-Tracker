# Cricket Over Tracker

A digital cricket scoreboard system built using Verilog HDL for my Digital Systems Design course.

## What is this?

This project tracks cricket scores in hardware - counting balls, overs, runs, and wickets automatically. Kind of like the big scoreboards you see in stadiums, but implemented at the circuit level.

Built as my final year project for the Digital Systems Design course.

## How it works

The system uses multiple hardware components working together:

**Ball Counter** - Counts from 1 to 6 (one over), then resets  
**Over Counter** - Tracks how many overs have been bowled (max 20 for T20)  
**Run Counter** - Adds up all the runs scored  
**Wicket Counter** - Counts wickets that fall (max 10)  
**FSM Controller** - The "brain" that manages everything and knows when to stop the innings
The wicket counter and the fsm controller are directly integrated in the final verilog file, they are not seperately constructed

The FSM has 3 states:
- IDLE: waiting to start
- PLAYING: match is on
- INNINGS_OVER: match finished (either 10 wickets or 20 overs reached)

## Files
```
├── verilog/
│   ├── design.v          # Main cricket tracker module
│   └── testbench.v       # Test code to run simulations
├── demo/
│   └── cricket-ui.html   # Interactive demo (runs in browser)
└── screenshots/          # Output screenshots
```

## Running it

**Online (easiest way):**
1. Go to https://edaplayground.com
2. Copy `design.v` into the right side
3. Copy `testbench.v` into the left side
4. Pick "Icarus Verilog" from the dropdown
5. Hit Run

**Interactive demo:**

Just open `cricket-ui.html` in any browser. Click the buttons to bowl balls and watch the score update.

## Course coverage

This project covers everything from the syllabus:

- Module 1 (Boolean Algebra): Used in comparators to check conditions
- Module 2 (Verilog HDL): Whole thing is written in Verilog
- Module 3 (Combinational): Adders, comparators, muxes
- Module 4 (Sequential): Counters, registers, flip-flops everywhere
- Module 5 (FSM): State machine controlling the innings


Built with Verilog, tested on EDA Playground, demo made with HTML/CSS/JS.

---

Feel free to use this code for learning. If you have questions, open an issue.

