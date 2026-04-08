module RegisterFile_tb;
reg clk,rst,WriteEnable;
reg [4:0] rs1,rs2,rd;
reg [31:0] WriteData;
wire [31:0] ReadData1,ReadData2;
RegisterFile uut(
.clk(clk),
.rst(rst),
.WriteEnable(WriteEnable),
.rs1(rs1),
.rs2(rs2),
.rd(rd),
.WriteData(WriteData),
.ReadData1(ReadData1),
.ReadData2(ReadData2)
);
always #5 clk=~clk;
initial begin
clk=0;
rst=1;
WriteEnable=0;
#10 rst=0;
//write to register 5
WriteEnable=1;
rd=5;
WriteData=32'hA5A5A5A5;
#10;
//read from register 5
WriteEnable=0;
rs1=5;
#10;
//try writing to x0
WriteEnable=1;
rd=0;
WriteData=32'hFFFFFFFF;
#10;
//read x0 (should be 0)
WriteEnable=0;
rs1=0;
#10;
//reading 5 again and then resetting and reading again to see if it works properly
WriteEnable=0;
rs1=5;
#10;
rst=1;
WriteEnable=0;
#10 rst=0;
WriteEnable=0;
rs1=5;
#10;
$finish;
end
endmodule
