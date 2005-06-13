/****************************************************************************
Register file 
****************************************************************************/


module ah_regs (
              
               //Inputs 
          rst_n,
               clk,
               DataVld,
               DataIn,
               stateVld,
               stateAIn,
               stateBIn,
               stateCIn,
               stateDIn,
          StateAComb,
          StateBComb,
          StateCComb,
          StateDComb,
          StateEComb,

          //Outputs
          StateAReg,
          StateBReg,
          StateCReg,
          StateDReg,
               A_Reg,
               B_Reg,
               C_Reg,
               D_Reg,
               BlockOut
               );

`include "ah_params.vh"

input                                rst_n;
input                                clk;
input                                DataVld;
input  [DATA_WIDTH - 1:0]            DataIn;
input                                stateVld;
input  [STATE_DWIDTH - 1:0]          stateAIn;
input  [STATE_DWIDTH - 1:0]          stateBIn;
input  [STATE_DWIDTH - 1:0]          stateCIn;
input  [STATE_DWIDTH - 1:0]          stateDIn;
input  [STATE_DWIDTH - 1:0]          StateAComb;
input  [STATE_DWIDTH - 1:0]          StateBComb;
input  [STATE_DWIDTH - 1:0]          StateCComb;
input  [STATE_DWIDTH - 1:0]          StateDComb;
input  [STATE_DWIDTH - 1:0]          StateEComb;


output  [STATE_DWIDTH - 1:0]          StateAReg;
output  [STATE_DWIDTH - 1:0]          StateBReg;
output  [STATE_DWIDTH - 1:0]          StateCReg;
output  [STATE_DWIDTH - 1:0]          StateDReg;
output  [STATE_DWIDTH - 1:0]          A_Reg;
output  [STATE_DWIDTH - 1:0]          B_Reg;
output  [STATE_DWIDTH - 1:0]          C_Reg;
output  [STATE_DWIDTH - 1:0]          D_Reg;
output  [BLOCK_SIZE-1:0]              BlockOut;

reg  [STATE_DWIDTH - 1:0]          StateAReg;
reg  [STATE_DWIDTH - 1:0]          StateBReg;
reg  [STATE_DWIDTH - 1:0]          StateCReg;
reg  [STATE_DWIDTH - 1:0]          StateDReg;
reg  [STATE_DWIDTH - 1:0]          A_Reg;
reg  [STATE_DWIDTH - 1:0]          B_Reg;
reg  [STATE_DWIDTH - 1:0]          C_Reg;
reg  [STATE_DWIDTH - 1:0]          D_Reg;
reg  [DATA_WIDTH - 1:0]            WtData [15:0];

assign BlockOut = {WtData[15], WtData[14], WtData[13], WtData[12],
              WtData[11], WtData[10], WtData[9],  WtData[8],
         WtData[7],  WtData[6],  WtData[5],  WtData[4],
         WtData[3],  WtData[2],  WtData[1],  WtData[0]};


always @(posedge clk)
  begin
   if (DataVld) begin
     WtData[0] <= DataIn;
     WtData[1] <= WtData[0];
     WtData[2] <= WtData[1];
     WtData[3] <= WtData[2];
     WtData[4] <= WtData[3];
     WtData[5] <= WtData[4];
     WtData[6] <= WtData[5];
     WtData[7] <= WtData[6];
     WtData[8] <= WtData[7];
     WtData[9] <= WtData[8];
     WtData[10] <= WtData[9];
     WtData[11] <= WtData[10];
     WtData[12] <= WtData[11];
     WtData[13] <= WtData[12];
     WtData[14] <= WtData[13];
     WtData[15] <= WtData[14];
   end
  end
   
always @(posedge clk or  negedge rst_n)
  begin
    if (!rst_n) begin
      StateAReg <= 32'b0;      
      StateBReg <= 32'b0;      
      StateCReg <= 32'b0;      
      StateDReg <= 32'b0;      
    end
    else begin
      if (stateVld) begin
        StateAReg <= stateAIn;       
        StateBReg <= stateBIn;       
        StateCReg <= stateCIn;       
        StateDReg <= stateDIn;       
      end
      else begin
        StateAReg <= StateAComb;     
        StateBReg <= StateBComb;     
        StateCReg <= StateCComb;     
        StateDReg <= StateDComb;     
      end
    end
  end

always @(posedge clk or  negedge rst_n)
  begin
    if (!rst_n) begin
      A_Reg <= 32'b0;       
      B_Reg <= 32'b0;       
      C_Reg <= 32'b0;       
      D_Reg <= 32'b0;       
    end
    else begin
      if (stateVld) begin
        A_Reg <= stateAIn;     
        B_Reg <= stateBIn;     
        C_Reg <= stateCIn;     
        D_Reg <= stateDIn;     
      end
    end
  end
endmodule
