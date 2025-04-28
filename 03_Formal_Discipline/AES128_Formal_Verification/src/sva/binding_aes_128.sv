module binding_module();
	bind aes_128 assertions_aes_128 binding_aes_128(clk, state, key, out);
endmodule