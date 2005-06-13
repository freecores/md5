/********************************************************************************
* Multiplex-demultiplex logic
********************************************************************************/


module hash_misc (
     
               //Inputs
                 Md5MsgDgstVld,
                 Md5DataVld,
                 Md5DataIn,
 
                 Md5StateAComb,
                 Md5StateBComb,
                 Md5StateCComb,
                 Md5StateDComb,

                 Md5Addend0A,
                 Md5Addend0B,
                 Md5Addend1A,
                 Md5Addend1B,
            
                 //Output
           
                 msgDgstVld,
                 MuxedDataVld,
                 MuxedDataIn,
 
                 MuxedStateAComb,
                 MuxedStateBComb,
                 MuxedStateCComb,
                 MuxedStateDComb,
                 MuxedStateEComb,
                 MuxedAddend0A,
                 MuxedAddend0B,
                 MuxedAddend1A,
                 MuxedAddend1B
         
         );

`include "ah_params.vh"
`include "md5_params.vh"
 
input                                Md5DataVld;
input [DATA_WIDTH - 1 :0]            Md5DataIn;
input                                Md5MsgDgstVld;

input [STATE_DWIDTH - 1:0]           Md5StateAComb;
input [STATE_DWIDTH - 1:0]           Md5StateBComb;
input [STATE_DWIDTH - 1:0]           Md5StateCComb;
input [STATE_DWIDTH - 1:0]           Md5StateDComb;

input [STATE_DWIDTH - 1:0]           Md5Addend0A;
input [STATE_DWIDTH - 1:0]           Md5Addend0B;
input [STATE_DWIDTH - 1:0]           Md5Addend1A;
input [STATE_DWIDTH - 1:0]           Md5Addend1B;

output                               msgDgstVld;
output [DATA_WIDTH - 1:0]            MuxedDataIn;
output                               MuxedDataVld;
output [STATE_DWIDTH -1:0]           MuxedStateAComb;
output [STATE_DWIDTH -1:0]           MuxedStateBComb;
output [STATE_DWIDTH -1:0]           MuxedStateCComb;
output [STATE_DWIDTH -1:0]           MuxedStateDComb;
output [STATE_DWIDTH -1:0]           MuxedStateEComb;
output [STATE_DWIDTH - 1:0]          MuxedAddend0A;
output [STATE_DWIDTH - 1:0]          MuxedAddend0B;
output [STATE_DWIDTH - 1:0]          MuxedAddend1A;
output [STATE_DWIDTH - 1:0]          MuxedAddend1B;

wire                               msgDgstVld;
wire [DATA_WIDTH - 1:0]            MuxedDataIn;
wire                               MuxedDataVld;
wire [STATE_DWIDTH -1:0]           MuxedStateAComb;
wire [STATE_DWIDTH -1:0]           MuxedStateBComb;
wire [STATE_DWIDTH -1:0]           MuxedStateCComb;
wire [STATE_DWIDTH -1:0]           MuxedStateDComb;
wire [STATE_DWIDTH -1:0]           MuxedStateEComb;
wire [STATE_DWIDTH - 1:0]          MuxedAddend0A;
wire [STATE_DWIDTH - 1:0]          MuxedAddend0B;
wire [STATE_DWIDTH - 1:0]          MuxedAddend1A;
wire [STATE_DWIDTH - 1:0]          MuxedAddend1B;

assign       msgDgstVld = Md5MsgDgstVld;
assign       MuxedDataIn = Md5DataIn;
assign       MuxedDataVld = Md5DataVld;

assign   MuxedStateAComb = Md5StateAComb;
assign   MuxedStateBComb = Md5StateBComb;
assign   MuxedStateCComb = Md5StateCComb;
assign   MuxedStateDComb = Md5StateDComb;
assign   MuxedStateEComb = 32'b0;
           
assign   MuxedAddend0A = Md5Addend0A;
assign   MuxedAddend0B = Md5Addend0B;
assign   MuxedAddend1A = Md5Addend1A;
assign   MuxedAddend1B = Md5Addend1B;

endmodule
