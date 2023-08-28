return require('packer').startup(function(use)
	use { "catppuccin/nvim", as = "catppuccin" }
	use {
	  'nvim-tree/nvim-tree.lua',
	  requires = {
	    'nvim-tree/nvim-web-devicons', -- optional
	  },
	}
	use { "gpanders/nvim-parinfer" }
end)
