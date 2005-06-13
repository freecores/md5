/********************************************************************************
* Module Name : hash_core
* Description : MD5 computation 
*               Outputs Message Digest
* 
*
********************************************************************************
*          Esencia Technology Proprietary and Confidential
*          All rights reserved (c) 2004 by Esencia Technolgy
********************************************************************************/
module hash_core (
     
               //Inputs
                 clk,
                 rst_n,
                 stateVld,
                 stateAIn,
                 stateBIn,
                 stateCIn,
                 stateDIn,
                 dataIn,
                 dataVld,
                 RoundNum,

                //Outputs
                 msgDgstVld,
                 msgDigest
         );

`include "md5_params.vh"
`include "ah_params.vh"
 
input                                clk;
input                                rst_n;
input                                dataVld;
input  [DATA_WIDTH - 1:0]            dataIn;
input                                stateVld;
input  [STATE_DWIDTH - 1:0]          stateAIn;
input  [STATE_DWIDTH - 1:0]          stateBIn;
input  [STATE_DWIDTH - 1:0]          stateCIn;
input  [STATE_DWIDTH - 1:0]          stateDIn;

output                               msgDgstVld;
output [DATA_WIDTH -1:0]             msgDigest;
output [5:0]                         RoundNum;

wire  [STATE_DWIDTH - 1:0]          StateAReg;
wire  [STATE_DWIDTH - 1:0]          StateBReg;
wire  [STATE_DWIDTH - 1:0]          StateCReg;
wire  [STATE_DWIDTH - 1:0]          StateDReg;
wire  [STATE_DWIDTH - 1:0]          A_Reg;
wire  [STATE_DWIDTH - 1:0]          B_Reg;
wire  [STATE_DWIDTH - 1:0]          C_Reg;
wire  [STATE_DWIDTH - 1:0]          D_Reg;
wire  [STATE_DWIDTH - 1:0]          Md5StateAComb;
wire  [STATE_DWIDTH - 1:0]          Md5StateBComb;
wire  [STATE_DWIDTH - 1:0]          Md5StateCComb;
wire  [STATE_DWIDTH - 1:0]          Md5StateDComb;
wire  [STATE_DWIDTH - 1:0]          MuxedStateAComb;
wire  [STATE_DWIDTH - 1:0]          MuxedStateBComb;
wire  [STATE_DWIDTH - 1:0]          MuxedStateCComb;
wire  [STATE_DWIDTH - 1:0]          MuxedStateDComb;
wire  [STATE_DWIDTH - 1:0]          MuxedStateEComb;
wire  [STATE_DWIDTH - 1:0]          ResStateAReg;
wire  [STATE_DWIDTH - 1:0]          ResStateBReg;
wire  [STATE_DWIDTH - 1:0]          ResStateCReg;
wire  [STATE_DWIDTH - 1:0]          ResStateDReg;
wire  [BLOCK_SIZE-1:0]              BlockData;
wire  [DATA_WIDTH - 1 :0]           WtDataIntmdt;
wire  [STATE_DWIDTH - 1:0]          AddResFinal1;
wire  [STATE_DWIDTH - 1:0]          AddResFinal2;
wire  [STATE_DWIDTH - 1:0]          AddResFinal3;
wire                                msgDgstVld;
wire [DATA_WIDTH -1:0]              msgDigest;
wire                                Md5MsgDgstVld;
wire [MD5_MSG_DIGEST -1:0]          Md5MsgDigest;
wire [DATA_WIDTH -1 :0]             Md5DataIn;
wire                                MuxedDataVld;
wire [DATA_WIDTH -1 :0]             MuxedDataIn;
wire [STATE_DWIDTH - 1:0]           Md5Addend0A;
wire [STATE_DWIDTH - 1:0]           Md5Addend0B;
wire [STATE_DWIDTH - 1:0]           Md5Addend1A;
wire [STATE_DWIDTH - 1:0]           Md5Addend1B;
wire [STATE_DWIDTH - 1:0]           Md5Addend3A;
wire [STATE_DWIDTH - 1:0]           Md5Addend3B;
wire [STATE_DWIDTH - 1:0]           MuxedAddend0A;
wire [STATE_DWIDTH - 1:0]           MuxedAddend0B;
wire [STATE_DWIDTH - 1:0]           MuxedAddend1A;
wire [STATE_DWIDTH - 1:0]           MuxedAddend1B;
wire [STATE_DWIDTH - 1:0]           MuxedAddend2A;
wire [STATE_DWIDTH - 1:0]           MuxedAddend2B;
wire [5:0]                          RoundNum;

