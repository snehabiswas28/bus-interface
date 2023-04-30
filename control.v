module control(clk,rst,rd,A_eq_Faddr,Den);
parameter waitmyadd=1'b0,send=1'b1;
input clk,rst,rd;
input A_eq_Faddr;
output reg Den;
reg ps,ns;

always @(posedge clk)
begin 
if(rst)
begin 
ps<=waitmyadd;
end
else 
begin 
ps<=ns;
end
end

always @(ps or rd or A_eq_Faddr)
begin
case(ps)
waitmyadd: 
begin
if(rd && A_eq_Faddr)
ns=send;
else
ns=ps;
end
send: 
begin
if(!rd)
ns=waitmyadd;
else
ns=ps;
end
default:
begin
ns=waitmyadd;
end
endcase
end

always @(ps)
begin
case(ps)
waitmyadd: Den=0;
send:Den=1;
default: Den=0;
endcase
end
endmodule