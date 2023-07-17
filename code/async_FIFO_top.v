//-------------------------------------------------------------
// Copyright 2022 Ali Maher Abdelsalam
//
// 8-deep Asynchronous FIFO
// based heavely on Cliff Cumming's paper:
//   " Simulation and Synthesis Techniques for "
//    "      Asynchronous FIFO Design          "
//
//-------------------------------------------------------------
module async_FIFO_top #(
                            parameter D_WIDTH    = 8,
                                      DEPTH      = 8,
                                      ADDR_WIDTH = 3
                        )
(
// write clock domain
input  wire                 w_clk   ,
input  wire                 w_rst_n ,
input  wire                 w_en    ,
input  wire  [D_WIDTH-1:0]  w_data  ,
output wire                 w_full  ,
// read clock domain
input  wire                 r_clk    ,
input  wire                 r_rst_n  ,
input  wire                 r_en     ,
output wire  [D_WIDTH-1:0]  r_data   ,
output wire                 r_empty  ,
output wire                 r_valid    // to show when r_data is valid
);

// Internal connections
wire                  w_en_and;
wire [ADDR_WIDTH:0]   w_addr, //binary
                      r_addr, //binary
                      gr_w_ptr,
                      gr_r_ptr,                
                      sync_gr_w_ptr,
                      sync_gr_r_ptr;


///////////////////// FIFO Memory /////////////////////
FIFO_memory #(.D_WIDTH(D_WIDTH), .DEPTH(DEPTH), .ADDR_WIDTH(ADDR_WIDTH))
mem (
     .w_clk(w_clk)                   ,
     .w_rst_n(w_rst_n)               ,
     .w_en(w_en_and)                 ,
     .w_data(w_data)                 ,
     .w_addr(w_addr[ADDR_WIDTH-1:0]) ,
     .r_addr(r_addr[ADDR_WIDTH-1:0]) ,
     .r_clk(r_clk)                   ,
     .r_rst_n(r_rst_n)               ,
     .r_en(r_en)                     ,
     .r_data(r_data)
    );

///////////////////////////////////////////////////////
//////////////////// Write Domain /////////////////////
///////////////////////////////////////////////////////

/////////////////// write counter ///////////////////
w_counter #(.ADDR_WIDTH(ADDR_WIDTH))
w_count (
         .w_clk(w_clk)     ,
         .w_rst_n(w_rst_n) ,
         .w_full(w_full)   ,
         .w_en(w_en)       ,
         .w_addr(w_addr)
        );

///////////////// write synchronizer ////////////////
w_synchronizer #(.ADDR_WIDTH(ADDR_WIDTH))
w_sync ( 
        .w_clk(w_clk)                ,
        .w_rst_n(w_rst_n)            ,
        .unsync_r_ptr(gr_r_ptr)      ,
        .sync_gr_r_ptr(sync_gr_r_ptr)
       );

///////////// binary to gray converter //////////////
binary2gray #(.N(ADDR_WIDTH))
U0bin2gr (
          .bi(r_addr)  ,
          .gr(gr_r_ptr)
         );

//////////////// Full Logic Block ///////////////////
w_full_calc #(.ADDR_WIDTH(ADDR_WIDTH))
full (
      .sync_gr_r_ptr(sync_gr_r_ptr) , // sync gray (rptr in wdomain)
      .gr_w_ptr(gr_w_ptr)           , // gray
      .w_full(w_full)               
     );

///////////////////// AND Gate //////////////////////
and_gate U0_AND (
.a(w_en),
.b(!w_full),
.out(w_en_and)
);

///////////////////////////////////////////////////////
///////////////////// Read Domain /////////////////////
///////////////////////////////////////////////////////

/////////////////// read counter ///////////////////
r_counter #(.ADDR_WIDTH(ADDR_WIDTH)) 
r_count ( 
         .r_clk(r_clk)     ,
         .r_rst_n(r_rst_n) ,
         .r_empty(r_empty) ,
         .r_en(r_en)       ,
         .r_addr(r_addr)   ,
         .r_valid(r_valid)
        );

///////////////// read synchronizer /////////////////
r_synchronizer #(.ADDR_WIDTH(ADDR_WIDTH))  
r_sync (
         .r_clk(r_clk)                , 
         .r_rst_n(r_rst_n)            ,
         .unsync_w_ptr(gr_w_ptr)      ,   
         .sync_gr_w_ptr(sync_gr_w_ptr)
        );

///////////// binary to gray converter //////////////
binary2gray #(.N(ADDR_WIDTH)) 
U1bin2gr ( 
           .bi(w_addr)  ,
           .gr(gr_w_ptr)
          );

//////////////// Empty Logic Block //////////////////
r_empty_calc #(.ADDR_WIDTH(ADDR_WIDTH))
empty (
        .sync_gr_w_ptr(sync_gr_w_ptr) , // sync gray (wptr in rdomain)
        .gr_r_ptr(gr_r_ptr)           , // gray
        .r_empty(r_empty)
       );

endmodule