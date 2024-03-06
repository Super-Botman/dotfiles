return {
	setup = function()
		require("tokyonight").setup({
		  style = "moon", 
		  transparent = true, -- Enable this to disable setting the background color
		  terminal_colors = true, -- used when opening a `:terminal`		 
		  styles = {
		    -- Style to be applied to different syntax groups
		    -- Value is any valid attr-list value for `:help nvim_set_hl`
		    comments = { italic = true },
		    keywords = { italic = true },
		    functions = {},
		    variables = {},
		    -- Background styles. Can be "dark", "transparent" or "normal"
		    sidebars = "dark", -- style for sidebars, see below
		    floats = "dark", -- style for floating windows
		  },
		  sidebars = { "qf", "help" }, -- darker background on sidebar-like windows. 
		  hide_inactive_statusline = false, -- hide inactive statuslines
		  dim_inactive = false, -- dims inactive windows
		  lualine_bold = false, -- section headers in the lualine theme = bold
		})

		vim.cmd[[colorscheme tokyonight]]
		end
}
