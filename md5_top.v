/********************************************************************************
* Module Name : md5_top
* Description : MD5 computation  top level
* 
*
********************************************************************************
*          Esencia Technology Proprietary and Confidential
*          All rights reserved (c) 2004 by Esencia Technolgy
********************************************************************************/

module md5_top (
     
               //Inputs
                 clk,
                 rst_n,
                 dataVld,
                 dataIn,

                //from adders
                 ResStateAReg,
                 ResStateBReg,
                 ResStateCReg,
                 ResStateDReg,
                 AddRes1,
                 AddRes2,

                // from Register file
                 StateAReg,
                 StateBReg,
                 StateCReg,
                 StateDReg,
                 BlockData,
                 
               //Outputs
                // To Adders
                 Md5FuncValue,
                 TValue,
                 XValue,
                 AddendState1,
                 AddendState2,
                 ShiftedAddend,
                 RoundNum,
                
                // To Register file
                 Md5Data,
                 StateAComb,
                 StateBComb,
                 StateCComb,
                 StateDComb,
                
                //final output
                 msgDgstVld,
                 msgDigest
                );

`include "ah_params.vh"
`include "md5_params.vh"
 
input                                clk;
input                                rst_n;
input                                dataVld;
input  [DATA_WIDTH - 1:0]            dataIn;
input  [STATE_DWIDTH - 1:0]          ResStateAReg;
input  [STATE_DWIDTH - 1:0]          ResStateBReg;
input  [STATE_DWIDTH - 1:0]          ResStateCReg;
input  [STATE_DWIDTH - 1:0]          ResStateDReg;
input  [STATE_DWIDTH - 1:0]          AddRes1;
input  [STATE_DWIDTH - 1:0]          AddRes2;

input  [STATE_DWIDTH - 1:0]          StateAReg;
input  [STATE_DWIDTH - 1:0]          StateBReg;
input  [STATE_DWIDTH - 1:0]          StateCReg;
input  [STATE_DWIDTH - 1:0]          StateDReg;
input  [BLOCK_SIZE-1:0]              BlockData;

output [STATE_DWIDTH - 1:0]          Md5FuncValue;
output [STATE_DWIDTH - 1:0]          TValue;
output [DATA_WIDTH - 1 :0]           XValue;
output [STATE_DWIDTH - 1:0]          AddendState1;
output [STATE_DWIDTH - 1:0]          AddendState2;
output [STATE_DWIDTH - 1:0]          ShiftedAddend;
output [STATE_DWIDTH - 1:0]          StateAComb;
output [STATE_DWIDTH - 1:0]          StateBComb;
output [STATE_DWIDTH - 1:0]          StateCComb;
output [STATE_DWIDTH - 1:0]          StateDComb;
output [DATA_WIDTH - 1:0]            Md5Data;
output [5:0]                         RoundNum;

output                               msgDgstVld;
output [DATA_WIDTH -1:0]             msgDigest;

wire  [5:0]                         RoundNum;
wire [DATA_WIDTH - 1:0]             Md5Data;

wire [STATE_DWIDTH - 1:0]          Md5FuncValue;
wire [STATE_DWIDTH - 1:0]          TValue;
wire [DATA_WIDTH - 1 :0]           XValue;
wire [STATE_DWIDTH - 1:0]          AddendState1;
wire [STATE_DWIDTH - 1:0]          AddendState2;
wire [STATE_DWIDTH - 1:0]          ShiftedAddend;
wire [STATE_DWIDTH - 1:0]          StateAComb;
wire [STATE_DWIDTH - 1:0]          StateBComb;
wire [STATE_DWIDTH - 1:0]          StateCComb;
wire [STATE_DWIDTH - 1:0]          StateDComb;
wire                               DataVldExt;

md5_ctrl u_md5_ctrl_0 (
                      //Inputs
                      .clk(clk),
                      .rst_n(rst_n),
                      .DataVld(dataVld),
                      .DataIn(dataIn),
                      .ResStateAReg(ResStateAReg),
                      .ResStateBReg(ResStateBReg),
                      .ResStateCReg(ResStateCReg),
                      .ResStateDReg(ResStateDReg),
                
                      //Outputs
                      .MsgDgstVld(msgDgstVld),
                      .MsgDigest(msgDigest),
                      .DataVldExt(DataVldExt),
                      .Md5Data(Md5Data),
                      .RoundNum(RoundNum)
                     );

md5_comb u_md5_comb_0 ( 
                       //Inputs
                       .RoundNum(RoundNum),
                       .StateAReg(StateAReg),
                       .StateBReg(StateBReg),
                       .StateCReg(StateCReg),
                       .StateDReg(StateDReg),
                       .BlockIn(BlockData),
                       .DataVld(DataVldExt),
                       .DataIn(dataIn),
                       .AddRes1(AddRes1),
                       .AddRes2(AddRes2),

                       //Outputs
                       .Md5FuncValue(Md5FuncValue),
                       .TValue(TValue),
                       .XValue(XValue),
                       .StateAComb(StateAComb),
                       .StateBComb(StateBComb),
                       .StateCComb(StateCComb),
                       .StateDComb(StateDComb),
                       .AddendState1(AddendState1),
                       .AddendState2(AddendState2),
                       .ShiftedAddend(ShiftedAddend)
             );

endmodule
