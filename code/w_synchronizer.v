module w_synchronizer #( parameter ADDR_WIDTH = 3 )
(
input   wire                    w_clk        ,
input   wire                    w_rst_n      ,
input   wire    [ADDR_WIDTH:0]  unsync_r_ptr ,
output  reg     [ADDR_WIDTH:0]  sync_gr_r_ptr
);

//internal connections
reg     [ADDR_WIDTH:0] meta_flop ;

//////////////// Multi Flip Flop ////////////////
always @(posedge w_clk or negedge w_rst_n)
 begin
    if(!w_rst_n)
        begin
            meta_flop     <= 'b0 ;
            sync_gr_r_ptr <= 'b0 ;
        end
    else
        begin
            meta_flop     <= unsync_r_ptr ;
            sync_gr_r_ptr <= meta_flop    ;
        end
 end

endmodule