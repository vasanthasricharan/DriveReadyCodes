// Code your design here
//Adding the two num using generator class,driver class and interface in sv
module add(a,b,c);
  input [2:0]a,b;
  output [3:0]c;
  
  assign c=a+b;
endmodule

interface inter;
  logic [2:0]a;
  logic [2:0]b;
  logic [3:0]c;

endinterface
