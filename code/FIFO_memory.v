module FIFO_memory #(
                        parameter D_WIDTH    = 8 ,
                                  DEPTH      = 16,
                                  ADDR_WIDTH = 3
                    )
(
// write clock domain
input  wire                    w_clk  ,
input  wire                    w_rst_n,
input  wire                    w_en   ,
input  wire  [D_WIDTH-1:0]     w_data ,
input  wire  [ADDR_WIDTH-1:0]  w_addr ,
// read clock domain
input  wire                    r_clk   ,
input  wire                    r_rst_n ,
input  wire                    r_en    ,
input  wire  [ADDR_WIDTH-1:0]  r_addr  ,
output reg   [D_WIDTH-1:0]     r_data
);

reg [D_WIDTH-1:0] memory [0:DEPTH-1];

integer i;

///////////// Write into the Memory //////////////
always @(posedge w_clk or negedge w_rst_n)
 begin
    if(!w_rst_n)
     begin
        for(i=0 ; i<DEPTH ; i=i+1) begin
            memory[i] <= 'b0 ;
        end
     end
    else if(w_en)
     begin
        memory[w_addr] <= w_data ; 
     end
 end

///////////// Read from the Memory //////////////
always @(posedge r_clk or negedge r_rst_n)
 begin
    if(!r_rst_n)
     begin
        r_data <= 'b0 ;
     end
    else if(r_en)
     begin
        r_data <= memory[r_addr] ;
     end
 end

endmodule