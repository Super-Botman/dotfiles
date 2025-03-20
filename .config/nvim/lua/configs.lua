local servers = {
  ltex = {
    ltex = {
      language = "auto" -- Override the ltex.language setting
    }
  },
  lua_ls = {
    Lua = {
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true)
      },
      telemetry = { enable = false },
      diagnostics = {
        globals = { 'vim' },
      },

    },
  },
  ["harper-ls"] = {
    isolateEnglish = true,
  }
}

require("mason-lspconfig").setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      settings = servers[server_name],
    }
  end,
}

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
  },
  filetype = "c3",
  used_by = { "c3" }
}
