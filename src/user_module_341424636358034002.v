`default_nettype none

//  Top level io for this module should stay the same to fit into the scan_wrapper.
//  The pin connections within the user_module are up to you,
//  although (if one is present) it is recommended to place a clock on io_in[0].
//  This allows use of the internal clock divider if you wish.
module user_module_341424636358034002(
  input [7:0] io_in, 
  output [7:0] io_out
);

  // using io_in[0] as clk
wire clk;
assign clk = io_in[0];
wire [2:0] led;

assign io_out[0] = led[0];
assign io_out[6] = led[1];
assign io_out[7] = led[2];

wire [1:0] mux;

assign mux[0] = io_in[6];
assign mux[1] = io_in[7];

reg [4:0] uart_rx;
reg [4:0] uart_tx;

wire [4:0] i_uart;
wire [4:0] o_uart;

assign i_uart = uart_rx;
assign o_uart = uart_tx;

assign io_out[5:1] = o_uart[4:0];
assign i_uart[4:0] = io_in[5:1];

always @(posedge clk) begin

    case(mux)
      2'b00 : begin
                uart_tx[1] <= uart_rx[0];
                uart_tx[0] <= uart_rx[1];
            end
      2'b01 : begin 
                uart_tx[2] <= uart_rx[0];
                uart_tx[0] <= uart_rx[2];
            end
      2'b10 : begin 
                uart_tx[3] <= uart_rx[0];
                uart_tx[0] <= uart_rx[3];
            end
      2'b11 : begin
                uart_tx[4] <= uart_rx[0];
                uart_tx[0] <= uart_rx[4];
            end
      default : begin 
                uart_tx[1] <= uart_rx[0];
                uart_tx[0] <= uart_rx[1];
                end
    endcase
end

endmodule