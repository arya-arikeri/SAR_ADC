`timescale 1ns / 1ps

module sar_fsm_4bit (
input wire clk,
input wire rst,           
input wire start,         
input wire comp_out,      
output reg sample_enable, 
output reg [3:0] sar_out, 
output reg eoc   //end of conversion         
);

 //4 states    
localparam IDLE    = 2'b00;
localparam SAMPLE  = 2'b01;
localparam CONVERT = 2'b10;
localparam DONE    = 2'b11;

reg [1:0] state;
reg [2:0] bit_idx; 

always @(posedge clk or posedge rst) begin
if (rst) begin
            
state         <= IDLE;
sar_out       <= 4'b0000;
sample_enable <= 1'b0;
eoc           <= 1'b0;
bit_idx       <= 3'd3;
end else begin
case (state)
IDLE: begin
eoc           <= 1'b0;
sample_enable <= 1'b0;
                    
if (start) begin
state <= SAMPLE;
end
end
//begins sampling
SAMPLE: begin

sample_enable <= 1'b1; 
                    

sar_out <= 4'b1000;  //sets o/p initially as 1000
bit_idx <= 3'd3;     
                    
state <= CONVERT;
end

CONVERT: begin//this is where we use the comparator o/p

sample_enable <= 1'b0; 

if (comp_out == 1'b1) begin //greater than the threshold
sar_out[bit_idx] <= 1'b1; //bit set to 1
end else begin
sar_out[bit_idx] <= 1'b0; //bit set to 0
end


if (bit_idx == 3'd0) begin

state <= DONE;
end else begin

bit_idx <= bit_idx - 1; 
                        

sar_out[bit_idx - 1] <= 1'b1; //preparing nxt bit
end
end

DONE: begin
eoc   <= 1'b1; 
state <= IDLE; 
end
                
default: begin
state <= IDLE;
end
endcase
end
end

endmodule