module traffic_controller (
    clk, rst, sb, a, b
);
    input clk, rst, sb;
    output reg[1:0] a, b;
    reg[1:0] current_state, next_state;
    reg[9:0] ctr=0;
    parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3;

    always @(posedge clk ) begin
        if(rst == 1)
        begin
            ctr = 0;
            current_state = S0;
        end
        else
        current_state = next_state;
        
        case (current_state)
            S0:begin
                a = 2; b = 0;
                if (sb == 1 & ctr < 4) begin
                    next_state = S0;
                    ctr = ctr + 1;
                end else if(sb == 1 & ctr >= 4)begin
                    next_state = S1;
                end else 
                    next_state = S0;
            end 
            S1:begin
                a = 1; b = 0;
                if (sb == 1 & ctr < 6) begin
                    next_state = S1;
                    ctr = ctr + 1;
                end else if(sb == 0)begin
                    next_state = S0;
                    ctr = 0;
                end else if(sb == 1 & ctr >= 6)begin
                    next_state = S2;
                end 
            end
            S2:begin
                a = 0; b = 2;
                ctr = ctr + 1;
                if (ctr == 8) begin
                    next_state = S3;
                end 
            end
            S3:begin
                a = 0; b = 1;
                ctr = ctr + 1;
                if (ctr == 10) begin
                    next_state = S0;
                    ctr = 0;
                end 
            end
            default:begin
                ctr = 0;
                next_state = S0;
            end 
        endcase
    end
endmodule