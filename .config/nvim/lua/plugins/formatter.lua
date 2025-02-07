return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" }
      },
      format_on_save = function(bufnr)
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        if bufname:match("/home/botman/Documents/projects/pwninit/tests/") then
          return
        end
        return { timeout_ms = 500, lsp_format = "fallback" }
      end,
    }
  },
  {
    "zapling/mason-conform.nvim",
    opts = {}
  },
  "vim-autoformat/vim-autoformat",

  -- autocompletion
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      { "ms-jpq/coq_nvim",       branch = "coq" },
      { "ms-jpq/coq.artifacts",  branch = "artifacts" },
      { "ms-jpq/coq.thirdparty", branch = "3p" }
    },
    init = function()
      vim.g.coq_settings = {
        auto_start = true,
      }
    end
  },


}
