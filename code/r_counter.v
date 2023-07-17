module r_counter #(
                    parameter ADDR_WIDTH = 3
                  )
(
input   wire                     r_clk   ,
input   wire                     r_rst_n ,
input   wire                     r_en    ,
input   wire                     r_empty ,
output  reg     [ADDR_WIDTH:0]   r_addr  ,   // binary
output  reg                      r_valid 
);

////// Read Address binary pointer //////
always @(posedge r_clk or negedge r_rst_n)
 begin
    if(!r_rst_n)
     begin
        r_addr <= 'b0 ;
        r_valid <= 1'b0;
     end
    else if(r_en & !r_empty) // read the value then increament
     begin
        r_addr <= r_addr + 1'b1 ;
        r_valid <= 1'b1 ;
     end
    else if(r_empty)
     begin
        r_addr <= r_addr;
        r_valid <= 1'b0 ;
     end
 end

endmodule