// Code your testbench here
// or browse Examples
class generator;
  int a=5;
  int b=5;
  mailbox mbx;
  task run();
    mbx.put({a[2:0],b[2:0]});
    $display("Generator Test Cases a=%0d,b=%0d",a,b);
  endtask
endclass

class driver;
  mailbox mbx;
  virtual inter vif;
  task run();
    bit [5:0]temp;
    bit [2:0]a,b;
    
    mbx.get(temp);
    a=temp[5:3];
    b=temp[2:0];
//     temp[5:3]=a;
//     temp[2:0]=b;
    vif.a=a;
    vif.b=b;
    #10;
    $display("Driver applied : a=%0d b=%0d and Dut output c=%0d",a,b,vif.c);
  endtask
endclass

module tb;
  inter aif();
  add dut(.a(aif.a),.b(aif.b),.c(aif.c));
  generator gen;
  driver div;
  mailbox mbx;
  initial
    begin
      gen=new();
      div=new();
      mbx=new();
      
      gen.mbx=mbx;
      div.mbx=mbx;
      div.vif=aif;
      
      fork
        gen.run();
        div.run();
      join
    end
endmodule