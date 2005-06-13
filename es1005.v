/********************************************************************************
* Module     : es1005
* Description: MD5 Top level
*
********************************************************************************
*          Esencia Technology Proprietary and Confidential
*          All rights reserved (c) 2005 by Esencia Technolgy
********************************************************************************/


module es1005 (

         //Inputs
          clk,
          rst_n,
          DataVld,
          DataIn,
          DataFirst,
          DataLast,
          DataNumb,
          InitVec,
         
         //Outputs 
          MsgDgstVld,
          MsgDigest,
          DataBusy
      );

`include "md5_params.vh"
`include "ah_params.vh"
    
input                                clk;
input                                rst_n;
input                                DataVld; // Valid flag for Data or InitVec
input  [DATA_WIDTH - 1:0]            DataIn; // 32 bit DataIn or Initvect
input                                DataFirst; // First chunk
input                                DataLast; // Last chunk of data
input [5:0]                          DataNumb; // Number of valid bits in 
                                               // last chuck of data
input                                InitVec;  // Inidicate Init Vector

output                               MsgDgstVld;
output [DATA_WIDTH -1:0]             MsgDigest;
output                               DataBusy; // Inidicate core is busy

wire                                 MsgDgstVld;
wire                                 DataBusy;
wire [DATA_WIDTH -1:0]               MsgDigest;
wire                                 Md5DataVld;
wire  [DATA_WIDTH - 1:0]             Md5DataIn;
wire                                 Md5StateVld;
wire  [STATE_DWIDTH - 1:0]           Md5StateAIn;
wire  [STATE_DWIDTH - 1:0]           Md5StateBIn;
wire  [STATE_DWIDTH - 1:0]           Md5StateCIn;
wire  [STATE_DWIDTH - 1:0]           Md5StateDIn;
wire [5:0]                           RoundNum;

hash_core u_hash_core (

       .clk(clk),
       .rst_n(rst_n),
       .dataIn(Md5DataIn),
       .dataVld(Md5DataVld),
       .stateVld(Md5StateVld),
       .stateAIn(Md5StateAIn),
       .stateBIn(Md5StateBIn),
       .stateCIn(Md5StateCIn),
       .stateDIn(Md5StateDIn),
       .RoundNum(RoundNum),
       .msgDgstVld(MsgDgstVld),
       .msgDigest(MsgDigest)
    );

md5_padding u_md5_padding (

          .clk(clk),
          .rst_n(rst_n),
          .DataVld(DataVld),
          .DataIn(DataIn),
          .DataFirst(DataFirst),
          .DataLast(DataLast),
          .DataNumb(DataNumb),
          .InitVec(InitVec),
          .RoundNum(RoundNum),
          .DataBusy(DataBusy),
          .Md5DataIn(Md5DataIn),
          .Md5DataVld(Md5DataVld),
          .Md5StateAIn(Md5StateAIn),
          .Md5StateBIn(Md5StateBIn),
          .Md5StateCIn(Md5StateCIn),
          .Md5StateDIn(Md5StateDIn),
          .Md5StateVld(Md5StateVld)
      );

endmodule
