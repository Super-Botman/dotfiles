return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "moon",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
    init = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        mode = "tabs",
        themable = true,
        numbers = "none",
        buffer_close_icon = "",
        close_icon = "",
        indicator = { style = "none" },
        diagnostics = "nvim_lsp"
      }
    }
  },
  {
    "nvim-lualine/lualine.nvim",
    init = function()
      local custom_gruvbox = require 'lualine.themes.palenight'
      custom_gruvbox.normal.c.bg = '#00000000'
      require("lualine").setup({ options = { theme = custom_gruvbox } })
    end,
    requires = { "nvim-tree/nvim-web-devicons", opt = true }
  },
  {
    "xiyaowong/transparent.nvim",
    init = function()
      vim.g.transparent_groups = vim.list_extend(
        vim.g.transparent_groups or {},
        vim.tbl_map(function(v)
          return v.hl_group
        end, vim.tbl_values(require('bufferline.config').highlights))
      )
    end,
    opts = {
      extra_groups = {
        "NvimTreeNormal",
      }
    }
  }
}
