-- init.lua is the config files for neovim

require('packer').startup(function(use)
	-- package manager for lsp, dap, linters and formatters
	use {
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
    		'neovim/nvim-lspconfig',
		'mfussenegger/nvim-lint',
    	}
	-- formatter
	use 'mhartington/formatter.nvim'
	-- autocompletion
	use { 'ms-jpq/coq_nvim', run = 'python3 -m coq deps' }
	use 'ms-jpq/coq.artifacts'
	use 'ms-jpq/coq.thirdparty'
	-- parser
	use {
		'nvim-treesitter/nvim-treesitter',
        	run = ':TSUpdate'
    	}
	-- theme
	use 'folke/tokyonight.nvim'
	-- files manager
	use {
		'nvim-telescope/telescope.nvim',
  		requires = { {'nvim-lua/plenary.nvim'} }
	}
	-- statusline
	use {
  		'nvim-lualine/lualine.nvim',
  		requires = { 'nvim-tree/nvim-web-devicons', opt = true }
	}
end)

local lspconfig = require('lspconfig')

require('mason').setup()
require('mason-lspconfig').setup({
	automatic_installation = true
})
require('mason-lspconfig').setup_handlers({
  function(server)
    lspconfig[server].setup({})
  end,
})

require('theme').setup()

require('formatter').setup()

require('lualine').setup()

vim.g.coq_settings = { auto_start = 'shut-up' }
vim.g.mapleader = ' '
vim.opt.mouse = ''
vim.wo.relativenumber = true
vim.wo.number = true
vim.keymap.set('n', '<tab>', ':tabNext<CR>', {})
vim.keymap.set('n', '<Leader><Leader>', ':noh<CR>', {})
vim.keymap.set('n', '<Leader>f', ':Format<CR>', {})
vim.keymap.set('n', '<tab>', ':tabNext<CR>', {})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
