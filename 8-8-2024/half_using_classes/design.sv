// Code your design here
module half(a,b,sum,carry);
  input a;
  input b;
  output sum;
  output carry;
  
  assign sum=a^b;
  assign carry=a&b;
  
endmodule

interface inter;
  logic a;
  logic b;
  logic sum;
  logic carry;
endinterface