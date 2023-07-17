module binary2gray #(
                        parameter N = 3
                    )
(
input   wire  [N:0]  bi,
output  wire  [N:0]  gr
);

assign gr = bi ^ (bi >> 1);
 
endmodule