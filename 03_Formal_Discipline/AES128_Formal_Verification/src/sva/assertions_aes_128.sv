module assertions_aes_128

(
input logic clk,
input logic [127:0] state,
input logic [127:0] key,
input logic [127:0] out
);




// property-1 : High level assertion property-- Output should change whenever there is a change in input key.

property output_change_for_key_change;
@(posedge clk) (key != $past(key) && $changed(out)) |-> (out != $past(out));
endproperty

assert property(output_change_for_key_change) else $error("property-1 failed: for a change in input key, the output value is not changing");



// property-2 :High level assertion property-- Output should change whenever there is a change in input data(state).

property output_change_for_state_change;
@(posedge clk) (state != $past(state) && $changed(out)) |-> (out != $past(out));
endproperty

assert property(output_change_for_state_change) else $error("property-2 failed: for a change in input state, the output value is not changing");

//property-3 : Initial value assertions-- The input state for round 1 is same as XOR of key and state with a clock cycle delay
property input_for_round1;
  @(posedge clk) state^key |-> (##1 aes_128.s0);
endproperty

assert property(input_for_round1) else $error("property-3 failed : input state for first one_round is incorrect");


// property-4 : Initial value assertions-- k0 value should be same as key with a clock cycle delay
property expand_key_input;
  @(posedge clk) key |-> (##1 aes_128.k0) ;
endproperty

assert property(expand_key_input) else $error("property-4 failed: input key for first expand_key_128 is incorrect ");


//property-5 : Module Assertions-"final_round" module assertion property

property final_round_output_for_key_change;
@(posedge clk) (aes_128.rf.key_in != $past(aes_128.rf.key_in) && $changed(aes_128.rf.state_out) ) |-> (aes_128.rf.state_out != $past(aes_128.rf.state_out));
endproperty 


assert property(final_round_output_for_key_change) else $error("property-5 failed: Final round output for key change");


//property-6 : Module Assertions-"one_round-3rd round" module assertion property

property one_round_third_key_change;
@(posedge clk) (aes_128.r3.key != $past(aes_128.r3.key) && $changed(aes_128.r3.state_out) ) |-> (aes_128.r3.state_out != $past(aes_128.r3.state_out));
endproperty

assert property(one_round_third_key_change) else $error("property-6 failed: for a change in input key for 1st_round, output is not changing");

// property-7 : Module Assertions-"expand_key_128" module assertion property

property verify_out1_expand1_key_2;
@(posedge clk)  ((aes_128.a2.k0a) ^(aes_128.a2.k4a)) |-> ##1 (aes_128.a2.out_1[127:96]);
endproperty

assert property(verify_out1_expand1_key_2) else $error("property-7 failed :one of signal of output 1 of the a2 is incorrect");



// property-8 : Module Assertions-"expand_key_128" module assertion property

property verify_out1_expand2_key_2;
@(posedge clk)  ((aes_128.a2.k1a) ^(aes_128.a2.k4a)) |-> ##1 (aes_128.a2.out_1[95:64]);
endproperty

assert property(verify_out1_expand2_key_2) else $error("property-8 failed :one of signal of output 1 of the a2 is incorrect");




// property-9 : Module Assertions-"expand_key_128" module assertion property

property verify_out1_expand3_key_2;
@(posedge clk)  ((aes_128.a2.k2a) ^(aes_128.a2.k4a)) |-> ##1 (aes_128.a2.out_1[63:32]);
endproperty

assert property(verify_out1_expand3_key_2 ) else $error("property-9 failed :one of signal of output 1 of the a2 is incorrect");


// property-10 : Module Assertions-"expand_key_128" module assertion property

property verify_out1_expand4_key_2;
@(posedge clk)  ((aes_128.a2.k3a) ^(aes_128.a2.k4a)) |-> ##1 (aes_128.a2.out_1[31:0]);
endproperty

assert property(verify_out1_expand4_key_2) else $error("property-10 failed :one of signal of output 1 of the a2 is incorrect");

// // property-11 : Module Assertions-One_round functionality checking

property one_round_functionality;
@(posedge clk) ((aes_128.r1.p20) ^ (aes_128.r1.p31) ^ (aes_128.r1.p02) ^ (aes_128.r1.p13) ^ (aes_128.r1.k2)) |-> ##1 (aes_128.r1.state_out[63:32]);
endproperty

assert property(one_round_functionality) else $error("property-11 failed :one of signal of output of the one_round is incorrect");

// property-12: "one_round-3rd round" module assertion property

property one_round_third_state_change;
@(posedge clk) (aes_128.r3.state_in != $past(aes_128.r3.state_in) && $changed(aes_128.r3.state_out) ) |-> (aes_128.r3.state_out != $past(aes_128.r3.state_out));
endproperty

assert property(one_round_third_state_change) else $error("property-12 failed: for a change in input state (aes_128.r2.state_in) for 2nd_round, output is not changing");

//Cover for the above properties:
cover property(output_change_for_key_change)  $display("cover property-1 passed");
cover property(output_change_for_state_change)  $display("cover property-2 passed");
cover property(input_for_round1)  $display("cover property-3 passed");
cover property(expand_key_input)  $display("cover property-4 passed");
cover property(final_round_output_for_key_change)  $display("cover property-5 passed");
cover property(one_round_third_key_change)  $display("cover property-6 passed");
cover property(verify_out1_expand1_key_2)  $display("cover property-7 passed");
cover property(verify_out1_expand2_key_2) $display("cover property-8 passed");
cover property(verify_out1_expand3_key_2) $display("cover property-9 passed");
cover property(verify_out1_expand4_key_2) $display("cover property-10 passed");
cover property(one_round_functionality) $display("cover property-11 passed");
cover property(one_round_third_state_change)  $display("cover property-12 passed");

endmodule 





