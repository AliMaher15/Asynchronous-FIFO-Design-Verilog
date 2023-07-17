module w_full_calc #(
                            parameter ADDR_WIDTH = 3
                         )
(
input   wire    [ADDR_WIDTH:0]   sync_gr_r_ptr ,
input   wire    [ADDR_WIDTH:0]   gr_w_ptr      ,
output  reg                      w_full                     
);

always@(*)
 begin
  if( gr_w_ptr == {~sync_gr_r_ptr[ADDR_WIDTH:ADDR_WIDTH-1],sync_gr_r_ptr[ADDR_WIDTH-2:0]} )
    begin
        w_full = 1'b1 ;
    end
  else
    begin
        w_full = 1'b0 ;
    end
 end
               
endmodule