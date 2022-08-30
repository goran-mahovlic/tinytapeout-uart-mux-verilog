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

  assign io_out[5] = led[0];
  assign io_out[6] = led[1];
  assign io_out[7] = led[2];

  wire uart_0_rx;
  assign uart_0_rx = io_in[1];
  wire uart_0_tx;
  assign io_out[0] = uart_0_tx;


  wire uart_1_rx;
  assign uart_1_rx = io_in[2];
  wire uart_1_tx;
  assign io_out[1] = uart_1_tx;

  wire uart_2_rx;
  assign uart_2_rx = io_in[3];  
  wire uart_2_tx;
  assign io_out[2] = uart_2_tx;

  wire uart_3_rx;
  assign uart_3_rx = io_in[4];
  wire uart_3_tx;
  assign io_out[3] = uart_3_tx;

  wire uart_4_rx;
  assign uart_4_rx = io_in[5];
  wire uart_4_tx;
  assign io_out[4] = uart_4_tx;

  wire [1:0] mux;

  assign mux[0] = io_in[6];
  assign mux[1] = io_in[7];

  
//  always @(posedge clk) begin

//    end

    case(mux)
      2'b00 : begin
                uart_0_rx <= uart_1_tx;
                uart_1_rx <= uart_0_tx;
                end
      2'b01 : begin 
                uart_0_rx <= uart_2_tx;
                uart_2_rx <= uart_0_tx;
                end
      2'b10 : begin 
                uart_0_rx <= uart_3_tx;
                uart_3_rx <= uart_0_tx;
                end
      2'b11 : begin
                uart_0_rx <= uart_4_tx;
                uart_4_rx <= uart_0_tx;
                end

      default : begin 
                uart_0_rx <= uart_1_tx;
                uart_1_rx <= uart_0_tx;
                end
    endcase
  end
endmodule