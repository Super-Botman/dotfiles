-- install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- package manager for lsp, dap, linters and formatters
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-lint",
  },
  -- formatter
  "stevearc/conform.nvim",
  "zapling/mason-conform.nvim",
  -- autocompletion
  {
    "neovim/nvim-lspconfig", -- REQUIRED: for native Neovim LSP integration
    lazy = false,            -- REQUIRED: tell lazy.nvim to start this plugin at startup
    dependencies = {
      { "ms-jpq/coq_nvim",       branch = "coq" },
      { "ms-jpq/coq.artifacts",  branch = "artifacts" },
      { "ms-jpq/coq.thirdparty", branch = "3p" }
    },
    init = function()
      vim.g.coq_settings = {
        auto_start = true, -- if you want to start COQ at startup
      }
    end,
  },
  -- parser
  {
    "nvim-treesitter/nvim-treesitter",
    requires = {
      "mitchellh/tree-sitter-hcl",
    },
    run = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = {
          "c",
          "c3",
          "lua",
          "vim",
          "vimdoc",
          "query",
          "elixir",
          "heex",
          "javascript",
          "html",
          "python",
          "yaml",
          "xml",
          "ruby",
          "markdown",
          "cmake",
          "typescript",
        },
        sync_install = false,
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        ignore_install = {},
        modules = {},
      })
    end,
  },
  -- theme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {}
  },
  -- files manager
  {
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons"
  },
  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    requires = { "nvim-tree/nvim-web-devicons", opt = true }
  },
  "andweeb/presence.nvim",
  -- autoformater
  "vim-autoformat/vim-autoformat",
  "elkowar/yuck.vim",
  -- live server
  {
    "barrett-ruth/live-server.nvim",
    build = "bun i -g live-server",
    cmd = { "LiveServerStart", "LiveServerStop" },
    config = true
  },

  -- mardown
  "mzlogin/vim-markdown-toc",
  "MeanderingProgrammer/render-markdown.nvim",

  { 'mrjones2014/smart-splits.nvim' }
})

require('smart-splits').setup()

require("mason").setup()

require("mason-lspconfig").setup({
  automatic_installation = true
})

local lspconfig = require("lspconfig")
require("mason-lspconfig").setup_handlers({
  function(server)
    lspconfig[server].setup({})
  end,
})

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.gotmpl = {
  install_info = {
    url = "https://github.com/ngalaiko/tree-sitter-go-template",
    files = { "src/parser.c" }
  },
  filetype = "gotmpl",
  used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl", "html" }
}

parser_config.c3 = {
  install_info = {
    url = "https://github.com/c3lang/tree-sitter-c3",
    files = { "src/parser.c", "src/scanner.c" },
    branch = "main",
  }
}


require("tokyonight").setup({
  style = "moon",
  transparent = true,     -- Enable this to disable setting the background color
  terminal_colors = true, -- used when opening a `:terminal`		
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    sidebars = "transparent",
    floats = "transparent",
  },
})

require("conform").setup({
  formatters_by_ft = {
    javascript = { "prettier" }
  },
  format_on_save = function(bufnr)
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if bufname:match("/home/botman/.local/bin") or bufname:match("/home/botman/Documents/others/projects/pwninit/tests/") then
      return
    end
    return { timeout_ms = 500, lsp_format = "fallback" }
  end,
})

require("mason-conform").setup()

require("lualine").setup()

require("presence").setup()

vim.cmd [[colorscheme tokyonight]]
vim.g.coq_settings = { auto_start = "shut-up" }
vim.g.mapleader = " "
vim.opt.mouse = ""
vim.wo.relativenumber = true
vim.wo.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2
vim.keymap.set("n", "<tab>", ":tabNext<CR>", {})
vim.keymap.set("n", "<Leader><Leader>n", ":noh<CR>", {})
vim.keymap.set("n", "<Leader>f", ":Format<CR>", {})
vim.keymap.set("n", "<C-tab>", ":tabNext<CR>", {})
vim.keymap.set("n", "<C-t>", ":tabnew<CR>", {})
vim.keymap.set("n", "<S-d>", ":lua require(\"dapui\").toggle()<CR>", {})
vim.keymap.set("n", "<M-k>", ":lua require(\"dapui\").eval()<CR>", {})
vim.filetype.on = true
vim.filetype.add({
  extension = {
    c3 = "c3",
    c3i = "c3",
    c3t = "c3",
  },
})

require("telescope").load_extension("file_browser")
require("telescope").load_extension("ui-select")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<Leader>ff", ":Telescope file_browser<CR>", {})
vim.keymap.set("n", "<Leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<Leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<Leader>fh", builtin.man_pages, {})

-- recommended mappings
-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left)
vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down)
vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up)
vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right)
-- moving between splits
vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
vim.keymap.set('n', '<C-\\>', require('smart-splits').move_cursor_previous)
-- swapping buffers between windows
vim.keymap.set('n', '<leader><leader>h', require('smart-splits').swap_buf_left)
vim.keymap.set('n', '<leader><leader>j', require('smart-splits').swap_buf_down)
vim.keymap.set('n', '<leader><leader>k', require('smart-splits').swap_buf_up)
vim.keymap.set('n', '<leader><leader>l', require('smart-splits').swap_buf_right)
