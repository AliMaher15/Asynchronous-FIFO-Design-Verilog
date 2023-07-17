module r_synchronizer #( parameter ADDR_WIDTH = 3 )
(
input   wire                    r_clk        ,
input   wire                    r_rst_n      ,
input   wire    [ADDR_WIDTH:0]  unsync_w_ptr ,
output  reg     [ADDR_WIDTH:0]  sync_gr_w_ptr
);

//internal connections
reg     [ADDR_WIDTH:0] meta_flop ;

//////////////// Multi Flip Flop ////////////////
always @(posedge r_clk or negedge r_rst_n)
 begin
    if(!r_rst_n)
        begin
            meta_flop     <= 'b0 ;
            sync_gr_w_ptr <= 'b0 ;
        end
    else
        begin
            meta_flop     <= unsync_w_ptr ;
            sync_gr_w_ptr <= meta_flop    ;
        end
 end

endmodule