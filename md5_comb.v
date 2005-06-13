/********************************************************************************
* Module Name : md5_comb
* Description : MD5 computation combologic
* 
*
* *******************************************************************************/

module md5_comb (
         
                 //Inputs
                 RoundNum,
                 StateAReg,
                 StateBReg,
                 StateCReg,
                 StateDReg,
                 DataVld,
                 DataIn,
                 BlockIn,
                 AddRes1,
                 AddRes2,

                //Outputs
                 Md5FuncValue,
                 TValue,
                 XValue,
                 StateAComb,
                 StateBComb,
                 StateCComb,
                 StateDComb,
                 AddendState1,
                 AddendState2,
                 ShiftedAddend
                 
                );

`include "ah_params.vh"
`include "md5_params.vh"
`include "md5_func.vh"
input [5:0]                         RoundNum;
input [STATE_DWIDTH - 1:0]          StateAReg;
input [STATE_DWIDTH - 1:0]          StateBReg;
input [STATE_DWIDTH - 1:0]          StateCReg;
input [STATE_DWIDTH - 1:0]          StateDReg;
input [BLOCK_SIZE  - 1:0]           BlockIn;
input [DATA_WIDTH  - 1:0]           DataIn;
input                               DataVld;
input [STATE_DWIDTH - 1:0]          AddRes1;
input [STATE_DWIDTH - 1:0]          AddRes2;

output [STATE_DWIDTH - 1:0]         Md5FuncValue;
output [STATE_DWIDTH - 1:0]         TValue;
output [STATE_DWIDTH - 1:0]         XValue;
output [STATE_DWIDTH - 1:0]         StateAComb;
output [STATE_DWIDTH - 1:0]         StateBComb;
output [STATE_DWIDTH - 1:0]         StateCComb;
output [STATE_DWIDTH - 1:0]         StateDComb;
output [STATE_DWIDTH - 1:0]         AddendState1;
output [STATE_DWIDTH - 1:0]         AddendState2;
output [STATE_DWIDTH - 1:0]         ShiftedAddend;

reg [STATE_DWIDTH - 1:0]            Md5FuncValue;
reg [STATE_DWIDTH - 1:0]            TValue;
reg [STATE_DWIDTH - 1:0]            XValue;
reg [STATE_DWIDTH - 1:0]            StateAComb;
reg [STATE_DWIDTH - 1:0]            StateBComb;
reg [STATE_DWIDTH - 1:0]            StateCComb;
reg [STATE_DWIDTH - 1:0]            StateDComb;
reg [STATE_DWIDTH - 1:0]            AddendState1;
reg [STATE_DWIDTH - 1:0]            AddendState2;
reg [STATE_DWIDTH - 1:0]            ShiftedAddend;

always @(RoundNum or StateAReg or StateBReg or StateCReg or 
         StateDReg or BlockIn or DataVld)
    begin
       Md5FuncValue = 0;
       XValue = 0;
       TValue = 0;
       if (DataVld) begin
         case(RoundNum)
            0 : begin
              Md5FuncValue = F(StateBReg, StateCReg, StateDReg);
              XValue = byte_flip(DataIn);
              TValue = T01;
            end 
            1 : begin
              Md5FuncValue = F(StateAReg, StateBReg, StateCReg);
              XValue = byte_flip(DataIn);
              TValue = T02;
            end 
            2 : begin
              Md5FuncValue = F(StateDReg, StateAReg, StateBReg);
              XValue = byte_flip(DataIn);
              TValue = T03;
            end 
            3 : begin
              Md5FuncValue = F(StateCReg, StateDReg, StateAReg);
              XValue = byte_flip(DataIn);
              TValue = T04;
            end 
            4 : begin
              Md5FuncValue = F(StateBReg, StateCReg, StateDReg);
              XValue = byte_flip(DataIn);
              TValue = T05;
            end 
            5 : begin
              Md5FuncValue = F(StateAReg, StateBReg, StateCReg);
              XValue = byte_flip(DataIn);
              TValue = T06;
            end 
            6 : begin
              Md5FuncValue = F(StateDReg, StateAReg, StateBReg);
              XValue = byte_flip(DataIn);
              TValue = T07;
            end 
            7 : begin
              Md5FuncValue = F(StateCReg, StateDReg, StateAReg);
              XValue = byte_flip(DataIn);
              TValue = T08;
            end 
            8 : begin
              Md5FuncValue = F(StateBReg, StateCReg, StateDReg);
              XValue = byte_flip(DataIn);
              TValue = T09;
            end 
            9 : begin
              Md5FuncValue = F(StateAReg, StateBReg, StateCReg);
              XValue = byte_flip(DataIn);
              TValue = T10;
            end 
            10 : begin
              Md5FuncValue = F(StateDReg, StateAReg, StateBReg);
              XValue = byte_flip(DataIn);
              TValue = T11;
            end 
            11 : begin
              Md5FuncValue = F(StateCReg, StateDReg, StateAReg);
              XValue = byte_flip(DataIn);
              TValue = T12;
            end 
            12 : begin
              Md5FuncValue = F(StateBReg, StateCReg, StateDReg);
              XValue = byte_flip(DataIn);
              TValue = T13;
            end 
            13 : begin
              Md5FuncValue = F(StateAReg, StateBReg, StateCReg);
              XValue = byte_flip(DataIn);
              TValue = T14;
            end 
            14 : begin
              Md5FuncValue = F(StateDReg, StateAReg, StateBReg);
              XValue = byte_flip(DataIn);
              TValue = T15;
            end 
            15 : begin
              Md5FuncValue = F(StateCReg, StateDReg, StateAReg);
              XValue = byte_flip(DataIn);
              TValue = T16;
            end 
            16 : begin
              Md5FuncValue = G(StateBReg, StateCReg, StateDReg);
              XValue = FX(BlockIn, 1);
              TValue = T17;
            end 
            17 : begin
              Md5FuncValue = G(StateAReg, StateBReg, StateCReg);
              XValue = FX(BlockIn, 6);
              TValue = T18;
            end 
            18 : begin
              Md5FuncValue = G(StateDReg, StateAReg, StateBReg);
              XValue = FX(BlockIn, 11);
              TValue = T19;
            end 
            19 : begin
              Md5FuncValue = G(StateCReg, StateDReg, StateAReg);
              XValue = FX(BlockIn, 0);
              TValue = T20;
            end 
            20 : begin
              Md5FuncValue = G(StateBReg, StateCReg, StateDReg);
              XValue = FX(BlockIn, 5);
              TValue = T21;
            end 
            21 : begin
              Md5FuncValue = G(StateAReg, StateBReg, StateCReg);
              XValue = FX(BlockIn, 10);
              TValue = T22;
            end 
            22 : begin
              Md5FuncValue = G(StateDReg, StateAReg, StateBReg);
              XValue = FX(BlockIn, 15);
              TValue = T23;
            end 
            23 : begin
              Md5FuncValue = G(StateCReg, StateDReg, StateAReg);
              XValue = FX(BlockIn, 4);
              TValue = T24;
            end 
            24 : begin
              Md5FuncValue = G(StateBReg, StateCReg, StateDReg);
              XValue = FX(BlockIn, 9);
              TValue = T25;
            end 
            25 : begin
              Md5FuncValue = G(StateAReg, StateBReg, StateCReg);
              XValue = FX(BlockIn, 14);
              TValue = T26;
            end 
            26 : begin
              Md5FuncValue = G(StateDReg, StateAReg, StateBReg);
              XValue = FX(BlockIn, 3);
              TValue = T27;
            end 
            27 : begin
              Md5FuncValue = G(StateCReg, StateDReg, StateAReg);
              XValue = FX(BlockIn, 8);
              TValue = T28;
            end 
            28 : begin
              Md5FuncValue = G(StateBReg, StateCReg, StateDReg);
              XValue = FX(BlockIn, 13);
              TValue = T29;
            end 
            29 : begin
              Md5FuncValue = G(StateAReg, StateBReg, StateCReg);
              XValue = FX(BlockIn, 2);
              TValue = T30;
            end 
            30 : begin
              Md5FuncValue = G(StateDReg, StateAReg, StateBReg);
              XValue = FX(BlockIn, 7);
              TValue = T31;
            end 
            31 : begin
              Md5FuncValue = G(StateCReg, StateDReg, StateAReg);
              XValue = FX(BlockIn, 12);
              TValue = T32;
            end 
            32 : begin
              Md5FuncValue = H(StateBReg, StateCReg, StateDReg);
              XValue = FX(BlockIn, 5);
              TValue = T33;
            end 
            33 : begin
              Md5FuncValue = H(StateAReg, StateBReg, StateCReg);
              XValue = FX(BlockIn, 8);
              TValue = T34;
            end 
            34 : begin
              Md5FuncValue = H(StateDReg, StateAReg, StateBReg);
              XValue = FX(BlockIn, 11);
              TValue = T35;
            end 
            35 : begin
              Md5FuncValue = H(StateCReg, StateDReg, StateAReg);
              XValue = FX(BlockIn, 14);
              TValue = T36;
            end 
            36 : begin
              Md5FuncValue = H(StateBReg, StateCReg, StateDReg);
              XValue = FX(BlockIn, 1);
              TValue = T37;
            end 
            37 : begin
              Md5FuncValue = H(StateAReg, StateBReg, StateCReg);
              XValue = FX(BlockIn, 4);
              TValue = T38;
            end 
            38 : begin
              Md5FuncValue = H(StateDReg, StateAReg, StateBReg);
              XValue = FX(BlockIn, 7);
              TValue = T39;
            end 
            39 : begin
              Md5FuncValue = H(StateCReg, StateDReg, StateAReg);
              XValue = FX(BlockIn, 10);
              TValue = T40;
            end 
            40 : begin
              Md5FuncValue = H(StateBReg, StateCReg, StateDReg);
              XValue = FX(BlockIn, 13);
              TValue = T41;
            end 
            41 : begin
              Md5FuncValue = H(StateAReg, StateBReg, StateCReg);
              XValue = FX(BlockIn, 0);
              TValue = T42;
            end 
            42 : begin
              Md5FuncValue = H(StateDReg, StateAReg, StateBReg);
              XValue = FX(BlockIn, 3);
              TValue = T43;
            end 
            43 : begin
              Md5FuncValue = H(StateCReg, StateDReg, StateAReg);
              XValue = FX(BlockIn, 6);
              TValue = T44;
            end 
            44 : begin
              Md5FuncValue = H(StateBReg, StateCReg, StateDReg);
              XValue = FX(BlockIn, 9);
              TValue = T45;
            end 
            45 : begin
              Md5FuncValue = H(StateAReg, StateBReg, StateCReg);
              XValue = FX(BlockIn, 12);
              TValue = T46;
            end 
            46 : begin
              Md5FuncValue = H(StateDReg, StateAReg, StateBReg);
              XValue = FX(BlockIn, 15);
              TValue = T47;
            end 
            47 : begin
              Md5FuncValue = H(StateCReg, StateDReg, StateAReg);
              XValue = FX(BlockIn, 2);
              TValue = T48;
            end 
            48 : begin
              Md5FuncValue = I(StateBReg, StateCReg, StateDReg);
              XValue = FX(BlockIn, 0);
              TValue = T49;
            end 
            49 : begin
              Md5FuncValue = I(StateAReg, StateBReg, StateCReg);
              XValue = FX(BlockIn, 7);
              TValue = T50;
            end 
            50 : begin
              Md5FuncValue = I(StateDReg, StateAReg, StateBReg);
              XValue = FX(BlockIn, 14);
              TValue = T51;
            end 
            51 : begin
              Md5FuncValue = I(StateCReg, StateDReg, StateAReg);
              XValue = FX(BlockIn, 5);
              TValue = T52;
            end 
            52 : begin
              Md5FuncValue = I(StateBReg, StateCReg, StateDReg);
              XValue = FX(BlockIn, 12);
              TValue = T53;
            end 
            53 : begin
              Md5FuncValue = I(StateAReg, StateBReg, StateCReg);
              XValue = FX(BlockIn, 3);
              TValue = T54;
            end 
            54 : begin
              Md5FuncValue = I(StateDReg, StateAReg, StateBReg);
              XValue = FX(BlockIn, 10);
              TValue = T55;
            end 
            55 : begin
              Md5FuncValue = I(StateCReg, StateDReg, StateAReg);
              XValue = FX(BlockIn, 1);
              TValue = T56;
            end 
            56 : begin
              Md5FuncValue = I(StateBReg, StateCReg, StateDReg);
              XValue = FX(BlockIn, 8);
              TValue = T57;
            end 
            57 : begin
              Md5FuncValue = I(StateAReg, StateBReg, StateCReg);
              XValue = FX(BlockIn, 15);
              TValue = T58;
            end 
            58 : begin
              Md5FuncValue = I(StateDReg, StateAReg, StateBReg);
              XValue = FX(BlockIn, 6);
              TValue = T59;
            end 
            59 : begin
              Md5FuncValue = I(StateCReg, StateDReg, StateAReg);
              XValue = FX(BlockIn, 13);
              TValue = T60;
            end 
            60 : begin
              Md5FuncValue = I(StateBReg, StateCReg, StateDReg);
              XValue = FX(BlockIn, 4);
              TValue = T61;
            end 
            61 : begin
              Md5FuncValue = I(StateAReg, StateBReg, StateCReg);
              XValue = FX(BlockIn, 11);
              TValue = T62;
            end 
            62 : begin
              Md5FuncValue = I(StateDReg, StateAReg, StateBReg);
              XValue = FX(BlockIn, 2);
              TValue = T63;
            end 
            63 : begin
              Md5FuncValue = I(StateCReg, StateDReg, StateAReg);
              XValue = FX(BlockIn, 9);
              TValue = T64;
            end 
            default: begin
              Md5FuncValue = 0;
              XValue = 0;
              TValue = 0;
            end
         endcase
       end 
       else begin
         Md5FuncValue = 0;
         XValue = 0;
         TValue = 0;
       end
    end

always @(AddRes1 or AddRes2 or StateAReg or
         StateBReg or StateCReg or StateDReg or
         RoundNum or DataVld)
    begin
      AddendState1 = 0;
      AddendState2 = 0;
      StateAComb = StateAReg;
      StateBComb = StateBReg;
      StateCComb = StateCReg;
      StateDComb = StateDReg;
      ShiftedAddend =  0;
      if (DataVld) begin
        casex(RoundNum) 
          6'b00XX00 : begin
             AddendState1 = StateAReg;
             AddendState2 = StateBReg;
             ShiftedAddend =  ROTATE_LEFT(AddRes1, S11);
             $display();
             StateAComb = AddRes2;
          end
          6'b00XX01 : begin
             AddendState1 = StateDReg;
             AddendState2 = StateAReg;
             ShiftedAddend =  ROTATE_LEFT(AddRes1, S12);
             $display();
             StateDComb = AddRes2;
          end
          6'b00XX10 : begin
             AddendState1 = StateCReg;
             AddendState2 = StateDReg;
             ShiftedAddend =  ROTATE_LEFT(AddRes1, S13);
             $display();
             StateCComb = AddRes2;
          end
          6'b00XX11 : begin
             AddendState1 = StateBReg;
             AddendState2 = StateCReg;
             ShiftedAddend =  ROTATE_LEFT(AddRes1, S14);
             $display();
             StateBComb = AddRes2;
          end
          6'b01XX00 : begin
             AddendState1 = StateAReg;
             AddendState2 = StateBReg;
             ShiftedAddend =  ROTATE_LEFT(AddRes1, S21);
             $display();
             StateAComb = AddRes2;
          end
          6'b01XX01 : begin
             AddendState1 = StateDReg;
             AddendState2 = StateAReg;
             ShiftedAddend =  ROTATE_LEFT(AddRes1, S22);
             $display();
             StateDComb = AddRes2;
          end
          6'b01XX10 : begin
             AddendState1 = StateCReg;
             AddendState2 = StateDReg;
             ShiftedAddend =  ROTATE_LEFT(AddRes1, S23);
             $display();
             StateCComb = AddRes2;
          end
          6'b01XX11 : begin
             AddendState1 = StateBReg;
             AddendState2 = StateCReg;
             ShiftedAddend =  ROTATE_LEFT(AddRes1, S24);
             $display();
             StateBComb = AddRes2;
          end
          6'b10XX00 : begin
             AddendState1 = StateAReg;
             AddendState2 = StateBReg;
             ShiftedAddend =  ROTATE_LEFT(AddRes1, S31);
             $display();
             StateAComb = AddRes2;
          end
          6'b10XX01 : begin
             AddendState1 = StateDReg;
             AddendState2 = StateAReg;
             ShiftedAddend =  ROTATE_LEFT(AddRes1, S32);
             $display();
             StateDComb = AddRes2;
          end
          6'b10XX10 : begin
             AddendState1 = StateCReg;
             AddendState2 = StateDReg;
             ShiftedAddend =  ROTATE_LEFT(AddRes1, S33);
             $display();
             StateCComb = AddRes2;
             end
          6'b10XX11 : begin
             AddendState1 = StateBReg;
             AddendState2 = StateCReg;
             ShiftedAddend =  ROTATE_LEFT(AddRes1, S34);
             $display();
             StateBComb = AddRes2;
          end
          6'b11XX00 : begin
             AddendState1 = StateAReg;
             AddendState2 = StateBReg;
             ShiftedAddend =  ROTATE_LEFT(AddRes1, S41);
             $display();
             StateAComb = AddRes2;
          end
          6'b11XX01 : begin
             AddendState1 = StateDReg;
             AddendState2 = StateAReg;
             ShiftedAddend =  ROTATE_LEFT(AddRes1, S42);
             $display();
             StateDComb = AddRes2;
          end
          6'b11XX10 : begin
             AddendState1 = StateCReg;
             AddendState2 = StateDReg;
             ShiftedAddend =  ROTATE_LEFT(AddRes1, S43);
             $display();
             StateCComb = AddRes2;
          end
          6'b11XX11 : begin
             AddendState1 = StateBReg;
             AddendState2 = StateCReg;
             ShiftedAddend =  ROTATE_LEFT(AddRes1, S44);
             $display();
             StateBComb = AddRes2;
          end
          default : begin
             AddendState1 = 0;
             AddendState2 = 0;
             ShiftedAddend = 0;
             StateAComb = StateAReg;
             StateBComb = StateBReg;
             StateCComb = StateCReg;
             StateDComb = StateDReg;
          end 
        endcase
      end
    end
endmodule