md5_top u_md5_top_0 (

                 .clk(clk),
                 .rst_n(rst_n),
                 .dataIn(dataIn),
                 .dataVld(dataVld),

                 .ResStateAReg(ResStateAReg),
                 .ResStateBReg(ResStateBReg),
                 .ResStateCReg(ResStateCReg),
                 .ResStateDReg(ResStateDReg),
                 .AddRes1(AddResFinal1),
                 .AddRes2(AddResFinal3),

                 .StateAReg(StateAReg),
                 .StateBReg(StateBReg),
                 .StateCReg(StateCReg),
                 .StateDReg(StateDReg),
                 .BlockData(BlockData),

                 .Md5FuncValue(Md5Addend0A),
                 .TValue(Md5Addend1B),
                 .XValue(Md5Addend1A),
                 .AddendState1(Md5Addend0B),
                 .AddendState2(Md5Addend3B),
                 .ShiftedAddend(Md5Addend3A),
                 .RoundNum(RoundNum),

                 .Md5Data(Md5DataIn),
                 .StateAComb(Md5StateAComb),
                 .StateBComb(Md5StateBComb),
                 .StateCComb(Md5StateCComb),
                 .StateDComb(Md5StateDComb),

                 .msgDgstVld(Md5MsgDgstVld),
                 .msgDigest(msgDigest)

);

adders u_adders_0   ( 
                       //Inputs
                       .Addend0A(MuxedAddend0A),
                       .Addend0B(MuxedAddend0B),
                       .Addend1A(MuxedAddend1A),
                       .Addend1B(MuxedAddend1B),
                       .Addend2A(32'b0),
                       .Addend3A(Md5Addend3A),
                       .Addend3B(Md5Addend3B),
                       .StateAReg(StateAReg),
                       .StateBReg(StateBReg),
                       .StateCReg(StateCReg),
                       .StateDReg(StateDReg),
                       .A_Reg(A_Reg),
                       .B_Reg(B_Reg),
                       .C_Reg(C_Reg),
                       .D_Reg(D_Reg),

                       //Outputs
                       .ResStateAReg(ResStateAReg),
                       .ResStateBReg(ResStateBReg),
                       .ResStateCReg(ResStateCReg),
                       .ResStateDReg(ResStateDReg),
                       .AddResFinal1(AddResFinal1),
                       .AddResFinal2(AddResFinal2),
                       .AddResFinal3(AddResFinal3)
                    );

                  
ah_regs u_regs_0 (
                      //Inputs
                      .rst_n(rst_n),
                      .clk(clk),
                      .DataVld(MuxedDataVld),
                      .DataIn(MuxedDataIn),
                      .stateVld(stateVld),
                      .stateAIn(stateAIn),
                      .stateBIn(stateBIn),
                      .stateCIn(stateCIn),
                      .stateDIn(stateDIn),
                      .StateAComb(MuxedStateAComb),
                      .StateBComb(MuxedStateBComb),
                      .StateCComb(MuxedStateCComb),
                      .StateDComb(MuxedStateDComb),
                      .StateEComb(MuxedStateEComb),
                    
              //Outputs
                      .StateAReg(StateAReg),
                      .StateBReg(StateBReg),
                      .StateCReg(StateCReg),
                      .StateDReg(StateDReg),
                      .A_Reg(A_Reg),
                      .B_Reg(B_Reg),
                      .C_Reg(C_Reg),
                      .D_Reg(D_Reg),
                      .BlockOut(BlockData)
                    );

hash_misc u_hash_misc_0 (
     
         //Inputs
                 .Md5MsgDgstVld(Md5MsgDgstVld),
                 .Md5DataIn(Md5DataIn),
                 .Md5DataVld(dataVld),
                 .Md5StateAComb(Md5StateAComb),
                 .Md5StateBComb(Md5StateBComb),
                 .Md5StateCComb(Md5StateCComb),
                 .Md5StateDComb(Md5StateDComb),
                 .Md5Addend0A(Md5Addend0A),
                 .Md5Addend0B(Md5Addend0B),
                 .Md5Addend1A(Md5Addend1A),
                 .Md5Addend1B(Md5Addend1B),
            
                 //Output
                 .msgDgstVld(msgDgstVld),
                 .MuxedDataIn(MuxedDataIn),
                 .MuxedDataVld(MuxedDataVld),
                 .MuxedStateAComb(MuxedStateAComb),
                 .MuxedStateBComb(MuxedStateBComb),
                 .MuxedStateCComb(MuxedStateCComb),
                 .MuxedStateDComb(MuxedStateDComb),
                 .MuxedStateEComb(MuxedStateEComb),
                 .MuxedAddend0A(MuxedAddend0A),
                 .MuxedAddend0B(MuxedAddend0B),
                 .MuxedAddend1A(MuxedAddend1A),
                 .MuxedAddend1B(MuxedAddend1B)
     
         );

endmodule
