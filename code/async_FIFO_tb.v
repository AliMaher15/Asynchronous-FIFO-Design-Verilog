`timescale 1ns / 1ps

module async_FIFO_tb();
// data width = 8, memory depth = 16, addr width = 4

integer i;

////////////////////////////////////////////////////////
////////////          TB Signals           /////////////
////////////////////////////////////////////////////////

// Inputs
reg             write_clk   ;
reg             write_rst_n ;
reg             write_en    ;
reg   [7:0]     write_data  ;

reg             read_clk   ;
reg             read_rst_n ;
reg             read_en    ;

// Outputs
wire  [7:0]     read_data  ;
wire            w_full     ;
wire            r_empty    ;
wire            r_valid    ;

////////////////////////////////////////////////////////
/////////////     DUT Instantiation        /////////////
////////////////////////////////////////////////////////

async_FIFO_top dut (
.w_clk(write_clk)    , 
.w_rst_n(write_rst_n), 
.w_en(write_en)      , 
.w_data(write_data)  ,  
.r_clk(read_clk)      , 
.r_rst_n(read_rst_n)  , 
.r_en(read_en)        , 
.r_data(read_data)    ,
.w_full(w_full)              ,  
.r_empty(empty)            ,
.r_valid(valid)
);

////////////////////////////////////////////////////////
////////////       Clock Generator         /////////////
////////////////////////////////////////////////////////

// Write Clock Generator
always #50 write_clk = ~write_clk ;

// Read Clock Generator
always #10 read_clk = ~read_clk ;

////////////////////////////////////////////////////////
////////////            INITIAL             ////////////
////////////////////////////////////////////////////////

initial 
 begin

// Initialize Inputs
write_clk   = 1'b0 ;
read_clk    = 1'b0 ;
write_rst_n = 1'b1 ;    // reset 
read_rst_n  = 1'b1 ;    // is deactivated
write_data  = 8'd5;
write_en    = 1'b0 ;
read_en     = 1'b0 ;

#50        
write_rst_n = 1'b0 ;    // reset 
read_rst_n  = 1'b0 ;    // is activated

#100
write_rst_n = 1'b1 ;    // reset 
read_rst_n  = 1'b1 ;    // is deactivated

write_data = 8'd6 ;
write_en   = 1'b1 ;

#100
write_data = 8'd7 ;

#100
write_data = 8'd8 ;

#100
write_data = 8'd9 ;

#100
write_data = 8'd27 ;
read_en = 1'b1 ;

#100
write_data = 8'd31 ;

#100
write_data = 8'd43 ;

#100
write_en = 1'b0 ;

#700
write_en = 1'b1 ;
write_data = 8'd13 ;

#100
write_data = 8'd23 ;

#100
write_data = 8'd1 ;

#100
write_data = 8'd3 ;

#100
write_data = 8'd13 ;
 
#100
write_data = 8'd15 ;
 
#200
write_data = 8'd5 ;

#100
read_en = 1'b0;

#100        
write_rst_n = 1'b0 ;    // reset 
read_rst_n  = 1'b0 ;    // is activated

#100
write_rst_n = 1'b1 ;    // reset 
read_rst_n  = 1'b1 ;    // is deactivated
write_data = 8'd20;
 
#100
write_data = 8'd41 ;
  
#100
write_data = 8'd32 ;
  
#100
write_data = 8'd70 ;
  
#100
write_data = 8'd200 ;
  
#100
write_data = 8'd112 ;
  
#100
write_data = 8'd98 ;
  
#100
write_data = 8'd8 ;
  
#100
write_data = 8'd45 ;
  
#100
write_data = 8'd52 ;
  
#100
read_en = 1'b1 ;
 
#1000
$stop;

 end 

endmodule