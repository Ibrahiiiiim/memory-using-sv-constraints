class mem_block;
	bit [31:0] mem_ram_start,mem_ram_end;
	rand bit [31:0] mem_start_addr,mem_end_addr;
	rand int mem_block_size;

	constraint mem {
		mem_start_addr>=mem_ram_start;
		mem_start_addr<mem_ram_end;
		mem_start_addr%4==0;
		mem_end_addr == mem_start_addr + mem_block_size -1;
	}

	constraint block_size {
		mem_block_size inside {32,64};
	}

	function void display();
		$display("\t----memory block----");
	    $display("\t RAM start addr : %0d", mem_ram_start);
	    $display("\t RAM end addr : %0d", mem_ram_end);
	    $display("\t BLOCK start addr : %0d", mem_start_addr);
	    $display("\t BLOCK end addr : %0d", mem_end_addr);
	    $display("\t BLOCK SIZE:%0d", mem_block_size);
	endfunction : display
	
endclass : mem_block

module single_memory_block ();
	mem_block mem=new();
	initial begin
		mem.mem_ram_start=32'h0;
		mem.mem_ram_end=32'h7ff;
		void'(mem.randomize());
		mem.display();
	end
endmodule : single_memory_block