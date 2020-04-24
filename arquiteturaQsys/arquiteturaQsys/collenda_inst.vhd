	component collenda is
		port (
			check_printting_export         : in  std_logic                    := 'X'; -- export
			clk_clk                        : in  std_logic                    := 'X'; -- clk
			reset_reset_n                  : in  std_logic                    := 'X'; -- reset_n
			color_g_readdata               : out std_logic_vector(2 downto 0);        -- readdata
			color_b_readdata               : out std_logic_vector(2 downto 0);        -- readdata
			color_r_readdata               : out std_logic_vector(2 downto 0);        -- readdata
			vsync_writeresponsevalid_n     : out std_logic;                           -- writeresponsevalid_n
			hsync_writeresponsevalid_n     : out std_logic;                           -- writeresponsevalid_n
			printting_writeresponsevalid_n : out std_logic                            -- writeresponsevalid_n
		);
	end component collenda;

	u0 : component collenda
		port map (
			check_printting_export         => CONNECTED_TO_check_printting_export,         -- check_printting.export
			clk_clk                        => CONNECTED_TO_clk_clk,                        --             clk.clk
			reset_reset_n                  => CONNECTED_TO_reset_reset_n,                  --           reset.reset_n
			color_g_readdata               => CONNECTED_TO_color_g_readdata,               --         color_g.readdata
			color_b_readdata               => CONNECTED_TO_color_b_readdata,               --         color_b.readdata
			color_r_readdata               => CONNECTED_TO_color_r_readdata,               --         color_r.readdata
			vsync_writeresponsevalid_n     => CONNECTED_TO_vsync_writeresponsevalid_n,     --           vsync.writeresponsevalid_n
			hsync_writeresponsevalid_n     => CONNECTED_TO_hsync_writeresponsevalid_n,     --           hsync.writeresponsevalid_n
			printting_writeresponsevalid_n => CONNECTED_TO_printting_writeresponsevalid_n  --       printting.writeresponsevalid_n
		);

