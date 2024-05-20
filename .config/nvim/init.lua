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
    -- dap
    use {
        "rcarriga/nvim-dap-ui",
        requires = {
            "jay-babu/mason-nvim-dap.nvim",
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio"
        }
    }
	-- autocompletion
	use { 'ms-jpq/coq_nvim', run = 'python3 -m coq deps' }
	use 'ms-jpq/coq.artifacts'
	use 'ms-jpq/coq.thirdparty'
	-- parser
	use {
		'nvim-treesitter/nvim-treesitter',
        requires = {
            'mitchellh/tree-sitter-hcl',
        },
        run = ':TSUpdate',
    }
	-- theme
	use 'folke/tokyonight.nvim'
	-- files manager
	use {
		"nvim-telescope/telescope-file-browser.nvim",
  		requires = {
			{'nvim-telescope/telescope.nvim'},
			{'nvim-lua/plenary.nvim'},
			{'nvim-tree/nvim-web-devicons'}
		}
	}
	-- statusline
	use {
  		'nvim-lualine/lualine.nvim',
  		requires = { 'nvim-tree/nvim-web-devicons', opt = true }
	}
    use 'andweeb/presence.nvim'
    use 'sheerun/vim-polyglot'
    -- autoformater
    use 'vim-autoformat/vim-autoformat'
    use 'elkowar/yuck.vim'
end)

local lspconfig = require('lspconfig')

require('mason').setup()
require('mason-nvim-dap').setup({
    ensure_installed = {'cppdbg'},
    handlers = {
        function(config)
          require('mason-nvim-dap').default_setup(config)
        end
    }
})
require('mason-lspconfig').setup({
	automatic_installation = true
})
require('mason-lspconfig').setup_handlers({
  function(server)
    lspconfig[server].setup({})
  end,
})

require('dapui').setup()

require('theme').setup()

require('formatter').setup()

require('lualine').setup()

vim.g.coq_settings = { auto_start = 'shut-up' }
vim.g.mapleader = ' '
vim.opt.mouse = ''
vim.wo.relativenumber = true
vim.wo.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.bo.softtabstop = 4
vim.keymap.set('n', '<tab>', ':tabNext<CR>', {})
vim.keymap.set('n', '<Leader><Leader>', ':noh<CR>', {})
vim.keymap.set('n', '<Leader>f', ':Format<CR>', {})
vim.keymap.set('n', '<tab>', ':tabNext<CR>', {})
vim.keymap.set('n', '<C-t>', ':tabnew<CR>', {})
vim.keymap.set('n', '<S-d>', ':lua require("dapui").toggle()<CR>', {})
vim.keymap.set('n', '<M-k>', ':lua require("dapui").eval()<CR>', {})

require("telescope").load_extension "file_browser"

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', ':Telescope file_browser<CR>', {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.man_pages, {})

require("presence").setup()
