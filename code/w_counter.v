module w_counter #(
                    parameter ADDR_WIDTH = 3
                  )
(
input   wire                     w_clk   ,
input   wire                     w_rst_n ,
input   wire                     w_en    ,
input   wire                     w_full  ,
output  reg     [ADDR_WIDTH:0]   w_addr     // binary
);

////// Write Address binary pointer //////
always @(posedge w_clk or negedge w_rst_n)
 begin
    if(!w_rst_n)
     begin
        w_addr <= 'b0 ;
     end
    else if(w_en & !w_full) // write then increament
     begin
        w_addr <= w_addr + 1'b1 ;
     end
 end

endmodule