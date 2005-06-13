/********************************************************************************
* Module     : md5_padding
* Description: md5 Padding block
*
********************************************************************************
*          Esencia Technology Proprietary and Confidential
*          All rights reserved (c) 2005 by Esencia Technolgy
********************************************************************************/


module md5_padding (

         //Inputs
          clk,
          rst_n,
          DataVld,
          InitVec,
          DataIn,
          DataFirst,
          DataLast,
          DataNumb,
          RoundNum,
         
         //Outputs 
          DataBusy,
          Md5DataIn,
          Md5DataVld,
          Md5StateAIn,
          Md5StateBIn,
          Md5StateCIn,
          Md5StateDIn,
          Md5StateVld
      );

`include "md5_params.vh"
`include "ah_params.vh"
`include "md5_func.vh"
    
input                                clk;
input                                rst_n;
input                                DataVld; // Valid flag for Data or InitVec
input  [DATA_WIDTH - 1:0]            DataIn; // 32 bit DataIn or Initvect
input                                DataFirst; // First chunk
input                                DataLast; // Last chunk of data
input [5:0]                          DataNumb; // Number of valid bits in 
                                               // last chuck of data
input [5:0]                          RoundNum;
input                                InitVec;  // Inidicate Init Vector
                                  
output                                Md5DataVld;
output  [DATA_WIDTH - 1:0]            Md5DataIn;
output                                Md5StateVld;
output  [STATE_DWIDTH - 1:0]          Md5StateAIn;
output  [STATE_DWIDTH - 1:0]          Md5StateBIn;
output  [STATE_DWIDTH - 1:0]          Md5StateCIn;
output  [STATE_DWIDTH - 1:0]          Md5StateDIn;
output                                DataBusy;

reg [3:0]                             DinCntReg;
reg [3:0]                             DinCnt;
reg [63:0]                            PktLength;
wire [63:0]                           PktLengthBigEnd;

reg                                   Md5DataVld;
reg                                   Md5DataVldTemp;
reg  [DATA_WIDTH - 1:0]               Md5DataIn;
reg  [DATA_WIDTH - 1:0]               Md5DataInTemp;
reg                                   Md5StateVld;
reg  [STATE_DWIDTH - 1:0]             Md5StateAIn;
reg  [STATE_DWIDTH - 1:0]             Md5StateBIn;
reg  [STATE_DWIDTH - 1:0]             Md5StateCIn;
reg  [STATE_DWIDTH - 1:0]             Md5StateDIn;

reg [1:0]                             InitVecCnt;
reg                                   PktEnded;
wire                                  DataBusy;
wire [8:0]                            PktLengthMod;
reg  [2:0]                            SendDataCur;
reg [2:0]                             SendDataNxt;
reg                                   Pad1Nxt; // Indicate to pad 1
                                               // in Next data cycle
reg                                   Pad1NxtReg;
reg                                   Send4SecRnd;
reg                                   Send4SecRndReg;

assign PktLengthMod = PktLength[8:0]; //PktLength % 512

assign DataBusy = PktEnded || (RoundNum > 14) || (SendDataCur == 4) ||
                  (SendDataCur == 5) || (SendDataCur == 6);

assign PktLengthBigEnd = {PktLength[7:0], PktLength[15:8], PktLength[23:16],
                         PktLength[31:24], PktLength[39:32], PktLength[47:40],
                         PktLength[55:48], PktLength[63:56]};


// Send State Value incase of InitVec

always @(posedge clk or negedge rst_n) begin
   if (~rst_n) begin
     InitVecCnt <= 3'b0;
     Md5StateVld <= 1'b0;
   end
   else begin
     InitVecCnt <= InitVec  ? (InitVecCnt == 3) ? 0 :
                   InitVecCnt + 1 : InitVecCnt;
     Md5StateVld <= (InitVecCnt == 3) && InitVec;
   end
end

always @(posedge clk) begin
   if (InitVec) begin
     case (InitVecCnt)
        3'b000 : begin
          Md5StateAIn <= DataIn;
        end
        3'b001 : begin
          Md5StateBIn <= DataIn;
        end
        3'b010 : begin
          Md5StateCIn <= DataIn;
        end
        3'b011 : begin
          Md5StateDIn <= DataIn;
        end
     endcase
   end
end

// Start Collecting 512 byte (32x16 cycle)
//
always @(posedge clk or negedge rst_n) begin
  if (~rst_n) begin
     DinCntReg <= 4'b0;
     PktLength <= 64'b0;
     PktEnded <= 1'b0;
     SendDataCur <= 2'b0;
     Pad1NxtReg <= 1'b0;
     Send4SecRndReg <= 1'b0;
  end
  else begin
     SendDataCur <= SendDataNxt;
     Send4SecRndReg <= Send4SecRnd;
     Pad1NxtReg <= Pad1Nxt;
     PktEnded <= (DinCntReg == 15) ? 1'b0 : DataLast ?
                 1'b1 : PktEnded;
     DinCntReg <= DinCnt;
     if (DataVld) begin
        if (DataFirst) begin
           PktLength <= DataLast ? DataNumb : 32;
        end
        else begin
           PktLength <= DataLast ? PktLength + DataNumb :
                         PktLength + 32;
        end
     end
  end
end

// Data Send FSM to  CORE
parameter IDLE                 = 0;
parameter SEND_DATA            = 1;
parameter SECOND_ROUND_CHK0    = 2;
parameter SECOND_ROUND_CHK1    = 3;
parameter WAIT                 = 4;
parameter WAIT2                = 5;
parameter SECOND_ROUND         = 6;

always @(SendDataCur or PktEnded or DinCntReg
         or DataVld or DataLast or DataNumb or
         Pad1NxtReg or Send4SecRndReg or RoundNum or
         DataIn or PktLengthBigEnd ) begin
    Md5DataVldTemp = 1'b0;
    Md5DataInTemp = 32'b0;
    Pad1Nxt = 1'b0;
    Send4SecRnd = 1'b0;
    SendDataNxt = 3'b0;
    DinCnt = 4'b0;
    case (SendDataCur)
       IDLE : begin
          if (DataVld) begin
             SendDataNxt = SEND_DATA;
             Md5DataInTemp = DataLast ? PadData(DataNumb, DataIn) : DataIn;
             Md5DataVldTemp = 1'b1;
             Pad1Nxt = DataLast && (DataNumb == 32);
             DinCnt = 0;
          end
       end
       SEND_DATA : begin
         DinCnt = DinCntReg + 1;
         Md5DataVldTemp = 1'b1;
         Pad1Nxt = DataLast && (DataNumb == 32);
         SendDataNxt =  (DinCntReg < 12) ? SEND_DATA : SECOND_ROUND_CHK0;
         Md5DataInTemp = Pad1NxtReg ? 32'h80000000 : DataLast ? PadData(DataNumb, DataIn) : PktEnded ?
                         32'b0 : DataIn;
       end
       SECOND_ROUND_CHK0 : begin
          DinCnt = DinCntReg + 1;
          Md5DataVldTemp = 1'b1;
          SendDataNxt = SECOND_ROUND_CHK1;
          Send4SecRnd = DataLast || Pad1NxtReg; 
          Pad1Nxt = DataLast && (DataNumb == 32);
          if (DataLast) begin
             Md5DataInTemp = PadData(DataNumb, DataIn);
          end
          else  begin
             Md5DataInTemp = Pad1NxtReg ? 32'h80000000 : 
                             PktEnded ? PktLengthBigEnd[63:32] : DataIn;
          end
       end
       SECOND_ROUND_CHK1 : begin
          DinCnt = DinCntReg + 1;
          Md5DataVldTemp = 1'b1;
          SendDataNxt = (Send4SecRndReg || DataLast) ? WAIT : IDLE; 
          Pad1Nxt = DataLast && (DataNumb == 32);
          if (DataLast) begin
             Md5DataInTemp = PadData(DataNumb, DataIn);
          end
          else  begin
             Md5DataInTemp = Pad1NxtReg ? 32'h80000000 : 
                             PktEnded ? Send4SecRndReg ? 32'b0 :
                             PktLengthBigEnd[31:0] : DataIn;
          end
       end
       WAIT : begin
          DinCnt = 0;
          Md5DataVldTemp = 1'b0;
          Pad1Nxt = Pad1NxtReg;
          SendDataNxt = (RoundNum == 63) ? WAIT2 : WAIT;
       end
       WAIT2 : begin
          DinCnt = 0;
          SendDataNxt =  SECOND_ROUND;
          Pad1Nxt = Pad1NxtReg;
          Md5DataVldTemp = 1'b0;
       end
       SECOND_ROUND : begin
          DinCnt = DinCntReg + 1;
          Pad1Nxt = (DinCntReg == 0) ? Pad1NxtReg : 1'b0;
          Md5DataVldTemp = (DinCntReg <= 15);
          SendDataNxt = (DinCntReg == 15) ? IDLE : SECOND_ROUND;
          if (DinCntReg < 14) begin
            Md5DataInTemp = Pad1Nxt ? 32'h80000000 : 32'b0;
          end 
          else begin
            Md5DataInTemp = (DinCntReg == 14) ? PktLengthBigEnd[63:32] :
                            PktLengthBigEnd[31:0];
          end
       end
       default : begin
          Md5DataVldTemp = 1'b0;
          Md5DataInTemp = 32'b0;
          Pad1Nxt = 1'b0;
          Send4SecRnd = 1'b0;
          DinCnt = 4'b0;
       end
    endcase
end
             
// Send Pkt Data 512 byte with padding
always @(posedge clk or negedge rst_n) begin
  if (~rst_n) begin
    Md5DataVld <= 1'b0;
    Md5DataIn <= 32'b0;
  end
  else begin
     Md5DataVld <= Md5DataVldTemp;
     Md5DataIn <= Md5DataInTemp;
  end
end
endmodule
