/****************************************************************************
 Adders
****************************************************************************/

module adders (
              
               //Inputs 
               Addend0A,
               Addend0B,
               Addend1A,
               Addend1B,
               Addend2A,
               Addend3A,
               Addend3B,
               StateAReg,
               StateBReg,
               StateCReg,
               StateDReg,
               A_Reg,
               B_Reg,
               C_Reg,
               D_Reg,

          //Outputs
               ResStateAReg,
               ResStateBReg,
               ResStateCReg,
               ResStateDReg,
               AddResFinal1,
               AddResFinal2,
               AddResFinal3
               );

`include "ah_params.vh"

input  [STATE_DWIDTH - 1:0]           Addend0A;
input  [STATE_DWIDTH - 1:0]           Addend0B;
input  [STATE_DWIDTH - 1:0]           Addend1A;
input  [STATE_DWIDTH - 1:0]           Addend1B;
input  [STATE_DWIDTH - 1:0]           Addend2A;
input  [STATE_DWIDTH - 1:0]           Addend3A;
input  [STATE_DWIDTH - 1:0]           Addend3B;
input  [STATE_DWIDTH - 1:0]           StateAReg;
input  [STATE_DWIDTH - 1:0]           StateBReg;
input  [STATE_DWIDTH - 1:0]           StateCReg;
input  [STATE_DWIDTH - 1:0]           StateDReg;
input  [STATE_DWIDTH - 1:0]           A_Reg;
input  [STATE_DWIDTH - 1:0]           B_Reg;
input  [STATE_DWIDTH - 1:0]           C_Reg;
input  [STATE_DWIDTH - 1:0]           D_Reg;

output [STATE_DWIDTH - 1:0]           ResStateAReg;
output [STATE_DWIDTH - 1:0]           ResStateBReg;
output [STATE_DWIDTH - 1:0]           ResStateCReg;
output [STATE_DWIDTH - 1:0]           ResStateDReg;
output [STATE_DWIDTH - 1:0]           AddResFinal1;
output [STATE_DWIDTH - 1:0]           AddResFinal2;
output [STATE_DWIDTH - 1:0]           AddResFinal3;

wire [STATE_DWIDTH - 1:0]       AddResFinal1;
wire [STATE_DWIDTH - 1:0]       AddResFinal2;
wire [STATE_DWIDTH - 1:0]       AddResFinal3;
wire [STATE_DWIDTH - 1:0]       AddRes0;
wire [STATE_DWIDTH - 1:0]       AddRes1;
wire [STATE_DWIDTH - 1:0]       AddRes2;
wire [STATE_DWIDTH - 1:0]       AddRes3;
wire [STATE_DWIDTH - 1:0]       AddRes4;
wire [STATE_DWIDTH - 1:0]       ResStateAReg;
wire [STATE_DWIDTH - 1:0]       ResStateBReg;
wire [STATE_DWIDTH - 1:0]       ResStateCReg;
wire [STATE_DWIDTH - 1:0]       ResStateDReg;

assign AddResFinal1 = AddRes2;
assign AddResFinal2 = AddRes3;
assign AddResFinal3 = AddRes4;

add32 u_adder_0 (
    .In0(Addend0A),
    .In1(Addend0B),
    .Out(AddRes0)
 );

add32 u_adder_1 (
    .In0(Addend1A),
    .In1(Addend1B),
    .Out(AddRes1)
 );

add32 u_adder_2 (
    .In0(AddRes1),
    .In1(AddRes0),
    .Out(AddRes2)
 );

add32 u_adder_3 (
    .In0(Addend2A),
    .In1(AddRes2),
    .Out(AddRes3)
 );

add32 u_adder_9 (
    .In0(Addend3A),
    .In1(Addend3B),
    .Out(AddRes4)
 );

add32 u_adder_4 (
    .In0(StateAReg),
    .In1(A_Reg),
    .Out(ResStateAReg)
 );

add32 u_adder_5 (
    .In0(StateBReg),
    .In1(B_Reg),
    .Out(ResStateBReg)
 );

add32 u_adder_6 (
    .In0(StateCReg),
    .In1(C_Reg),
    .Out(ResStateCReg)
 );

add32 u_adder_7 (
    .In0(StateDReg),
    .In1(D_Reg),
    .Out(ResStateDReg)
 );

endmodule
