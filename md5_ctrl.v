/********************************************************************************
* Module Name : md5_ctrl
* Description : MD5 computation control logic
*
********************************************************************************/


module md5_ctrl ( 

                //Inputs
                 clk,
                 rst_n,
                 DataVld,
                 DataIn,
                 ResStateAReg,
                 ResStateBReg,
                 ResStateCReg,
                 ResStateDReg,
                
                //Outputs
                 RoundNum,
                 DataVldExt,
                 Md5Data,
                 MsgDgstVld,
                 MsgDigest
              );


`include "ah_params.vh"
`include "md5_params.vh"
`include "md5_func.vh"

input                                clk;
input                                rst_n;
input                                DataVld;
input  [DATA_WIDTH - 1:0]            DataIn;
input  [STATE_DWIDTH - 1:0]          ResStateAReg;
input  [STATE_DWIDTH - 1:0]          ResStateBReg;
input  [STATE_DWIDTH - 1:0]          ResStateCReg;
input  [STATE_DWIDTH - 1:0]          ResStateDReg;

output [5:0]                         RoundNum;
output                               DataVldExt;
output [DATA_WIDTH - 1:0]            Md5Data;
output                               MsgDgstVld;
output [DATA_WIDTH -1:0]             MsgDigest;

reg [5:0]                            RoundNum;
reg                                  DataVldTemp;
reg                                  MsgDgstVld_send;

wire                                 DataVldExt;
wire [DATA_WIDTH - 1:0]              Md5Data;
wire [MD5_MSG_DIGEST -1:0]           MsgDigest_wire;
reg  [DATA_WIDTH -1:0]               MsgDigest;
wire  [STATE_DWIDTH - 1:0]           ResStateAFlip;
wire  [STATE_DWIDTH - 1:0]           ResStateBFlip;
wire  [STATE_DWIDTH - 1:0]           ResStateCFlip;
wire  [STATE_DWIDTH - 1:0]           ResStateDFlip;
reg   [2:0]                          sending_cnt;
reg   [2:0]                          sending_cnt_r;
reg                                  MsgDgstVld;
wire                                 MsgDgstVld_c;

assign ResStateAFlip =  byte_flip(ResStateAReg);
assign ResStateBFlip =  byte_flip(ResStateBReg);
assign ResStateCFlip =  byte_flip(ResStateCReg);
assign ResStateDFlip =  byte_flip(ResStateDReg);
assign MsgDigest_wire = {ResStateAFlip, ResStateBFlip, ResStateCFlip, ResStateDFlip};

assign DataVldExt = DataVld | DataVldTemp;
assign Md5Data = DataIn;

assign MsgDgstVld_c = (sending_cnt != 0);

always @(posedge clk or negedge rst_n)
  begin
    if (!rst_n) begin
      RoundNum <= 0;
      DataVldTemp <= 0;
    end
    else begin
      if (DataVldExt) begin
        RoundNum <= (RoundNum == 63) ? 0 : RoundNum + 1;
        DataVldTemp <= (RoundNum != 63);
      end
      else begin
        RoundNum <= 0;
        DataVldTemp <= 0;
      end
    end
  end 

always @(posedge clk or negedge rst_n)
  begin
     if (!rst_n) begin
        MsgDgstVld_send <= 1'b0;
        MsgDgstVld <= 1'b0;
     end 
     else begin
        MsgDgstVld_send <= (RoundNum == 63);
        MsgDgstVld <= MsgDgstVld_c;
     end
  end

always @(posedge clk or negedge rst_n)  begin
   if (!rst_n) begin
       sending_cnt_r <= 3'b0;
   end
   else begin
      sending_cnt_r <= sending_cnt;
   end
end

always @(MsgDgstVld_send or sending_cnt_r) begin
   if (MsgDgstVld_send & (sending_cnt_r ==0)) begin
      sending_cnt = 3'b001;
   end 
   else if (sending_cnt_r !=0) begin
      sending_cnt = (sending_cnt_r == 3'b100) ? 0 : sending_cnt_r + 1;
   end
   else begin 
      sending_cnt = 3'b0;
   end
end 

always @(posedge clk) begin
   case (sending_cnt)
      3'b001 : begin
         MsgDigest <= MsgDigest_wire[31:0];
      end
      3'b010 : begin
         MsgDigest <= MsgDigest_wire[63:32];
      end
      3'b011 : begin
         MsgDigest <= MsgDigest_wire[95:64];
      end
      3'b100 : begin
         MsgDigest <= MsgDigest_wire[127:96];
      end
      default : begin
         MsgDigest <= 32'b0;
      end
   endcase
end

endmodule
