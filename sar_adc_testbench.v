`timescale 1ns / 1ps

module sar_tb;

    // Inputs to FSM
    reg clk;
    reg rst;
    reg start;
    wire comp_out;

    
    wire [3:0] sar_out; 
    wire eoc;
    wire sample_enable; 

    
    real v_in;         // The analog input voltage we want to test
    real v_ref = 3.3;  // The system reference voltage
    real v_dac;        // The analog voltage our fake DAC generates

    
    // 1. INSTANTIATE YOUR FSM

    sar_fsm_4bit UUT (
        .clk(clk),
        .rst(rst),
        .start(start),
        .comp_out(comp_out),
        .sar_out(sar_out),
        .eoc(eoc),
        .sample_enable(sample_enable) 
    );

   
    
    // Fake DAC: Instantly translates the digital word into a voltage
    always @(sar_out) begin
        v_dac = v_ref * ($itor(sar_out) / 16.0); 
    end

    // Fake Comparator: Instantly outputs 1 if Vin > Vdac, else 0
    assign comp_out = (v_in > v_dac) ? 1'b1 : 1'b0;

   
    // 3. CLOCK GENERATION
    
    initial clk = 0;
    always #5 clk = ~clk; // 10ns period (100 MHz clock)

 
    // 4. TEST SEQUENCE
 
    initial begin
        // Setup waveform dumping (Useful if using EDA Playground or ModelSim)
        $dumpfile("sar_tb.vcd");
        $dumpvars(0, sar_tb);

        // System Power-on and Reset
        rst = 1;
        start = 0;
        v_in = 2.1; // First test target: 2.1 Volts
        #20;
        
        // Release reset to enter IDLE
        rst = 0;
        #20;

        // --- TEST CASE 1: Vin = 2.1V ---
        $display("----------------------------------------");
        $display("Starting Conversion: Target Vin = %f V", v_in);
        $display("----------------------------------------");
        
        start = 1; #10; start = 0; // Pulse the start button
        
        // Wait for the FSM to finish its binary search
        wait(eoc == 1'b1);
        #10;
        
        // Print the results to the console
        $display("DONE!");
        $display("Digital Result (sar_out) : %b", sar_out);
        $display("Final DAC Voltage Guess  : %f V", v_dac);
        $display("Quantization Error       : %f V\n", v_in - v_dac);

        // --- TEST CASE 2: Vin = 0.8V ---
        #50;
        v_in = 0.8; // Change the analog input
        
        $display("----------------------------------------");
        $display("Starting Conversion: Target Vin = %f V", v_in);
        $display("----------------------------------------");
        
        start = 1; #10; start = 0; // Pulse the start button
        
        wait(eoc == 1'b1);
        #10;
        
        $display("DONE!");
        $display("Digital Result (sar_out) : %b", sar_out);
        $display("Final DAC Voltage Guess  : %f V", v_dac);
        $display("Quantization Error       : %f V\n", v_in - v_dac);

        #50;
        $display("Simulation Complete.");
        $finish;
    end

endmodule