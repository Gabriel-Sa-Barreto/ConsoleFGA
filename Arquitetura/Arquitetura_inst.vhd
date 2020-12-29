	component Arquitetura is
		port (
			clk_clk          : in  std_logic                     := 'X';             -- clk
			data_a_export    : out std_logic_vector(31 downto 0);                    -- export
			data_b_export    : out std_logic_vector(31 downto 0);                    -- export
			printting_export : in  std_logic                     := 'X';             -- export
			reset_reset_n    : in  std_logic                     := 'X';             -- reset_n
			switch_export    : in  std_logic_vector(2 downto 0)  := (others => 'X')  -- export
		);
	end component Arquitetura;

	u0 : component Arquitetura
		port map (
			clk_clk          => CONNECTED_TO_clk_clk,          --       clk.clk
			data_a_export    => CONNECTED_TO_data_a_export,    --    data_a.export
			data_b_export    => CONNECTED_TO_data_b_export,    --    data_b.export
			printting_export => CONNECTED_TO_printting_export, -- printting.export
			reset_reset_n    => CONNECTED_TO_reset_reset_n,    --     reset.reset_n
			switch_export    => CONNECTED_TO_switch_export     --    switch.export
		);

