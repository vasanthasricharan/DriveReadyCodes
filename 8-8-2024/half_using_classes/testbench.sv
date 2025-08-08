// Code your testbench here
// or browse Examples
class generator;
  bit a,b;
  mailbox mbx;
  task run();
    for (int i=0;i<2;i++) begin
      for (int j=0;j<2;j++) begin
        a=i;
        b=j;
        mbx.put({a,b});
        $display("Generated a=%0d b=%0d", a, b);
      end
    end
  endtask
endclass

class driver;
  virtual inter vif;
  mailbox mbx;
  task run();
    bit [1:0] temp;
    bit a,b;
    forever begin
    mbx.get(temp);
    a=temp[1];
    b=temp[0];
    vif.a = a;
    vif.b = b;
    #10;
    $display("Driving a=%0d b=%0d and output sum=%0d carry=%0d",a,b,vif.sum,vif.carry);
    end
  endtask
endclass

module tb;
  inter hif();
  half dut(.a(hif.a),.b(hif.b),.sum(hif.sum),.carry(hif.carry));
  
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
      div.vif=hif;
      
      fork
        gen.run();
        div.run();
      join
    end
endmodule