module r_empty_calc #(
                            parameter ADDR_WIDTH = 3
                         )
(
input   wire    [ADDR_WIDTH:0]   sync_gr_w_ptr ,
input   wire    [ADDR_WIDTH:0]   gr_r_ptr      ,
output  reg                      r_empty              
);

always@(*)
 begin
  if(sync_gr_w_ptr == gr_r_ptr)
    begin
        r_empty = 1'b1 ;
    end
   else
    begin
        r_empty = 1'b0 ;
    end
 end
               
endmodule