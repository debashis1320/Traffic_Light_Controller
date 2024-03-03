`include "traffic_controller_design.v"
module test_traffic_controller;

reg clk, rst, sb;
wire[1:0] a, b;

traffic_controller TS1 (clk , rst , sb , a , b);

initial clk = 1'b1;

always #5 clk = ~clk;

initial begin
    $dumpfile("traffic_controller.vcd");
    $dumpvars(0,test_traffic_controller);
end

initial begin
    rst = 1;
    #11 rst = 0;
end

initial begin
    #6 sb = 1; #66 sb = 0; #80 sb = 1; #144 sb = 0;
    #150 $finish;
end

initial begin
    $monitor($time, "a = %b, b = %b", a, b);
end

endmodule