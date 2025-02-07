return {
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
}
