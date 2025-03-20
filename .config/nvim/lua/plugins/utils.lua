return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    'chomosuke/typst-preview.nvim',
    lazy = false,
    version = '1.*',
    opts = {},
  },
  "MeanderingProgrammer/render-markdown.nvim",

  {
    "barrett-ruth/live-server.nvim",
    build = "bun i -g live-server",
    cmd = { "LiveServerStart", "LiveServerStop" },
    config = true
  },
  "andweeb/presence.nvim",

  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      adapters = {
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            env = {
              url = "http://127.0.0.1:11434",
            },
            headers = {
              ["Content-Type"] = "application/json",
            },
            parameters = {
              sync = true,
            },
          })
        end,
      },

      strategies = {
        chat = {
          adapter = "ollama",
        },
        inline = {
          adapter = "ollama",
        }
      }
    }
  },
  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {}
  }
}
